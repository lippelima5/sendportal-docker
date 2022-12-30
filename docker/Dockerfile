FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

# Instalar Requisitos
RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update -y
RUN apt-get install cron wget curl git nano grep libmemcached-dev libmcrypt-dev libxml2-dev libtool make autoconf g++ libgsasl-dev supervisor -y
RUN apt-get install php7.4 php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-pdo php7.4-redis -y 

# Copia a configuração do supervisor local para a imagem
COPY ./supervisord.conf /etc/supervisord.conf

# Setup Sendportal
WORKDIR /app
RUN git clone https://github.com/mettle/sendportal.git .
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install 

# Copia .env para local para imagem
COPY ./.env /app/.env

# CASO QUEUE_CONNECTION=database descomentar a linha abaixo e realizar migrate
# RUN php artisan queue:table

# Running Redis Queues With Laravel Horizon
RUN php artisan horizon:publish

# Ajusta as permissões
RUN chmod +x /app/artisan
RUN chown -R www-data:www-data /app/storage

# Adiciona um crontab para acionar o schedule 
RUN crontab -l | { cat; echo "* * * * * /usr/bin/php /app/artisan schedule:run >> /dev/null 2>&1"; } | crontab -
# RUN crontab -l | { cat; echo "* * * * * /usr/bin/php /app/artisan sp:campaigns:dispatch >> /dev/null 2>&1"; } | crontab -

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

EXPOSE 8181