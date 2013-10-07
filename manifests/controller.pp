class icclab::controller {

  # inherits icclab::base

  include icclab::params
  include 'apache'
  
  $public_interface         = 'eth1'
  $traffic_egress_interface = 'eth1' #note these two are combined

  # TODO: configure adapter br-ex -> eth1, promiscious mode, assign IP

  class { 'openstack::controller':

    #network
    public_interface         => $public_interface,
    private_interface        => $icclab::params::private_interface, #eth0

    public_address           => $ipaddress_eth1,
    internal_address         => $icclab::params::controller_node_int_address,
    admin_address            => $icclab::params::controller_node_int_address,
    
    #quantum
    ## Note: addtional /etc/network/interfaces configuration needs to take place
    external_bridge_name     => 'br-ex',
    bridge_interface         => $traffic_egress_interface, # what br-ex gets connected to
    metadata_shared_secret   => $icclab::params::one_to_rule_them_all,
    ovs_local_ip             => $icclab::params::controller_node_int_address,
    enabled_apis             => $icclab::params::enabled_apis,
    verbose                  => $icclab::params::verbose,
    
    #passwords
    admin_email              => 'me@here.com',
    admin_password           => $icclab::params::one_to_rule_them_all,
    mysql_root_password      => $icclab::params::one_to_rule_them_all,
    rabbit_password          => $icclab::params::one_to_rule_them_all,
    keystone_db_password     => $icclab::params::one_to_rule_them_all,
    keystone_admin_token     => $icclab::params::one_to_rule_them_all,
    glance_db_password       => $icclab::params::one_to_rule_them_all,
    glance_user_password     => $icclab::params::one_to_rule_them_all,
    nova_db_password         => $icclab::params::one_to_rule_them_all,
    nova_user_password       => $icclab::params::one_to_rule_them_all,
    cinder_db_password       => $icclab::params::one_to_rule_them_all,
    cinder_user_password     => $icclab::params::one_to_rule_them_all,
    quantum_user_password    => $icclab::params::one_to_rule_them_all,
    quantum_db_password      => $icclab::params::one_to_rule_them_all,
    secret_key               => $icclab::params::one_to_rule_them_all,
  }

  class { 'openstack::auth_file':
      admin_password       => $icclab::params::one_to_rule_them_all,
      keystone_admin_token => $icclab::params::one_to_rule_them_all,
      controller_node      => '127.0.0.1',
  }
}