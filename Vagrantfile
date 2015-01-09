Vagrant.configure("2") do |config|

  # The following line terminates all ssh connections. Therefore
  # Vagrant will be forced to reconnect.
  # That's a workaround to have the docker command in the PATH
  #config.vm.provision "shell", inline:
  #"ps aux | grep 'sshd:' | awk '{print $2}' | xargs kill"

  config.vm.define "dockerhost"
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping which allows access to a specific port within the machine from a port on the host machine.
  [8080].each do |p|
    config.vm.network :forwarded_port, guest: p, host: p
  end

  config.vm.network :forwarded_port, guest: 3306, host: 3369 # mysql

  #config.vm.network :private_network, ip: 192.168.50.100

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: "sudo echo \"Europe/Berlin\" | sudo tee /etc/timezone"
  config.vm.provision "shell", inline: "sudo dpkg-reconfigure -f noninteractive tzdata"
  config.vm.provision "shell", inline: "sudo apt-get update -y"
  config.vm.provision "shell", inline: "sudo apt-get install -y build-essential curl git libssl-dev man"
  config.vm.provision "shell", inline: "sudo apt-get upgrade -y"

  # Virtualbox VM Settings
  config.vm.provider :virtualbox do |vb|
    vb.name = "dockerhost"
    vb.memory = 2048
    vb.cpus = 2
  end

  # installs Docker an pulls some images
  config.vm.provision "docker" do |docker|
    docker.pull_images "ubuntu:14.04"
  end

end