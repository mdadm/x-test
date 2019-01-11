# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specifing the number of agents
# $srv_quant = 1
$agnt_quant = 2

Vagrant.configure("2") do |config|

  # Specifing common parameters of VM's
  config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus=1
      vb.check_guest_additions=false
  config.vm.box_check_update=false
  config.vm.box="ubuntu/xenial64"
  # Fixing the RU-locale error on VM's
  config.vm.provision "shell", path: "scripts/install_locale_ru.sh", privileged: true
  end

  # Specifing parameters for agents
  (1..$agnt_quant).each do |i|
    config.vm.define "agent#{i}" do |agent|
        agent.vm.hostname = "agent#{i}"
        agent.vm.network "private_network", ip: "192.168.1.#{99+i}"
        agent.vm.provider "virtualbox" do |vb|
          vb.memory = "512"
        # Setting host of Puppet-server on Puppet-clients
        agent.vm.provision "shell", path: "scripts/hosts.sh", privileged: true
        # Setup Puppet-clients
        agent.vm.provision "shell", path: "scripts/install_puppet_agent.sh", privileged: true
        end
    end

  end

  # Specifing parameters for servers
  #(1..$srv_quant).each do |i|
      config.vm.define "puppet" do |puppet|
        puppet.vm.hostname = "puppet"
        puppet.vm.network "private_network", ip: "192.168.1.10"
        puppet.vm.provider "virtualbox" do |vb|
          vb.memory = "4096"
        # Copy config file from host to guests for sshd
        puppet.vm.provision "file", source: "~/projects/x-test/configs/sshd_config", destination: "sshd_config"
        # Copy config file from host to guests for puppet-fileserver
        puppet.vm.provision "file", source: "~/projects/x-test/configs/fileserver.conf", destination: "fileserver.conf"
        # Copy manifests file from host to guests for sshd
        puppet.vm.provision "file", source: "~/projects/x-test/manifests/x-test.pp", destination: "x-test.pp"
        puppet.vm.provision "file", source: "~/projects/x-test/manifests/ssh_key.pp", destination: "ssh_key.pp"
        # Setup Puppet-server
        puppet.vm.provision "shell", path: "scripts/install_puppet_server.sh", privileged: true
        end
      end
  #end
end


