# Используем базовый образ с Zola
FROM rust:alpine as builder

# Установка необходимых пакетов
RUN apk add --no-cache zola nginx bash

# Установка рабочего каталога
WORKDIR /app

# Копирование файлов проекта
COPY . /app

# Сборка сайта с помощью Zola
RUN zola build

# Финальный образ
FROM nginx:alpine

# Копируем собранные файлы в директорию nginx
COPY --from=builder /app/public /var/www/html

# Копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Открываем порт для NGINX
EXPOSE 80

# Запуск NGINX
CMD ["nginx", "-g", "daemon off;"]

