# Bash.Im - Random Quote

Скрипт выводит случайную цитату с сайта http://bash.im из "Лучшего" за последние 5 лет. Написан на [***Windows PowerShell***](https://ru.wikipedia.org/wiki/Windows_PowerShell).

### Чтобы цитата выводилась при запуске PowerShell - нужно добавить весь код скрипта в файл профиля.
- Открываем файл профиля (из PowerShell): `notepad $profile`
- Если выходит ошибка, значит файла профиля еще нет - нужно его создать: `New-Item -path $profile -type file -force`, а потом открыть предыдущей командой
- Добавить код и сохранить файл
- Теперь случайная цитата будет выводиться при каждом запуске PowerShell
- Чтобы вывести еще одну цитату нужно набрать команду `Bash`

![Скрипт за работой](screenshot.png)

***
#### Мой первый скрипт на PowerShell написал `just4fun` изучая принцип работы PS.