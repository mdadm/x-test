class ssh_key {

  @@sshkey { "${::fqdn}_rsa":
    ensure       => present,
    key          => $::user_rsa_fact,
    type         => rsa,
    target       => '/home/trial/.ssh/authorized_keys'
  }

  Sshkey <<| |>>

#  notify{"ssh_key class: $::user_rsa_fact":}

}