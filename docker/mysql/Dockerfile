FROM m3rten/base:latest
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# install mysql
RUN apt-get -y install mysql-client mysql-server

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD ./startup.sh /root/startup.sh
RUN chmod 744 /root/startup.sh

EXPOSE 3306

CMD /root/startup.sh