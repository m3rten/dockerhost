#!/bin/bash

docker build -t "m3rten/data" ./data
docker build -t "m3rten/nginx" ./nginx
docker build -t "m3rten/mysql" ./mysql
