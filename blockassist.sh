#!/bin/bash

# Перевірка наявності необхідних утиліт, встановлення за потреби
if ! command -v figlet &> /dev/null; then
    echo "figlet не знайдено. Встановлюємо..."
    sudo apt update && sudo apt install -y figlet
fi

if ! command -v whiptail &> /dev/null; then
    echo "whiptail не знайдено. Встановлюємо..."
    sudo apt update && sudo apt install -y whiptail
fi

# Кольори
GOLD='\033[38;5;220m'
NC='\033[0m' # Скидання кольору

# Завантаження та відображення логотипу
bash <(curl -s https://raw.githubusercontent.com/Baryzhyk/nodes/refs/heads/main/logo.sh)

# Функція анімації
animate_loading() {
    while true; do
        for dots in "." ".." "..."; do
            printf "\r${GOLD}Завантажуємо меню${NC}${dots} "
            sleep 0.3
        done
    done
}

# Запускаємо анімацію у фоновому режимі
animate_loading &
ANIM_PID=$!

# Імітація завантаження
sleep 3

# Зупиняємо анімацію
kill $ANIM_PID >/dev/null 2>&1
wait $ANIM_PID 2>/dev/null
printf "\r${GOLD}Меню завантажено!${NC}     \n"

# Меню вибору
CHOICE=$(whiptail --title "Меню керування Aztec" \
  --menu "Оберіть потрібну дію:" 20 70 9 \
    "1" "Встановити vnc" \
    "2" "Встановити вузол" \
    "3" "Запустити вузол" \
    "4" "Видалити вузол" \
    "5" "Вийти з меню" \
  3>&1 1>&2 2>&3)

# Обробка вибору
case $CHOICE in
    1) echo "Встановлюємо VNC..." ;;
    2) echo "Встановлюємо вузол..." ;;
    3) echo "Запускаємо вузол..." ;;
    4) echo "Видаляємо вузол..." ;;
    5) echo "Вихід з меню..." ;;
    *) echo "Невідомий вибір" ;;
esac

case $CHOICE in
    1)
        echo -e "${GOLD}Встановлюємо vnc...${NC}"

        TARGET_SWAP_GB=32
        CURRENT_SWAP_KB=$(free -k | awk '/Swap:/ {print $2}')
        CURRENT_SWAP_GB=$((CURRENT_SWAP_KB / 1024 / 1024))

        if [ "$CURRENT_SWAP_GB" -lt "$TARGET_SWAP_GB" ]; then
            swapoff -a
            sed -i '/swap/d' /etc/fstab
            fallocate -l ${TARGET_SWAP_GB}G /swapfile
            chmod 600 /swapfile
            mkswap /swapfile
            swapon /swapfile
            echo '/swapfile none swap sw 0 0' >> /etc/fstab
            echo "vm.swappiness = 10" >> /etc/sysctl.conf
            sysctl -p
        fi

        apt update -y && apt upgrade -y
        apt install -y git curl wget build-essential python3 python3-venv python3-pip screen yarn net-tools gnupg
        sleep 1
        wget --no-cache -q -O vnc.sh https://raw.githubusercontent.com/Baryzhyk/Blockassist/refs/heads/main/vnc.sh && chmod +x vnc.sh && ./vnc.sh
    ;;
    
    2) 
        echo -e "${GOLD}Встановлюємо ноду...${NC}"
        wget --no-cache -q -O Blockassist.sh https://raw.githubusercontent.com/Baryzhyk/Blockassist/refs/heads/main/Blockassist.sh && chmod +x Blockassist.sh && ./Blockassist.sh
    ;;
    
    3)
        echo -e "${GOLD}Запускаємо вузол...${NC}"
       cd ~/blockassist && python run.py
    ;;
    
    4)
        echo -e "${GOLD}Видаляємо вузол...${NC}"
        rm -rf blockassist
        rm -rf blockassist.sh
        rm -rf Blockassist.sh
        rm -rf vnc.sh
    ;;
    
    5)
        echo -e "${GOLD}Вихід з меню.${NC}"
        exit 0
    ;;
esac
