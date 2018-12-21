# -*- mode: ruby -*-
# vi: set ft=ruby :

#Использование цикла
$agnt_quant = 2

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory=1024
      vb.cpus=1
      vb.check_guest_additions=false
  config.vm.box_check_update=false
  config.vm.box="ubuntu/xenial64"
  config.vm.provision "shell", path: "scripts/install_locale_ru.sh", privileged: true
  end


  config.vm.define "puppet" do |puppet|
        puppet.vm.hostname = "puppet"
        puppet.vm.network "private_network", ip: "192.168.1.10"
        puppet.vm.provider "virtualbox" do |vb|
          vb.memory = "4096"
        puppet.vm.provision "shell", path: "scripts/install_puppet_server.sh", privileged: true

        end
  end

(1..$agnt_quant).each do |i|
    config.vm.define "agent#{i}" do |agent|
        agent.vm.hostname = "agent#{i}"
        agent.vm.network "private_network", ip: "192.168.1.#{99+i}"
        agent.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
        agent.vm.provision "shell", path: "scripts/hosts.sh", privileged: true
        agent.vm.provision "shell", path: "scripts/install_puppet_agent.sh", privileged: true
        end
    end

end

end