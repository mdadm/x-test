#!/usr/bin/env bash

# Adding Puppet-Labs repository into guest-system
curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb

# Updating lists of packages from repositories
apt-get update -y

# Installing Puppet-agent
apt-get install puppet-agent

# Starting of Puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

# Configuring Puppet-agent
echo -e "[main]\ncername = puppet\nserver = puppet" > /etc/puppetlabs/puppet/puppet.conf

# Installing Puppet-server
apt-get install puppetserver -y

# Starting of Puppet-server
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
/opt/puppetlabs/bin/puppet resource package puppetdb-termini ensure=latest

# Installing PuppetDB as module
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-puppetdb

# Starting PuppetDB
# sudo /opt/puppetlabs/bin/puppet resource service puppetdb ensure=running enable=true

# Configuring Puppet-server and PuppetDB
sudo sh -c 'echo "[agent]\nserver = puppet\n\n[master]\nstoreconfigs = true\nstoreconfigs_backend = puppetdb\nreports = store,puppetdb" > /etc/puppetlabs/puppet/puppet.conf'
sudo sh -c 'echo "[main]\nserver_urls = https://puppet:8081" > /etc/puppetlabs/puppet/puppetdb.conf'
sudo sh -c 'echo "---\nmaster:\n  facts:\n    terminus: puppetdb\n    cache: yaml" > /etc/puppetlabs/puppet/routes.yaml'
sudo chown -R puppet:puppet '/etc/puppetlabs/puppet/'

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
cp ssh_key.pp /etc/puppetlabs/code/environments/production/manifests

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

# Applying Puppet-manifest for Puppet-server
sudo /opt/puppetlabs/bin/puppet agent --test

# Enabling storeconfig on Puppet-server
echo " "
echo "Enabling storeconfig on Puppet-server..."
sudo /opt/puppetlabs/puppet/bin/puppet config set storeconfigs true
sudo service puppetserver restart
echo " "

echo " "
echo "...setup of Puppet server complete!"