#!/bin/sh
echo Starting PHP-FPM...
service php7.0-fpm start
echo Starting NGINX...
service nginx start
echo Attempting Certificate renewall...
certbot renew
echo Running!
tail -f /dev/null
