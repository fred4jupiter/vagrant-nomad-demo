# -*- mode: ruby -*-
# vi: set ft=ruby :

# define box name
NAME = "vagrant-nomad-demo"

unless Vagrant.has_plugin?("vagrant-docker-compose")
  puts 'Installing vagrant-docker-compose Plugin...'
  system('vagrant plugin install vagrant-docker-compose')
end

Vagrant.configure(2) do |config|  
  config.vm.box = "ubuntu/bionic64"  
  config.vm.box_version = "20200309.0.0"

  config.vm.provision :docker  
  
  config.vm.network :private_network, ip: "192.168.56.110"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
	vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.name = NAME
  end  
  config.vm.provision "shell", path: "scripts/nomad.sh" 
end