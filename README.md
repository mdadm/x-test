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
 
# Notes

* We should use Vagrant because we need to setup VM on VirtualBox under the terms of the task.
* We create three VM - one server and two agent for Puppet. The number of agents can be increased easily.
* 

# Installation and launch

1. Install Vagrant:
    * For MacOS: brew cask install vagrant
    * For Ubuntu Linux: sudo apt install vagrant
    
2. Clone the repository x-test:
    * git clone https://github.com/mdadm/x-test.git

3. Run vagrantfile from x-test:
    * cd x-test
    * vagrant up