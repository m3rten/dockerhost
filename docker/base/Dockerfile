FROM ubuntu:14.04
MAINTAINER Sebastian Merten <sebastian@mertenonline.de>

# set noninteractive mode to avoid 'unable to initialize frontend'-messages
ENV DEBIAN_FRONTEND noninteractive

# upgrade and install base packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -yq install \
    curl \
    wget \
