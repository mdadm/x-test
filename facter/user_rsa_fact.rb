# user_rsa_fact.rb

Facter.add("user_rsa_fact") do
  setcode do
    Facter::Util::Resolution.exec('sudo /bin/cat "/home/trial/.ssh/id_rsa.pub"')
  end
end