#!/usr/bin/env bash

curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update -y
apt-get install puppetserver -y
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
echo -e "[agent]\nserver = puppet" > /etc/puppetlabs/puppet/puppet.conf
sleep 60
sudo /opt/puppetlabs/bin/puppet cert list --all
sudo /opt/puppetlabs/bin/puppet cert sign --all