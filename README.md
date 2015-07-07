# Dockerhost

A single Vagrant environment to host multiple development environments in docker containers.
Map your project folders to vagrant by editing config.yaml
Example:

## prerequesites on Windows

https://msysgit.github.io/
tortoise git

- cygwin, with rsync, wget, curl
- vagrant
- git

## Service & Servers

- Docker Registry
- Jenkins 
- Salt Master
- Docker MySQL-Backup

## config.yaml

    - map: /your/local/project
      to: /home/vagrant/project
      type: rsync
      excludes: ["backup","src/templates_c","src/admin/templates_c"]

      
## MySQL Backup & Restore      

### Backup    
    docker run -it --rm -v $(pwd):/var/backups --link m3rten_mysql:mysql --volumes-from m3rten_data m3rten/mysql /bin/bash -c "/root/backup.sh"

### Restore
    docker exec -i m3rten_mysql mysql -uadmin -plocalpw < backup.sql

## Vagrant

### Startup vagrant with docker

    vagrant up && vagrant ssh
   
### Vagrant & rsync
    
- exclude folders written to by webapps (cache dir, etc.)
- make excluded folder writable
    
## Build an run docker images    
    
    cd /vagrant/
    docker build -t "data" data/
    docker run -i -t --name data -v /home/vagrant/project:/var/www data /bin/bash
    
    docker build -t "nginx" nginx/
    docker run -d -p 80:80 --name nginx --volumes-from data nginx
 
## Cleanup    
    docker kill nginx && docker rm nginx
    
    
    