# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.hostname = "ubuntu-jammy64"
  config.vm.box = "ubuntu/jammy64"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provision "shell", path: "scripts/pre-provision.sh"
  config.vm.provision "shell", path: "scripts/install-cli-tools.sh"
  config.vm.provision "shell", path: "scripts/install-tmux-xpanes.sh"
  config.vm.provision "shell", path: "scripts/install-docker.sh"
  config.vm.provision "shell", path: "scripts/install-azure-cli.sh"
  config.vm.provision "shell", path: "scripts/install-kbenv.sh"
  config.vm.provision "shell", path: "scripts/install-helmenv.sh"
  config.vm.provision "shell", path: "scripts/install-tfenv.sh"
  config.vm.provision "shell", path: "scripts/install-sops.sh"
  config.vm.provision "shell", path: "scripts/post-provision.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

end
