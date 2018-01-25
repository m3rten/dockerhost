# Dockerhost

This Vagrant environment is setup to provide an easy way to run docker containers on a windows machine.
Local project folders can be mounted by mapping them in config.yaml

## config.yaml

    - map: /your/local/project
      to: /home/vagrant/project
      type: rsync
      excludes: ["backup","src/templates_c","src/admin/templates_c"]

## Startup

    vagrant up && vagrant ssh
