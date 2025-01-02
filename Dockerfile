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

# Финальный образ с Nginx и Certbot
FROM nginx:alpine

# Установка Certbot для получения сертификатов
RUN apk add --no-cache certbot certbot-nginx bash

# Копируем собранные файлы из предыдущего этапа
COPY --from=builder /app/public /var/www/html

# Копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Открываем порты для Nginx и Certbot
EXPOSE 80 443

# Запуск Certbot и Nginx
CMD ["sh", "-c", "certbot --nginx --non-interactive --agree-tos --email anton.ingrish@gmail.com -d alchemical-blog.ru && nginx -g 'daemon off;'"]


