FROM ubuntu:14.04
MAINTAINER Ilya Martynyuk <mescalito1990@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ARG username

RUN adduser --disabled-password --gecos '' $username
RUN echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN adduser $username sudo

RUN apt-get update \
    && apt-get -y install apache2 \
    libapache2-mod-php5 \
    php5-mysql \
    php5-gd \
    php5-curl \
    curl lynx-cur \
    mc \
	vim \
	nano \
    git \
    subversion

RUN a2enmod php5 &&\
    a2enmod rewrite &&\
    sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
    php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');" &&\
    mv composer.phar /usr/bin/composer

COPY sites-available /etc/apache2/sites-available

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80
USER $username
WORKDIR /var/www

CMD sudo su -c "/usr/sbin/apache2ctl -D FOREGROUND"
