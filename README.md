**###Description about project files###**

_In this project we use mariadb:10.2 and php72._
>
>**./dockerfile/mariadb/Dockerfile**  ===> #This file used for build mariadb image
>
>**./Dockerfile**  ===> #This file used for php-app image
>
>**./docker-compose.yml**  ===> #This file contains 3 services: database(mariadb:10.2), redis, php-app
>
>**./entrypoint.sh**  ===> #This file execute the container and serve on 0.0.0.0:8080

_All of the compose variables feed on .env file in root project._

**###docker-compose.yml content###**
```
version: "3"

services:
  database:
    build:
      context: "./dockerfile/mariadb"  ===> ###Build mariadb image
    container_name: 'mariadb'
    restart: 'always'
    ports:
      - "${DB_PORT}:${DB_PORT}"  
    environment:
      MARIADB_ROOT_PASSWORD: ${DB_PASSWORD}
      MARIADB_DATABASE: ${DB_DATABASE}
      MARIADB_USER: ${DB_USERNAME}
      MARIADB_PASSWORD: ${DB_PASSWORD}
  phpapp:
    build:
     context: "."  ===> ###Build image from Dockerfile in root project
    depends_on:
      - database
      - redis
    container_name: 'phpapp'
    links:
      - database
    ports:
      - "8080:8080"  ===> ###Expose the port that project serves on
    environment:
     APP_NAME:
     APP_ENV:
     APP_KEY:
     APP_DEBUG:
     APP_LOG_LEVEL:
     APP_URL:
     DB_CONNECTION:
     DB_HOST:
     DB_PORT:
     DB_DATABASE:
     DB_USERNAME:
     DB_PASSWORD:
     BROADCAST_DRIVER:
     CACHE_DRIVER:
     SESSION_DRIVER:
     SESSION_LIFETIME:
     QUEUE_DRIVER:
     REDIS_HOST:
     REDIS_PASSWORD:
     REDIS_PORT:
     MAIL_DRIVER:
     MAIL_HOST:
     MAIL_PORT:
     MAIL_USERNAME:
     MAIL_PASSWORD:
     MAIL_ENCRYPTION:
     PUSHER_APP_ID:
     PUSHER_APP_KEY:
     PUSHER_APP_SECRET:
  redis:
    container_name: 'redis'
    image: redis:latest
    ports:
      - "${REDIS_PORT}:${REDIS_PORT}"
```

**###entrypoint.sh content###**
```
sleep 5  ===> ###It waits until mariadb completely come up
php artisan migrate --seed  ===> ###Create table in happs database. use provided user and password for login to laravel project
php artisan serve --host 0.0.0.0 --port 8080  ===>### we can use this ip/port in browser to login to laravel project
```

**###How to run###**
<br />1- clone te repo<br />
<br />2- Copy .env.sample to .env<br />
<br />3- Run docker-compose up --build<br />
