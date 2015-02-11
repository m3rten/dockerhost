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
        docker run --name m3rten_data -v /home/vagrant/notexpired/src:/var/www/notexpired m3rten/data
        docker run -d -p 3306:3306 --name m3rten_mysql --volumes-from m3rten_data m3rten/mysql
        #docker run -i -t -p 80:80 --name notexpired_nginx --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/notexpired/conf/default.conf:/etc/nginx/conf.d/default.conf m3rten/nginx /bin/bash
        docker run -d -p 80:80 --name notexpired_nginx --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/notexpired/conf/default.conf:/etc/nginx/conf.d/default.conf m3rten/nginx
fi

if test $1 == "rebuild"
then
        docker kill m3rten_mysql && docker rm m3rten_mysql
        docker kill notexpired_nginx && docker rm notexpired_nginx
        ./build.sh
        docker start m3rten_data
        docker run -d -p 3306:3306 --name m3rten_mysql --volumes-from m3rten_data m3rten/mysql
        docker run -d -p 80:80 --name notexpired_nginx --link m3rten_mysql:mysql --volumes-from m3rten_data -v /home/vagrant/notexpired/conf/default.conf:/etc/nginx/conf.d/default.conf m3rten/nginx
fi

if test $1 == "killall"
then
        docker kill m3rten_data && docker rm m3rten_data
        docker kill notexpired_nginx && docker rm notexpired_nginx
        docker kill m3rten_mysql && docker rm m3rten_mysql
fi

if test $1 == "backup"
then
        docker exec -it qcms_mysql mysqldump -hlocalhost -uadmin -p2REqhyep quizcms > ../backup/quizcms.sql
fi
