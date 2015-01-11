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
  config.vm.provision "shell", inline: "sudo apt-get update -y"
  config.vm.provision "shell", inline: "sudo apt-get install -y build-essential curl git libssl-dev man"
  config.vm.provision "shell", inline: "sudo apt-get upgrade -y"

  # installs Docker an pulls some images
  config.vm.provision "docker" do |docker|
    docker.pull_images "ubuntu:14.04"
  end

end