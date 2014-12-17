Vagrant.configure("2") do |config|

  # The following line terminates all ssh connections. Therefore
  # Vagrant will be forced to reconnect.
  # That's a workaround to have the docker command in the PATH
  #config.vm.provision "shell", inline:
  #"ps aux | grep 'sshd:' | awk '{print $2}' | xargs kill"

  config.vm.provision "shell", inline: "sudo echo \"Europe/Berlin\" | sudo tee /etc/timezone"
  config.vm.provision "shell", inline: "sudo dpkg-reconfigure -f noninteractive tzdata"
  config.vm.provision "shell", inline: "sudo apt-get update -y"
  config.vm.provision "shell", inline: "sudo apt-get install -y build-essential curl git libssl-dev man"
  config.vm.provision "shell", inline: "sudo apt-get upgrade -y"

  config.vm.define "dockerhost"
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Virtualbox VM Settings
  config.vm.provider :virtualbox do |vb|
    vb.name = "dockerhost"
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.provision "docker" do |docker|
    docker.pull_images "ubuntu:14.04"
  end

end