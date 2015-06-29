#!/bin/bash

if test $# != 1
        then
                echo "Arguments: create | start | stop | rebuild | killall"
                exit 1
        fi

if test $1 == "start"
then
        docker start qcms_data
        docker start qcms_mysql
        docker start qcms_nginx
        docker attach qcms_nginx
fi

if test $1 == "stop"
then
        docker stop qcms_mysql
        docker stop qcms_nginx
fi

if test $1 == "create"
then
        ./build.sh
        docker run --name m3rten_data  m3rten/data
        docker run -d -p 3306:3306 --name m3rten_mysql --volumes-from m3rten_data m3rten/mysql
        #docker run -d -p 80:80 --name internetstore_apache --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/internetstore.ch/config/default.conf:/etc/nginx/conf.d/default.conf -v /home/vagrant/internetstore/src:/var/www/html m3rten/apache
        docker run -d -p 80:80 --name internetstore_apache --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/internetstore.ch/conf/internetstore.conf:/etc/apache2/sites-enabled/internetstore.conf -v /home/vagrant/internetstore.ch/conf/php.ini:/etc/php5/apache2/conf.d/05-internetstore.ini -v /home/vagrant/internetstore.ch/cron/:/home/cron -v /home/vagrant/internetstore.ch/src:/var/www/internetstore.dev m3rten/apache
fi

if test $1 == "rebuild"
then
        docker kill m3rten_mysql && docker rm m3rten_mysql
        docker kill internetstore_apache && docker rm internetstore_apache
        #docker kill flightlog_nginx && docker rm flightlog_nginx
        ./build.sh
        docker start m3rten_data
        docker run -d -p 3306:3306 --name m3rten_mysql --volumes-from m3rten_data m3rten/mysql
        #docker run -d -p 80:80 --name internetstore_apache --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/internetstore.ch/conf/default.conf:/etc/apache2/apache2.conf -v /home/vagrant/internetstore.ch/conf/php.ini:/usr/local/etc/php/php.ini  -v /home/vagrant/internetstore.ch/src:/var/www/internetstore.dev m3rten/apache
        docker run -d -p 80:80 --name internetstore_apache --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/internetstore.ch/conf/internetstore.conf:/etc/apache2/sites-enabled/internetstore.conf -v /home/vagrant/internetstore.ch/conf/php.ini:/etc/php5/apache2/conf.d/05-internetstore.ini -v /home/vagrant/internetstore.ch/cron/:/home/cron -v /home/vagrant/internetstore.ch/src:/var/www/internetstore.dev m3rten/apache
        #docker run -d -p 80:80 --name flightlog_nginx --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/flightlog/default.conf:/etc/nginx/conf.d/default.conf -v /home/vagrant/flightlog:/var/www/flightlog.dev/ m3rten/nginx
        #docker run -d -p 80:80 --name internetstore_apache --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/internetstore.ch/conf/internetstore.conf:/etc/apache2/sites-enabled/internetstore.conf -v /home/vagrant/internetstore.ch/conf/php.ini:/etc/php5/apache2/conf.d/05-internetstore.ini -v /home/vagrant/internetstore.ch/src:/var/www/internetstore.dev m3rten/apache
fi

if test $1 == "killall"
then
        docker kill m3rten_data && docker rm m3rten_data
        docker kill internetstore_apache && docker rm internetstore_apache
        docker kill m3rten_mysql && docker rm m3rten_mysql
fi

if test $1 == "backup"
then
        docker exec -it qcms_mysql mysqldump -hlocalhost -uadmin -p2REqhyep quizcms > ../backup/quizcms.sql
fi