FROM m3rten/base:latest
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# install salt
RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository -y ppa:saltstack/salt && \
    apt-get update && \
    apt-get install -y \
    salt-master \
    salt-minion \
    salt-cloud
#RUN wget -O - https://bootstrap.saltstack.com | sudo sh

ADD ./startup.sh /root/startup.sh
RUN chmod 744 /root/startup.sh
ENTRYPOINT /root/startup.sh