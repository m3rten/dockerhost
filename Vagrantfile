require 'json'
require 'yaml'

configfile = File.expand_path("./config.yaml")
require_relative 'dockerhost.rb'

Vagrant.configure("2") do |config|

  # Map folders
  config.vm.synced_folder ".", "/vagrant"

  Dockerhost.configure(config,YAML::load(File.read(configfile)))

  # Provisioning
  config.vm.provision "shell", inline: "sudo echo \"Europe/Berlin\" | sudo tee /etc/timezone"
  config.vm.provision "shell", inline: "sudo dpkg-reconfigure -f noninteractive tzdata"
  config.vm.provision "shell", inline: "sudo apt-get update -y && sudo apt-get upgrade -y"
  config.vm.provision "shell", inline: "sudo apt-get install -y build-essential curl git libssl-dev man wget htop"
  config.vm.provision "shell", inline: "sudo apt-get install -y apache2-utils"
  config.vm.provision "shell", inline: "sudo apt-get install -y php5-cli php5-json php5-curl"
  #config.vm.provision "shell", inline: "sudo apt-get install -y samba"
  #config.vm.provision "shell", inline: "cp /vagrant/smb.conf /etc/samba/smb.conf"
  #config.vm.provision "shell", inline: "service smbd restart"

# Guest additions workaround
  #config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/4.3.28/VBoxGuestAdditions_4.3.28.iso"

  # installs Docker an pulls some images
  config.vm.provision "docker" do |docker|
    docker.pull_images "ubuntu:14.04"
  end

end