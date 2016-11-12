identity_file :private, '~/.ssh/id_rsa.1'

my_server_port = 4321

host 'alice', 'my server on VPS' do
  hostname 'alice.example.com'
  user 'alice'
  port my_server_port
  use_identify_file :private
end

host 'queen', 'NAS in my home network' do
  hostname '172.16.16.3'
  user 'alice'
  port my_server_port
  use_identify_file :private
end

# require_relative 'company.rb'
