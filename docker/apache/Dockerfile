FROM ubuntu:14.04
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    curl \
    apache2 \
    libapache2-mod-php5 \
    php5-mysql \
    php5-gd \
    php5-curl \
    php-apc && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && apt-get install -y wget imagemagick php5-imagick

# Add IonCube Loaders
RUN mkdir /tmp/ioncube_install
WORKDIR /tmp/ioncube_install
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O /tmp/ioncube_install/ioncube_loaders_lin_x86-64.tar.gz
RUN tar zxf /tmp/ioncube_install/ioncube_loaders_lin_x86-64.tar.gz
RUN mkdir /usr/local/ioncube
RUN mv /tmp/ioncube_install/ioncube/ioncube_loader_lin_5.5.so /usr/local/ioncube/
RUN rm -rf /tmp/ioncube_install

# mod_rewrite
RUN a2enmod rewrite

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#ADD internetstore.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
#RUN a2ensite internetstore.conf

# Logging
RUN mkdir -p /var/log/apache2
RUN chmod 755 /var/log/apache2

# Expose port 80 to the host machine
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
#CMD ["/usr/sbin/apache2ctl -D FOREGROUND"]