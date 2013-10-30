class icclab::controller {
  include icclab::params
  include icclab::base # installs ntp, newrelic
  include 'apache'

  #use stages so we've a little more ordering

  class { 'openstack::controller':
    # network
    public_interface       => $icclab::params::public_interface, # eth1
    private_interface      => $icclab::params::private_interface, # eth0

    public_address         => $icclab::params::controller_node_ext_address,
    internal_address       => $icclab::params::controller_node_int_address,
    admin_address          => $icclab::params::controller_node_int_address,
    # quantum
    external_bridge_name   => $icclab::params::external_bridge_name,
    bridge_interface       => $icclab::params::traffic_egress_interface, # what br-ex gets connected to - eth1
    metadata_shared_secret => $icclab::params::one_to_rule_them_all,
    ovs_local_ip           => $icclab::params::controller_node_int_address,
    enabled_apis           => $icclab::params::enabled_apis,
    verbose                => $icclab::params::verbose,
    # passwords
    admin_email            => 'me@here.com',
    admin_password         => $icclab::params::one_to_rule_them_all,
    mysql_root_password    => $icclab::params::one_to_rule_them_all,
    rabbit_password        => $icclab::params::one_to_rule_them_all,
    keystone_db_password   => $icclab::params::one_to_rule_them_all,
    keystone_admin_token   => $icclab::params::one_to_rule_them_all,
    glance_db_password     => $icclab::params::one_to_rule_them_all,
    glance_user_password   => $icclab::params::one_to_rule_them_all,
    nova_db_password       => $icclab::params::one_to_rule_them_all,
    nova_user_password     => $icclab::params::one_to_rule_them_all,
    cinder_db_password     => $icclab::params::one_to_rule_them_all,
    cinder_user_password   => $icclab::params::one_to_rule_them_all,
    quantum_user_password  => $icclab::params::one_to_rule_them_all,
    quantum_db_password    => $icclab::params::one_to_rule_them_all,
    secret_key             => $icclab::params::one_to_rule_them_all,
  }

  class { 'openstack::auth_file':
    admin_password       => $icclab::params::one_to_rule_them_all,
    keystone_admin_token => $icclab::params::one_to_rule_them_all,
    controller_node      => '127.0.0.1',
  }

  class {'icclab::networking':
    network_interface_template => 'icclab/controller_interfaces.erb',
    require => Class['Openstack::Controller'],
  }

  if $icclab::params::install_images {
    class {'icclab::images': 
      require => Class['Openstack::Controller'],
    }
  }

  if $icclab::params::install_ceilometer {
    class { 'icclab::ceilometer::controller': 
      require => Class['Openstack::Controller'],
    }
  }

  if $icclab::params::install_haas {
    class {'icclab::haas': 
      require => Class['Openstack::Controller'],
    }
  }
}
