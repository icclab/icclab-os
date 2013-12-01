class icclab::services::ceilometer::controller inherits icclab::services::ceilometer::common {

  include icclab::params

  class { '::ceilometer::db::mysql':
    user     => 'ceilometer',
    password => $icclab::params::one_to_rule_them_all,
    allowed_hosts => ['127.0.0.1',$icclab::params::controller_node_int_address],
  }
  
  class { '::ceilometer::db':
    database_connection => "mysql://ceilometer:${icclab::params::one_to_rule_them_all}@${icclab::params::controller_node_int_address}/ceilometer",
  }

  class { 'ceilometer::keystone::auth':
    password           => $icclab::params::one_to_rule_them_all,
    auth_name          => 'ceilometer',
    service_type       => 'metering',
    public_address     => $icclab::params::controller_node_int_address,
    admin_address      => $icclab::params::controller_node_int_address,
    internal_address   => $icclab::params::controller_node_int_address,
  }

  class { '::ceilometer::api':
    keystone_password => $icclab::params::one_to_rule_them_all,
    keystone_host     => $icclab::params::controller_node_int_address,
  }

  class {'::ceilometer::collector': }

  class { '::ceilometer::agent::central': }

  class { '::ceilometer::client': }
}