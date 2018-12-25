#!/usr/bin/env bash

# Adding Puppet-Labs repository into guest-system
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb

# Updating lists of packages from repositories
apt-get update

# Installing Puppet-agent
apt-get install puppet-agent

# Starting of Puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

# Configuring Puppet-agent
echo -e "[main]\ncername = puppet\nserver = puppet" > /etc/puppetlabs/puppet/puppet.conf