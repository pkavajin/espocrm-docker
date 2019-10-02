#!/bin/sh

php-fpm7.3 -F -O &
nginx -g "daemon off;"