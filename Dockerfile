FROM nginx:1.17.4
ARG ESPOCRM_VERSION

RUN apt-get update && \
    apt-get install -y wget php-mailparse php-fpm php-mysql php-json php-gd php-zip php-imap php-mbstring php-curl unzip php-xml

RUN mkdir mkdir /run/php
RUN phpenmod imap mbstring
COPY ./start.sh /start.sh
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./php.ini /etc/php/7.3/fpm/php.ini
COPY ./php.ini /etc/php/7.3/cli/php.ini
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN rm -fr /usr/share/nginx/html/*

RUN cd /tmp && \
    wget -q https://www.espocrm.com/downloads/EspoCRM-${ESPOCRM_VERSION}.zip && \
    unzip EspoCRM-${ESPOCRM_VERSION}.zip && \
    rm -fr EspoCRM-${ESPOCRM_VERSION}.zip && \
    /bin/bash -c "(shopt -s dotglob; mv ./EspoCRM-${ESPOCRM_VERSION}/* /usr/share/nginx/html/)"

RUN chown -R nginx:nginx /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN find . -type d -exec chmod 755 {} + && find . -type f -exec chmod 644 {} +;
RUN find data custom client/custom -type d -exec chmod 775 {} + && find data custom client/custom -type f -exec chmod 664 {} +;
RUN chmod 775 application/Espo/Modules client/modules;

CMD ["/bin/bash","-c","/start.sh"]
