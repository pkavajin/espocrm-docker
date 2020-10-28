#!/bin/sh

cp -r /usr/share/nginx/html/___hackz/* /usr/share/nginx/html

if [ -d "/usr/share/nginx/html/data/___plugins" ]
then
    cp -r /usr/share/nginx/html/data/___plugins/* /usr/share/nginx/html
fi

php-fpm7.3 -F -O &
nginx -g "daemon off;"