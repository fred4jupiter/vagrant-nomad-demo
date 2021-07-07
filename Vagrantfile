# -*- mode: ruby -*-
# vi: set ft=ruby :

# Networking
private_ip = ENV['PRIVATE_IP'] || "192.168.56.110"

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

$nomad_setup = <<SCRIPT
echo "Minimal configuration for Nomad UI"
cat <<CONFIG | sudo tee /etc/nomad.d/default.hcl
bind_addr = "0.0.0.0"
advertise {
  http = "#{private_ip}:4646"
  rpc  = "#{private_ip}:4647"
  serf = "#{private_ip}:4648"
}
CONFIG
sudo systemctl restart nomad
SCRIPT

Vagrant.configure(2) do |config|

  # Setup networking
  config.vm.network :private_network, ip: private_ip
  config.vm.network "private_network", type: "dhcp"

  config.vm.box = "ubuntu/bionic64"  
  config.vm.box_version = "20200309.0.0"
  config.vm.hostname = "nomad"

  config.vm.provision :docker  
  
  config.vm.network :private_network, ip: "192.168.56.110"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
	vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.name = NAME
  end  
    
  config.vm.provision "shell", inline: "sudo hostnamectl set-hostname vagrant-nomad-demo"
  config.vm.provision "shell", inline: "sudo apt update && sudo apt upgrade -y"
  config.vm.provision "shell", path: "install/nomad.sh"
  config.vm.provision "shell", inline: $nomad_setup, privileged: false
  config.vm.provision :reload
end
