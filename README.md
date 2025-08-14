# Blockassist by Gensyn
Gensyn — це Layer-1 блокчейн-протокол, який об'єднує обчислювальні ресурси з усього світу в єдиний суперкомп'ютер для тренування моделей глибокого навчання. 
Проєкт дозволяє будь-кому — від власників домашніх ПК до операторів дата-центрів — надавати свої обчислювальні потужності та отримувати винагороду за участь у тренуванні ШІ.

- Інвестували: 56 000 000$
- Інвестори: a16z, CoinFund, Maven 11 Capital та інші
- Характеристики: 8CPU / 16GB RAM / ~100GB SSD 
- Орендувати сервер: Сloudblast.io, Aeza, Contabo
- Чат і канал із підтримкою: https://t.me/+MhR1Y8cXq_5iYmM6, https://t.me/+l0OxVdWZEXFhMDMy
# Встановлення ноди

## Встановлюємо [MobaXterm](https://mobaxterm.mobatek.net/)

- Підключаємося на орендований сервер через root
- Вводимо команду
```
wget --no-cache -q -O blockassist.sh https://raw.githubusercontent.com/Baryzhyk/Blockassist/refs/heads/main/blockassist.sh && chmod +x blockassist.sh && ./blockassist.sh
```
- Вибираємо встановити VNC
- Після завершення встановлення ви отримаєте логін та пароль для входу
- Підключіться до серверу через VNC
- Запустіть скрипт ще раз
```
wget --no-cache -q -O blockassist.sh https://raw.githubusercontent.com/Baryzhyk/Blockassist/refs/heads/main/blockassist.sh && chmod +x blockassist.sh && ./blockassist.sh
```
- Виберіть встановити вузол
- Перейдіть до [huggingface](https://huggingface.co/settings/tokens)
- Cтворіть токен з правами `write`
- Та вставте в термінал при запиті
- Після завершення встановлення запустіть вузол командою
- `cd ~/blockassist && python run.py`
