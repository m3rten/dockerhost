FROM ubuntu:14.04
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# set noninteractive mode to avoid 'unable to initialize frontend'-messages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y

# install wget + salt
RUN apt-get install -y python-software-properties && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:saltstack/salt && apt-get update
RUN apt-get install -y wget && \
    apt-get install -y salt-master && \
    apt-get install -y salt-minion
#RUN wget -O - https://bootstrap.saltstack.com | sudo sh
