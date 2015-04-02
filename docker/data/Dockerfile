FROM ubuntu:14.04
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# set noninteractive mode to avoid 'unable to initialize frontend'-messages
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /var/log/nginx
RUN mkdir /var/log/apache2
RUN mkdir /var/log/mysql
RUN mkdir /var/www

VOLUME ["/var/www","/var/log/", "/usr/share/nginx/html/", "/var/lib/mysql"]