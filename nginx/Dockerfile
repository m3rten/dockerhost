FROM ubuntu:14.04
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# install nginx
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
COPY default.conf /etc/nginx/sites-available/default

# install PHP
RUN apt-get -y install php5-fpm php5-mysql php5-cli php5-dev php5-gd php5-mcrypt php5-json php5-curl php5-xdebug php5-intl
RUN sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini

# expose ports
EXPOSE 80

# start services
CMD service php5-fpm start && nginx