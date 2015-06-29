#!/bin/bash

docker build -t "m3rten/base" ./base
docker build -t "m3rten/data" ./data
docker build -t "m3rten/nginx" ./nginx
docker build -t "m3rten/mysql" ./mysql
docker build -t "m3rten/apache" ./apache
docker build -t "m3rten/salt" ./salt
