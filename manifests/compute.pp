class icclab::compute {

  include icclab::params
  include icclab::base # installs ntp, newrelic

  class { 'openstack::compute':
    # network
    internal_address      => $ipaddress_eth0, # fixme
    private_interface     => $icclab::params::private_interface, # eth0

    # quantum
    ovs_local_ip          => $ipaddress_eth0, # fixme
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
    vncproxy_host         => $icclab::params::controller_node_int_address,
  }

  if $::operatingsystem == 'Ubuntu' {
    file { "/etc/network/interfaces":
      path    => '/etc/network/interfaces',
      ensure  => file,
      content => template('icclab/compute_interfaces.erb'),
      owner   => "root",
      group   => "root",
      mode    => 750,
      #notify  => Service["networking"],
    }
  } else {
    warning { "Cannot modify network settings. Only ubuntu is currently supported. You will need to make the changes manually.": }
  }
}
