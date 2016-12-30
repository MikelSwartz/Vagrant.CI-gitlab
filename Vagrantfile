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
	  gitlab.vm.network "forwarded_port", guest: 8080, host: 8010
	  gitlab.vm.provision "shell",
            path: "gitlab.provision.sh"
  end

  config.vm.define "remote" do |remote|
          remote.vm.box = "bmcgonigle/centos68"
	  remote.vm.hostname = "remote.host.com"
          remote.vm.network :private_network, ip: "192.168.50.15", bridge: "eth0"
          remote.vm.network "forwarded_port", guest: 8080, host: 8280
	  remote.vm.provision "shell",
            path: "remote.provision.sh"
  end
end
