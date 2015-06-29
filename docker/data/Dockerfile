FROM m3rten/base:latest
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

RUN mkdir /var/log/nginx
RUN mkdir /var/log/apache2
RUN mkdir /var/log/mysql
RUN mkdir /var/www

VOLUME ["/var/www","/var/log/", "/usr/share/nginx/html/", "/var/lib/mysql"]