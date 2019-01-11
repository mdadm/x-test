class ssh_key {

#  file { '/home/trial/.ssh/authorized_key':
#    ensure => file,
#    owner  => trial,
#    group  => trial,
#    mode   => '0644',
#    before => Sshkey[ "${::fqdn}_rsa" ],
#  }

  @@sshkey { "${::fqdn}_rsa":
    ensure       => present,
    key          => $::sshrsakey,
    type         => rsa,
  }

  Sshkey <<| |>>

  notify{"ssh_key class: $hostname $::sshrsakey":}

}

