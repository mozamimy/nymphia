identity_file :private, '~/.ssh/id_rsa.1'

my_server_port = 4321

host('alice', 'my server on VPS') {
  hostname 'alice.example.com'
  user 'alice'
  port my_server_port
  use_identify_file :private
}

host('queen', 'NAS in my home network') {
  hostname '172.16.16.3'
  user 'alice'
  port my_server_port
  use_identify_file :private
}

include_file 'company.rb'
