require 'json'
require 'yaml'
configfile = File.expand_path("./config.yaml")
require_relative 'dockerhost.rb'

Vagrant.configure("2") do |config|

  # Map folders
  config.vm.synced_folder ".", "/vagrant"

  # Read additional configfile
  Dockerhost.configure(config,YAML::load(File.read(configfile)))

  # Timezone
  config.vm.provision "shell", inline: "sudo echo \"Europe/Berlin\" | sudo tee /etc/timezone"
  config.vm.provision "shell", inline: "sudo dpkg-reconfigure -f noninteractive tzdata"

  # Salt repository key
  config.vm.provision "shell", inline: "sudo add-apt-repository -y ppa:saltstack/salt"

  # update and upgrade
  config.vm.provision "shell", inline: "sudo apt-get update -y && sudo apt-get upgrade -y"

  # Tools
  config.vm.provision "shell", inline: "sudo apt-get install -y \
                                        build-essential \
                                        libssl-dev \
                                        python-software-properties \
                                        software-properties-common
                                        curl \
                                        git \
                                        wget \
                                        htop \
                                        php5-cli \
                                        php5-json \
                                        php5-curl \
                                        apache2-utils \"

  # Salt
  config.vm.provision "shell", inline: "sudo apt-get install -y \
                                        salt-master \
                                        salt-minion \
                                        salt-cloud"
  config.vm.provision "shell", inline: "service salt-minion restart"

  # install docker manually
  config.vm.provision "shell", inline: "sudo curl -sSL https://get.docker.com/ | sh"
  config.vm.provision "shell", inline: "sudo usermod -aG docker vagrant"
  config.vm.provision "shell", inline: "docker pull ubuntu:14.04"

  # cleanup
  config.vm.provision "shell", inline: "apt-get autoremove -y"
end