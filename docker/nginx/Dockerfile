FROM m3rten/base:latest
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# install nginx
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y nginx

# install PHP-FPM
RUN apt-get update && apt-get -y install php5-fpm php5-mysql php5-cli php5-dev php5-gd php5-mcrypt php5-json php5-curl php5-xdebug php5-intl
RUN sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php5/fpm/php.ini

# enable mcrypt for php
RUN ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/fpm/conf.d/20-mcrypt.ini \
    && ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini

# copy Nginx config
ADD default.conf /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/nginx.conf

# NodeJS and npm with NVM
RUN apt-get update && apt-get install -y build-essential libssl-dev
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 0.12.2
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

# composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

EXPOSE 80 443

ADD ./startup.sh /root/startup.sh
RUN chmod 744 /root/startup.sh

ENTRYPOINT /root/startup.sh
