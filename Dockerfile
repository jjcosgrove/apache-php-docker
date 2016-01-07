FROM debian:latest
MAINTAINER Jonathan James Cosgrove

ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_DOCUMENTROOT /var/www
ENV LANG C

RUN apt-get update && apt-get -y install apache2 \
    php5 \
    libapache2-mod-php5 \
    php5-curl \
    php5-gd \ 
    php5-mcrypt \
    php5-mysql \
    php5-redis \
    php5-apcu

RUN awk '/<Directory \/var\/www\/>/,/AllowOverride None/{sub("None", "All",$0)}{print}'  /etc/apache2/apache2.conf >apache2.conf.temp && mv apache2.conf.temp /etc/apache2/apache2.conf
RUN sed -i 's/\/html//g' /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/html
RUN mkdir -p /var/lock/apache2 /var/run/apache2

COPY vhosts.conf /etc/apache2/sites-available/vhosts.conf
COPY index.php /var/www/index.php

RUN a2ensite vhosts \
    && a2enmod vhost_alias \
    && a2enmod proxy \
    && a2enmod rewrite \
    && service apache2 restart

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
