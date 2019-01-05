node default {

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

  exec { "create ssh-key for user 'trial'":
    command => "ssh-keygen -f '/home/trial/.ssh/id_rsa'",
    path    => ['/usr/bin', '/usr/sbin',],
    provider => 'shell',
    creates => '/home/trial/.ssh/id_rsa',
    group   => 'trial',
    user    => 'trial',
  }

}