# x-test
Test task for X-lla

# What should be done?

* Create a network of three virtual machines running Ubuntu Xenial using VirtualBox.
* Install Puppet server for one of machines.
* Install Puppet agent for the others.
* Connect Puppet agents to the server.
* Configure SSH-server on hosts using Puppet. Password access must be denied.
* Create a Puppet-manifest for user "trial" on all servers. Each server should create a unique pair for ssh-keys.
* Create a Puppet-manifest where the authorized user "trial" on each server gets public keys from two other servers.
* It is recommended that use git when writing code and preferably to simplify and automate the process as much as possible.
 
# Notes

* We should use Vagrant because we need to setup VM on VirtualBox under the terms of the task.
* We creating three VM - one server and two agent for Puppet. The number of agents can be increased easily.
* Parameters of the VMs are specified in the Vagrant-file.
* With Vagrant provision, copying the files and runing the configuration scripts of Puppet-servers and Puppet-agents.
* Puppet-server is named "puppet", Puppet-agents - "agent1", "agent2", etc. 
* We creating the user "trial" and his ssh-key using Puppet manifest x-test.pp on each server.
* We using puppetdb and puppet custom fact for deploying user ssh public key.
* Finally, we need to place the source code on github.com in the x-test repository (git push).

# Installation and launch

1. Install VirtualBox and Vagrant:
    * For MacOS: brew cask install virtualbox && brew cask install vagrant
    * For Ubuntu/Debian: sudo apt install virtualbox vagrant
    
2. Clone the repository x-test:
    * git clone https://github.com/mdadm/x-test.git

3. Run vagrantfile from x-test directory:
    * cd x-test
    * vagrant up
    
The virtual machines will installed, configured and started automatically. Note, it's may take a long time. 

4. You can see the list of running servers by command "vagrant global-status" and can connect to any of those by command "vagrant ssh [name of virtual machine]". 

5. Update configuration of Puppet-agents can be forced by command "sudo /opt/puppetlabs/bin/puppet agent --test"

6. Turn off and delete all virtual machines can by command "vagrant destroy -f".