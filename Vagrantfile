require 'json'
require 'yaml'
ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"

configfile = File.expand_path("./config.yaml")
require_relative 'dockerhost.rb'

Vagrant.configure("2") do |config|

  # Map folders
  config.vm.synced_folder ".", "/vagrant"

  Dockerhost.configure(config,YAML::load(File.read(configfile)))

  # Timezone
  config.vm.provision "shell", inline: "sudo echo \"Europe/Berlin\" | sudo tee /etc/timezone"
  config.vm.provision "shell", inline: "sudo dpkg-reconfigure -f noninteractive tzdata"

  # Tools
  config.vm.provision "shell", inline: "apt-get update -y && sudo apt-get upgrade -y && apt-get install -y \
                                        build-essential \
                                        curl \
                                        git \
                                        libssl-dev man \
                                        wget \
                                        htop \
                                        php5-cli \
                                        php5-json \
                                        php5-curl \
                                        apache2-utils \
                                        python-software-properties \
                                        software-properties-common"

  # Salt
  config.vm.provision "shell", inline: "add-apt-repository -y ppa:saltstack/salt && \
                                        apt-get update && apt-get install -y \
                                        salt-master \
                                        salt-minion \
                                        salt-cloud"
  config.vm.provision "shell", inline: "service salt-minion restart"

  # install docker manually
  config.vm.provision "shell", inline: "curl -sSL https://get.docker.com/ | sh"

  # Guest additions workaround
  #config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/4.3.28/VBoxGuestAdditions_4.3.28.iso"

  # installs Docker and pull ubuntu image
  #config.vm.provision "docker", version "1.8.1" do |docker|
  #  docker.pull_images "ubuntu:14.04"
  #end

    #config.vm.provision "docker",
    #  version: "1.8.1",
    #  images: ["ubuntu:14.04"]


end