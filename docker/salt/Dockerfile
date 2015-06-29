FROM m3rten/base:latest
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# install wget + salt
RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository -y ppa:saltstack/salt && apt-get update
RUN apt-get update && \
    apt-get install -y \
    salt-master \
    salt-minion \
    salt-cloud
#RUN wget -O - https://bootstrap.saltstack.com | sudo sh
