# -*- mode: ruby -*-
# vi: set ft=ruby :

#Использование цикла
$srv_quant = 1
$agnt_quant = 2

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory=256
      vb.cpus=1
      vb.check_guest_additions=false
  config.vm.box_check_update=false
  config.vm.box="ubuntu/xenial64"
 end

(1..$srv_quant).each do |i|
    config.vm.define "srv#{i}" do |srv|
        srv.vm.hostname = "srv#{i}"
        srv.vm.network "private_network", ip: "192.168.1.#{9+i}"

    end
end

(1..$agnt_quant).each do |i|
    config.vm.define "agnt#{i}" do |agnt|
        agnt.vm.hostname = "agnt#{i}"
        agnt.vm.network "private_network", ip: "192.168.1.#{99+i}"

    end
end

end