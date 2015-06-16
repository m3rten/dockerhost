# Dockerhost

A single Vagrant environment to host multiple development environments in docker containers.
Map your project folders to vagrant by editing config.yaml
Example:

## prerequesites on Windows

https://msysgit.github.io/
tortoise git

- cygwin, with rsync
- vagrant
- git


    - map: /your/local/project
      to: /home/vagrant/project

## Startup vagrant with docker

    vagrant up && vagrant ssh
    
## Build an run docker images    
    
    cd /vagrant/
    docker build -t "data" data/
    docker run -i -t --name data -v /home/vagrant/project:/var/www data /bin/bash
    
    docker build -t "nginx" nginx/
    docker run -d -p 80:80 --name nginx --volumes-from data nginx
 
## Cleanup    
    docker kill nginx && docker rm nginx
    
    
    