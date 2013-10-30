class icclab::compute {
  
  include icclab::params
  include icclab::base # installs ntp, newrelic

  #use stages so we've a little more ordering
  
  if $icclab::params::is_vagrant {
    $internal_address_tmp = $ipaddress_eth1
  }
  else {
    $internal_address_tmp = $ipaddress_eth0
  }

  class { 'openstack::compute':
    # network
    internal_address      => $internal_address_tmp,
    private_interface     => $icclab::params::private_interface, # eth0
    # quantum
    ovs_local_ip          => $internal_address_tmp,
    quantum_auth_url      => "http://${icclab::params::controller_node_int_address}:35357/v2.0",
    keystone_host         => $icclab::params::controller_node_int_address,
    quantum_host          => $icclab::params::controller_node_int_address,
    # passwords
    rabbit_password       => $icclab::params::one_to_rule_them_all,
    nova_user_password    => $icclab::params::one_to_rule_them_all,
    nova_db_password      => $icclab::params::one_to_rule_them_all,
    quantum_user_password => $icclab::params::one_to_rule_them_all,
    cinder_db_password    => $icclab::params::one_to_rule_them_all,
    # database
    db_host               => $icclab::params::controller_node_int_address,
    # misc
    libvirt_type          => $icclab::params::libvirt,
    setup_test_volume     => true,
    verbose               => $icclab::params::verbose,
    rabbit_host           => $icclab::params::controller_node_int_address,
    glance_api_servers    => "${icclab::params::controller_node_int_address}:9292",
    vncproxy_host         => $icclab::params::controller_node_ext_address,
  }

  class {'icclab::networking':
    network_interface_template => 'icclab/compute_interfaces.erb',
  }

  include icclab::ceilometer::compute
}
