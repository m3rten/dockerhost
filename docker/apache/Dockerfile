FROM php:5.6-apache
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# set noninteractive mode to avoid 'unable to initialize frontend'-messages
ENV DEBIAN_FRONTEND noninteractive
# update
RUN apt-get update && apt-get -y upgrade

# install PHP-FPM
RUN apt-get update && apt-get -y install php5-dev php5-gd php5-mcrypt php5-json php5-xdebug php5-intl

# enable mcrypt for php
#RUN ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/fpm/conf.d/20-mcrypt.ini \
#    && ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini