identity_file :company, '~/.ssh/id_rsa.company'
identity_file :company_gateway, '~/.ssh/id_rsa.company.gw'
identity_file :company_internal, '~/.ssh/id_rsa.company.in'

gateway 'company.gateway', 'Gateway saerver of my company' do
  hostname 'gw.example.com'
  user 'alice'
  port 19822
end

group 'company.ap-northeast-1' do
  use_gateway 'company.gateway'

  default_params do
    check_host_ip 'no'
    strict_host_key_checking 'no'
    user 'alice'
    port 9822
    use_identify_file :company, :company_gateway
  end

  host '*.apne.aws.example.com'

  host 'alice.apne.aws.example.com' do
    hostname '10.16.16.16'
    user 'white_rabbit'
    port 7777
  end
end

proxy 'awsproxy.company.apne1' do
  hostname 'gw.apne1.example.com'
  user 'alice'
  port 19822
  use_identify_file :company_gateway

  # SOCKS proxy
  dynamic_forward 23921

  # ssh tunnels
  local_forward 'mysql-server', {
    'localhost' => 13306,
    'mysql.apne.aws.example.com' => 3306,
  }

  local_forward 'ldap', {
    'localhost' => 10389,
    'ldap.apne.aws.example.com' => 398,
  }
end

host 'ghe.company.example.com' do
  use_identify_file :company_internal
end
