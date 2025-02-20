---
date: 2025-02-02
title: "Очистка диска на Linux"
taxonomies:
  tags:
    - linux
extra:
  custom_props:
    time: 14:18
    type: synopsis
    theme: linux
    status: writing
---
## 1. Очистка пакетов
Для Arch Linux
### 1.1. Тяжёлые пакеты
```sh
pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4 $5, name}' | sort -hr | head -n 20
```
- Покажет **20 самых тяжёлых пакетов**

### 1.2. Найти неиспользуемые зависимости
```sh
pacman -Qdtq
```
- **Осторожно!** Там могут быть важные пакеты, которые просто не используются никем, это не обязательное условие для их удаления
- Удалить срезу всё из этого списка можно так:
```sh
sudo pacman -Rns $(pacman -Qdtq)
```

### 1.3. Поиск редко используемых пакетов
```sh
expac --timefmt='%Y-%m-%d %T' '%l %n' | sort | head -n 20
```
- Выведет **20 самых давно неиспользуемых** пакетов

## 2. Очистка файлов
Для Arch Linux и не только
### 2.1. Самый большие директории в `home`
```sh
du -h ~/ --max-depth=1 | sort -hr | head -n 15
```
### 2.2 Самый большие файлы в `home`
```sh
find ~/ -type f -exec du -Sh {} + | sort -rh | head -n 20
```

### 2.3 paccache (очистка кеша пакетов pacman)
```sh
sudo paccache -r
```
- Удаляет старые версии пакетов, оставляя только **текущую и последнюю предыдущую** версию
Полная очистка:
```sh
sudo paccache -r -k 0
```
- Удалит **все старые версии пакетов**, оставив только установленные


