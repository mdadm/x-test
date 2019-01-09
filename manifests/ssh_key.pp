class ssh_key {

  # Declare:
  @@sshkey { $::hostname:
    type => rsa,
    key  => $::sshrsakey,
  }
  # Collect:
  Sshkey <<| |>>

  notify{"ssh_key class: $hostname $::sshrsakey":}

}