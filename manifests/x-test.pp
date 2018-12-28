package { 'htop':
  ensure => installed,
}

package { 'openssh-server':
  ensure => installed,
}

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
#    password => 'OMbJkRx6Ocyok',
    groups => sudo,
}

#exec { "create ssh-key for user trial with name trial-user_ssh":
#    command => "ssh-keygen -t $type -b $bits -N '$passphrase' -f $keypath",
#    creates => $keypath,
#    group => $user,
#    user => $user,
#    require => [User[$user], File[$root]],
#}


ssh_authorized_key { 'trial-user_ssh':
  user => 'trial',
  type => 'rsa',
  key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDk656+4Ivl5MnFBSmQw+hnsd7DsueGbZ5HbVlzE8BvYxbwlWAO5DiVw2p1qae/WLJNJDDl7unZemLApR+YkKIL6HXbCUj8V8+KHqSyE9pshMiRj/Lh2lNhZQPFbE8cc6TNY3YVSeyKY0mw8Uj4MBGWnv62DWoO5QuM17CJrD6gH1VlkCqVt8c7jSd9ijmCume5QExwlUtMjl60ZyfbTRbz16aQJNKbqdeIGKA6rB97xet1cHNZ08cCd37GqtMyMiqYwgxxaG87y9DekotLQ9Zw12gyMVgaeGuihZfIV+F6HS1vKNjiL+av+zKxWPidSjlQf2qhthnaMnfPWGjjQfJ7',
  }

# Used to define/realize users on Puppet-managed systems
#
#class accounts {
#
#  @accounts::virtual { 'trial':
#    uid             =>  1001,
#    realname        =>  'Trial User',
##    pass            =>  '<password hash goes here>',
#  }
#}
#
## Defined type for creating virtual user accounts
##
#define accounts::virtual ($uid,$realname,$pass,$sshkeytype,$sshkey) {
#  include accounts::params
#
#  # Pull in values from accounts::params
#  $homepath =  $accounts::params::homepath
#  $shell    =  $accounts::params::shell
#
#  # Create the user
#  user { $title:
#    ensure            =>  'present',
#    uid               =>  $uid,
#    gid               =>  $title,
#    shell             =>  $shell,
#    home              =>  "${homepath}/${title}",
#    comment           =>  $realname,
#    password          =>  $pass,
#    managehome        =>  true,
#    require           =>  Group[$title],
#  }
#
#  # Create a matching group
#  group { $title:
#    gid               => $uid,
#  }
#
#  # Ensure the home directory exists with the right permissions
#  file { "${homepath}/${title}":
#    ensure            =>  directory,
#    owner             =>  $title,
#    group             =>  $title,
#    mode              =>  '0750',
#    require           =>  [ User[$title], Group[$title] ],
#  }
#
#  # Ensure the .ssh directory exists with the right permissions
#  file { "${homepath}/${title}/.ssh":
#    ensure            =>  directory,
#    owner             =>  $title,
#    group             =>  $title,
#    mode              =>  '0700',
#    require           =>  File["${homepath}/${title}"],
#  }
#
#  # Add user's SSH key
#  if ($sshkey != '') {
#    ssh_authorized_key {$title:
#      ensure          => present,
#      name            => $title,
#      user            => $title,
#      type            => $sshkeytype,
#      key             => $sshkey,
#    }
#  }
#}
#

#file { '/etc/ssh/sshd_config':
#  source  => 'puppet:///files/sshd_config',
#  owner   => 'root',
#  group   => 'root',
#  mode    => '0640',
#  notify  => Service['sshd'], # sshd restarts whenever you edit this file.
#  require => Package['openssh-server'],
#}
#

#class ssh {
#  # Declare:
#  @@sshkey { $::hostname:
#    type => dsa,
#    key  => $::sshdsakey,
#  }
#  # Collect:
#  Sshkey <<| |>>
#}
