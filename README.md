# dockerhost

## vagrant with docker

    vagrant up && vagrant ssh
    cd /vagrant/
    
    docker build -t "m3rten/data" data/
    docker run -i -t --name data -v /homevagrant/quizcms:/var/www m3rten/data /bin/bash
    
    docker build -t "m3rten/nginx" nginx/
    docker run -d -p 80:80 --name quizcms_nginx --volumes-from data m3rten/nginx
    
    docker kill nginx && docker rm nginx
    
    
    