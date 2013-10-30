class icclab::ceilometer::common {
  
  include icclab::params
  
  class { '::ceilometer':
    metering_secret    => $icclab::params::one_to_rule_them_all,
    verbose            => $icclab::params::verbose,
    rabbit_host        => $icclab::params::controller_node_int_address,
    rabbit_userid      => $icclab::params::one_to_rule_them_all,
    rabbit_password    => $icclab::params::one_to_rule_them_all,
  }

  class { '::ceilometer::agent::auth':
    auth_password => $icclab::params::one_to_rule_them_all,
    auth_url      => "http://${icclab::params::controller_node_int_address}:5000/v2.0",
  }
}