# dockerhost

## vagrant with docker

    vagrant up && vagrant ssh
    cd /home/vagrant/backend.quizcms.dev
    
    docker build -t "quizcms/backend_data" data/
    docker run -i -t --name quizcms_backend_data -v /home/vagrant/backend.quizcms.dev:/var/www quizcms/backend_data /bin/bash
    
    docker build -t "quizcms/backend_nginx" nginx/
    docker run -d -p 80:80 --name quizcms_backend_nginx --volumes-from quizcms_backend_data quizcms/backend_nginx
    
    
    docker run -i -t -p 3306:3306 --name quizcms_backend_mysql --volumes-from quizcms_backend_data quizcms/backend_mysql /bin/bash
    
    docker kill quizcms_backend_data && docker rm quizcms_backend_data 
    docker kill quizcms_backend_mysql && docker rm quizcms_backend_mysql 
    docker kill quizcms_backend_nginx && docker rm quizcms_backend_nginx
    
## mysql backup
    
    docker run -i -t --rm -v $(pwd):/backup  --volumes-from quizcms_backend_data --link=quizcms_backend_mysql:mysql quizcms/backend_mysql /bin/bash
    
## inspect data volume
    
    docker run -it --rm --volumes-from quizcms.dev_data ubuntu:14.04 /bin/bash
    
## env vars    
    docker run -it --rm -e REPO=git@git.codingbase.org:quiz.git -e DOMAIN=test.quizcms.com -e REPODIR=src -e STORAGEDIR=app/storage --volumes-from qcms_data quizcms/gitclone

## todos für deployment
    
     Berechtigung storage folder
     php artisan migrate
     php artisan db:seed
     php artisan optimize
     error reporting off
     .env für production integrieren
     
## production deployment 

    cd /root/quizcms
    git pull
    cd backend/deploy
    php deploy.php create --env=prod
    php deploy.php rebuild  --env=prod
    cd /var/www/quizcms.com
    php artisan migrate
    php artisan db:seed
    crontab -e
    -> */1 * * * * cd /root/quizcms/backend/deploy/ && /usr/bin/php /root/quizcms/backend/deploy/deploy.php subdomains --env=prod >> /root/quizcms/backend/deploy/deploy.log 2>&1
    