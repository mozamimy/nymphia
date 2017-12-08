identity_file :company, '~/.ssh/id_rsa.company'
identity_file :company_gateway, '~/.ssh/id_rsa.company.gw'
identity_file :company_internal, '~/.ssh/id_rsa.company.in'

gateway('company.gateway', 'Gateway saerver of my company') {
  hostname 'gw.example.com'
  user 'alice'
  port 19822
}

group('company.ap-northeast-1') {
  use_gateway 'company.gateway'

  default_params {
    check_host_ip 'no'
    strict_host_key_checking 'no'
    user 'alice'
    port 9822
    use_identify_file :company, :company_gateway
  }

  host('*.apne.aws.example.com')

  host('alice.apne.aws.example.com') {
    hostname '10.16.16.16'
    user 'white_rabbit'
    port 7777
  }
}

proxy('awsproxy.company.apne1') {
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
}

host('ghe.company.example.com') {
  use_identify_file :company_internal
}
