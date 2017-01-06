# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
  config.vm.define "gitlab" do |gitlab|
          gitlab.vm.box = "box"
	  gitlab.vm.hostname = "gitlab.test.com"
          gitlab.vm.network :private_network, ip: "192.168.50.10", bridge: "eth0"
	  gitlab.vm.network "forwarded_port", guest: 80, host: 8010
	  gitlab.vm.provision "shell",
            path: "gitlab.provision.sh"
  end

end
