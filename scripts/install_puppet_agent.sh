#!/usr/bin/env bash

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
echo -e "[main]\ncername = puppet\nserver = puppet" > /etc/puppetlabs/puppet/puppet.conf