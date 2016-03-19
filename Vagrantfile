Vagrant.configure("2") do |config|
  config.env.enable # sets env variables from .env files

  # feed the monster
  config.vm.provider "virtualbox" do |v|
    v.memory = 1048
    v.cpus = 1
  end

  # using ubuntu host
  config.vm.box = "ubuntu/trusty64"

  # use rsync to keep host in sync with guest VM
  config.vm.synced_folder ".", "/app", type: "rsync",
    rsync__exclude: [".git/", "node_modules/"]

  # provision with docker and docker-compose
  config.vm.provision :docker
  # when running docker compose always rebuild and run
  config.vm.provision :docker_compose,
    yml: "/app/docker-compose.yml",
    rebuild: true,
    run: "always"

  # don't automatically start syncing,
  # we'll kick that off in the startup script
  config.gatling.rsync_on_startup = false

  # forward ports
  config.vm.network :forwarded_port, guest: 3000, host: 3000 # service
end
