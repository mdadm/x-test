node default {

  include ssh_key

  $packages = [ 'mc', 'htop', 'tree', 'openssh-server' ]
  package { $packages: ensure => 'installed' }

  service { 'sshd':
    ensure     => running,
    enable     => true,
    require    => Package['openssh-server'],
  }

  user { 'trial-user':
      name => 'trial',
      home => '/home/trial',
      managehome => true,
      shell => '/bin/bash',
      ensure => present,
      groups => sudo,

  }

  file { '/home/trial/.ssh/authorized_keys':
    ensure  => 'file',
    owner   => 'trial',
    group   => 'trial',
    mode    => '0600',

}

  exec { "create ssh-key for user 'trial'":
    command => "ssh-keygen -f '/home/trial/.ssh/id_rsa'",
    path    => ['/usr/bin', '/usr/sbin',],
    provider => 'shell',
    creates => '/home/trial/.ssh/id_rsa',
    group   => 'trial',
    user    => 'trial',
  }

}

node puppet {

  $packages = [ 'mc', 'htop', 'tree', 'openssh-server' ]
  package { $packages: ensure => 'installed' }

  class { 'puppetdb':
      # database_username => 'puppetdb',
      # database_password => 'puppetdb',
      # database_name     => 'puppetdb',
      report_ttl        => '7d'
  }

}