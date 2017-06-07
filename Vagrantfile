require 'json'
require 'yaml'

# cygwin workaround
ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"

configfile = File.expand_path("./config.yml")
require_relative 'dockerhost.rb'

Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/xenial64"

    #config.vbguest.auto_update = false

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
#    config.vm.network "forwarded_port", guest: 10022, host: 10022

    # copy ssh key for git cloning
    config.vm.synced_folder "~/.ssh", "/home/vagrant/conf"
    #config.vm.provision "shell", inline: " cp /home/vagrant/conf/id_rsa /home/vagrant/.ssh/id_rsa"

    # Map folders
    #config.vm.synced_folder ".", "/vagrant"

    # Read additional configfile
    Dockerhost.configure(config,YAML::load(File.read(configfile)))

    # Swap
    config.vm.provision "shell", inline: "sudo mkdir -p /var/cache/swap"
    config.vm.provision "shell", inline: "sudo fallocate -l 2G /var/cache/swap/swap0"
    config.vm.provision "shell", inline: "sudo dd if=/dev/zero of=/var/cache/swap/swap0 bs=1M count=2048"
    config.vm.provision "shell", inline: "sudo chmod 0600 /var/cache/swap/swap0"
    config.vm.provision "shell", inline: "sudo mkswap /var/cache/swap/swap0"
    config.vm.provision "shell", inline: "sudo swapon /var/cache/swap/swap0"
    config.vm.provision "shell", inline: " echo '/var/cache/swap/swap0    none    swap    sw      0 0' | sudo tee -a /etc/fstab"

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
                                        htop"

    # PHP 7
    config.vm.provision "shell", inline: "LC_ALL=en_US.UTF-8 sudo add-apt-repository ppa:ondrej/php && sudo apt-get update"
    config.vm.provision "shell", inline: "sudo apt-get update && apt-get -y -qq install php7.0 \
                                        php7.0-cli \
                                        php7.0-curl \
                                        php7.0-json \
                                        php7.0-gd \
                                        php7.0-intl \
                                        php7.0-mbstring \
                                        php7.0-mcrypt \
                                        php7.0-dev \
                                        php7.0-xml \
                                        php7.0-mysql \
                                        php7.0-zip"

    # mariadb / mysql client
    config.vm.provision "shell", inline: "sudo apt-get install -y -qq mariadb-client-core-10.0"

    # install docker manually
    config.vm.provision "shell", inline: "sudo apt-get install -y -qq apt-transport-https ca-certificates curl software-properties-common"
    config.vm.provision "shell", inline: "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
    config.vm.provision "shell", inline: "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\""
    config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y -qq docker-ce docker-compose"
    #config.vm.provision "shell", inline: "sudo usermod -aG docker vagrant"
    config.vm.provision "shell", inline: "sudo usermod -aG docker ubuntu"
    config.vm.provision "shell", inline: "docker pull ubuntu:14.04"
    config.vm.provision "shell", inline: "docker pull ubuntu:16.04"

    # install mongodb client
    config.vm.provision "shell", inline: "sudo apt-get install -y -qq mongodb-clients"

    # composer
    config.vm.provision "shell", inline: "curl -sS https://getcomposer.org/installer | php && \
                        mv composer.phar /usr/local/bin/composer && \
                        composer config -g github-oauth.github.com fdeec5aa02e0f0bd6a1c0f184cd620480ad59682"

    # nodejs, npm, gulp, bower
    config.vm.provision "shell", inline: "curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
                        sudo apt-get update && sudo apt-get install -y -qq  nodejs && \
                        sudo npm install -g npm@latest && \
                        sudo npm install -g gulp bower"

    # yarn
    config.vm.provision "shell", inline: "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -"
    config.vm.provision "shell", inline: "echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list"
    config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y -qq yarn"

    # imapsync
    config.vm.provision "shell", inline: "sudo apt-get install -y -qq \
                                          libauthen-ntlm-perl \
                                          libcrypt-ssleay-perl \
                                          libdigest-hmac-perl \
                                          libfile-copy-recursive-perl \
                                          libio-compress-perl \
                                          libio-socket-inet6-perl \
                                          libio-socket-ssl-perl \
                                          libio-tee-perl \
                                          libmodule-scandeps-perl \
                                          libnet-ssleay-perl      \
                                          libpar-packer-perl \
                                          libreadonly-perl \
                                          libterm-readkey-perl \
                                          libtest-pod-perl \
                                          libtest-simple-perl     \
                                          libunicode-string-perl \
                                          liburi-perl \
                                          cpanminus"

    config.vm.provision "shell", inline: "sudo cpanm Data::Uniqid Mail::IMAPClient"
    config.vm.provision "shell", inline: "sudo rm -rf /home/imapsync/ && sudo git clone https://github.com/imapsync/imapsync.git /home/imapsync/"
    config.vm.provision "shell", inline: "sudo cp /home/imapsync/imapsync /usr/bin/"

    # uninstall apache2 because it blocks port 80
    config.vm.provision "shell", inline: "apt-get remove apache2 -y -qq"

    # cleanup
    config.vm.provision "shell", inline: "apt-get autoremove -y -qq"

    # Salt
    # Salt repository key
    #  config.vm.provision "shell", inline: "sudo add-apt-repository -y ppa:saltstack/salt"
    #  config.vm.provision "shell", inline: "sudo apt-get install -y \
    #                                        salt-master \
    #                                        salt-minion \
    #                                        salt-cloud"
    #  config.vm.provision "shell", inline: "service salt-minion restart"
end