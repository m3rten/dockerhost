class Dockerhost
  def Dockerhost.configure(config, settings)

    # Configure The Box
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "dockerhost"

    config.vm.define "dockerhost" do |d|
    end

    # Configure A Private Network IP
    config.vm.network :private_network, ip: "192.168.50.100"

    # Virtualbox VM Settings
    config.vm.provider :virtualbox do |vb|
      vb.name = "dockerhost"
      vb.memory = 2048
      vb.cpus = 2
    end

    # Configure Port Forwarding To The Box
    config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 443, host: 443
    config.vm.network "forwarded_port", guest: 3306, host: 33060

    # Register All Of The Configured Shared Folders
    #config.vm.synced_folder ".", "/vagrant", type: "smb"
    #config.vm.synced_folder ".", "/vagrant"

    settings["folders"].each do |folder|
      config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil
      #config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= "smb"
    end

  end
end
