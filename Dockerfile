FROM dockette/php:7.1-fpm

RUN mkdir /app

WORKDIR /app

COPY . /app

EXPOSE 8080/tcp

RUN composer update

entrypoint ["/bin/sh", "entrypoint.sh"]
