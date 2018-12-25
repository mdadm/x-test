package { 'openssh-server':
  ensure => installed,
}

file { '/etc/ssh/sshd_config':
  source  => 'puppet:///files/sshd/sshd_config',
  owner   => 'root',
  group   => 'root',
  mode    => '0640',
  notify  => Service['sshd'], # sshd restarts whenever you edit this file.
  require => Package['openssh-server'],
}

service { 'sshd':
  ensure     => running,
  enable     => true,
}

user { 'trial-user':
    name => 'trial',
    home => '/home/trial',
    managehome => true,
    shell => '/bin/bash',
    ensure => present,
    password => 'OMbJkRx6Ocyok',
    groups => sudo,
}