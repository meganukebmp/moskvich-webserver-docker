FROM ubuntu:16.04

# install all the packages we need
# and delete a file that might conflict
RUN apt-get update \
    && apt-get install --assume-yes \
    software-properties-common \
    nginx \
    php-fpm \
    php-gd \
    && rm /etc/nginx/sites-available/default \
    && rm /etc/nginx/sites-enabled/default \
    && add-apt-repository ppa:certbot/certbot \
    && apt-get update \
    && apt-get install --assume-yes python-certbot-nginx

# copy our configuration files and startup script
COPY config/php.ini /etc/php/7.0/fpm/php.ini
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /tmp/entrypoint.sh
COPY config/certbot_cron /etc/cron.d/certbot

# make sure entrypoint is runnable
RUN chmod +x /tmp/entrypoint.sh

# state which volumes are to be mounted
VOLUME ["/var/www", "/etc/letsencrypt/", "/etc/nginx/sites-enabled/"]

# allow exposure of port 80 (HTTP) and port 443 (SSL/HTTPS)
EXPOSE 80 443

# execute our entrypoint script, on container init
CMD ["/tmp/entrypoint.sh"]
