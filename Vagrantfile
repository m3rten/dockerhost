require 'json'
require 'yaml'

# cygwin workaround
ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"

configfile = File.expand_path("./config.yml")
require_relative 'dockerhost.rb'

Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/trusty64"

    # give our box a name and hostname
    config.vm.hostname = "dockerhost"
    config.vm.define "dockerhost" do |d|
    end

    # fix networking timeouts (windows 10)
    config.vm.provider "virtualbox" do |v|
        v.name = "dockerhost"
        v.memory = 2048
        v.cpus = 2
        v.auto_nat_dns_proxy = false
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    end

    # Configure A Private Network IP
    config.vm.network :private_network, ip: "192.168.50.50"

    # Configure Port Forwarding To The Box
    config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 8085, host: 8085
    config.vm.network "forwarded_port", guest: 443, host: 443
    config.vm.network "forwarded_port", guest: 3306, host: 33060
    config.vm.network "forwarded_port", guest: 10022, host: 10022
    config.vm.network "forwarded_port", guest: 27017, host: 27017
    config.vm.network "forwarded_port", guest: 9091, host: 9091
    config.vm.network "forwarded_port", guest: 3000, host: 3000
    config.vm.network "forwarded_port", guest: 3001, host: 3001
#    config.vm.network "forwarded_port", guest: 10080, host: 10080
#    config.vm.network "forwarded_port", guest: 10022, host: 10022

    # copy SSH key for git clone
    config.vm.synced_folder "C:\\tools\\cygwin64\\home\\s.merten\\.ssh", "/home/vagrant/conf"
    config.vm.provision "shell", :inline => "cp /home/vagrant/conf/id_rsa /home/vagrant/.ssh/id_rsa"

    # Map folders
    #config.vm.synced_folder ".", "/vagrant"

    # Read additional configfile
    Dockerhost.configure(config,YAML::load(File.read(configfile)))

    # Timezone
    config.vm.provision "shell", inline: "sudo echo \"Europe/Berlin\" | sudo tee /etc/timezone"
    config.vm.provision "shell", inline: "sudo dpkg-reconfigure -f noninteractive tzdata"

    # update and upgrade
    config.vm.provision "shell", inline: "sudo apt-get update -y  -qq && sudo apt-get upgrade -y -qq"

    # Tools
    config.vm.provision "shell", inline: "sudo apt-get install -y -qq \
                                        build-essential \
                                        libssl-dev \
                                        python-software-properties \
                                        software-properties-common \
                                        curl \
                                        git \
                                        wget \
                                        htop \
                                        php5-cli \
                                        php5-json \
                                        php5-curl \
                                        apache2-utils"

    # Salt
    # Salt repository key
    #  config.vm.provision "shell", inline: "sudo add-apt-repository -y ppa:saltstack/salt"
    #  config.vm.provision "shell", inline: "sudo apt-get install -y \
    #                                        salt-master \
    #                                        salt-minion \
    #                                        salt-cloud"
    #  config.vm.provision "shell", inline: "service salt-minion restart"

    # install docker manually
    config.vm.provision "shell", inline: "sudo curl -sSL https://get.docker.com/ | sh"
    config.vm.provision "shell", inline: "sudo usermod -aG docker vagrant"
    config.vm.provision "shell", inline: "docker pull ubuntu:14.04"

    # install mongodb client
    config.vm.provision "shell", inline: "sudo apt-get install -y -qq mongodb-clients"

    # composer
    config.vm.provision "shell", inline: "curl -sS https://getcomposer.org/installer | php && \
                        mv composer.phar /usr/local/bin/composer && \
                        composer config -g github-oauth.github.com  3e3ad2a3072d8cb766e80691ffc9ff538782da75"

    # nodejs, npm, gulp, bower
    config.vm.provision "shell", inline: "curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash - && \
                        sudo apt-get install -y -qq  nodejs && \
                        npm install -g npm@latest && \
                        npm install -g gulp bower"

    # cleanup
    config.vm.provision "shell", inline: "apt-get autoremove -y -qq"
end