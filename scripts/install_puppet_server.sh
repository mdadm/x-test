#!/usr/bin/env bash

# Adding Puppet-Labs repository into guest-system
curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb

# Updating lists of packages from repositories
apt-get update -y

# Installing Puppet-server
apt-get install puppetserver -y

# Starting of Puppet-server
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true

# Configuring Puppet-server
echo -e "[agent]\nserver = puppet" > /etc/puppetlabs/puppet/puppet.conf

# Waiting for cert-request from Puppet-agents
echo "Waiting for cert-request from Puppet-agents..."

SECS=60

while [[ 0 -ne $SECS ]]; do
    echo "$SECS sec ..."
    sleep 1
    SECS=$[$SECS-1]
done

echo "Done!..."

# List and Signing cert from Puppet-agents
sudo /opt/puppetlabs/bin/puppet cert list --all
sudo /opt/puppetlabs/bin/puppet cert sign --all

# Copying config to Puppet fileserver
cp fileserver.conf /etc/puppetlabs/puppet

# Copying Puppet-manifests to Puppet-server
cp x-test.pp /etc/puppetlabs/code/environments/production/manifests
cp create_ssh_key.pp /etc/puppetlabs/code/environments/production/manifests

# Checking and creating folder for Puppet fileserver if not exist
if [ ! -d '/etc/puppetlabs/code/files' ]; then
    echo "Directory /etc/puppetlabs/code/files not found, creating..."
    mkdir /etc/puppetlabs/code/files
    echo "...done!"
else
    echo "Directory /etc/puppetlabs/code/files exist, continue..."
fi

# Copying config for sshd
cp sshd_config /etc/puppetlabs/code/files/

# Checking and creating folder for SSH configs and files if not exist
if [ ! -d '/etc/puppetlabs/code/files/sshconfig/' ]; then
    echo "Directory /etc/puppetlabs/code/files/sshconfig/ not found, creating..."
    mkdir /etc/puppetlabs/code/files/sshconfig/
    echo "...done!"
else
    echo "Directory /etc/puppetlabs/code/files/sshconfig/ exist, continue..."
fi