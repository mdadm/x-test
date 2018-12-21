#!/usr/bin/env bash

curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update -y
apt-get install puppetserver -y
systemctl start puppetserver
systemctl enable puppetserver