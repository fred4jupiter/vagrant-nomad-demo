# -*- mode: ruby -*-
# vi: set ft=ruby :

# define box name
NAME = "vagrant-nomad-demo"

unless Vagrant.has_plugin?("vagrant-reload")
  puts 'Installing vagrant-reload plugin...'
  system('vagrant plugin install vagrant-reload')  
end

unless Vagrant.has_plugin?("vagrant-docker-compose")
  puts 'Installing vagrant-docker-compose Plugin...'
  system('vagrant plugin install vagrant-docker-compose')
end

Vagrant.configure(2) do |config|

  # Setup networking
  config.vm.network :private_network, ip: "192.168.56.110"

  config.vm.box = "ubuntu/bionic64"  
  config.vm.box_version = "20200309.0.0"
  config.vm.hostname = "nomad"

  config.vm.provision :docker  
  
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
	vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.name = NAME
  end  
  
  config.vm.provision "shell", inline: "sudo apt update && sudo apt upgrade -y"  
  
  # install consul  
  config.vm.provision "shell", path: "install/consul.sh"
  config.vm.provision "file", source: "config/consul.hcl", destination: "/etc/consul.d/consul.hcl"
  config.vm.provision "shell", inline: "sudo systemctl restart consul"
  
  # install nomad
  config.vm.provision "shell", path: "install/nomad.sh"
  config.vm.provision "file", source: "config/nomad.hcl", destination: "/etc/nomad.d/nomad.hcl"
  config.vm.provision "shell", inline: "sudo systemctl restart nomad"
    
  config.vm.provision :reload
end
