class Dockerhost
  def Dockerhost.configure(config, settings)

    settings["folders"].each do |folder|
      config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil , rsync__exclude: folder["excludes"]
    end

  end
end
