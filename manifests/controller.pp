class icclab::controller{

  include icclab::params
  include 'apache'
  
  $public_interface         = 'eth1'
  $traffic_egress_interface = 'eth2'

  class { 'openstack::controller':

    #network
    public_interface         => $public_interface,
    private_interface        => $private_interface, #eth0

    public_address           => $ipaddress_eth1,
    internal_address         => $controller_node_int_address,
    admin_address            => $controller_node_int_address,
    
    #quantum
    ## Note: addtional /etc/network/interfaces configuration needs to take place
    external_bridge_name     => 'br-ex',
    bridge_interface         => $traffic_egress_interface, # what br-ex gets connected to
    metadata_shared_secret   => $one_to_rule_them_all,
    ovs_local_ip             => $controller_node_int_address,
    enabled_apis             => 'ec2,osapi_compute,metadata',
    verbose                  => 'True',
    
    #passwords
    admin_email              => 'me@here.com',
    admin_password           => $one_to_rule_them_all,
    mysql_root_password      => $one_to_rule_them_all,
    rabbit_password          => $one_to_rule_them_all,
    keystone_db_password     => $one_to_rule_them_all,
    keystone_admin_token     => $one_to_rule_them_all,
    glance_db_password       => $one_to_rule_them_all,
    glance_user_password     => $one_to_rule_them_all,
    nova_db_password         => $one_to_rule_them_all,
    nova_user_password       => $one_to_rule_them_all,
    cinder_db_password       => $one_to_rule_them_all,
    cinder_user_password     => $one_to_rule_them_all,
    quantum_user_password    => $one_to_rule_them_all,
    quantum_db_password      => $one_to_rule_them_all,
    secret_key               => $one_to_rule_them_all,
  }

  class { 'openstack::auth_file':
      admin_password       => $one_to_rule_them_all,
      keystone_admin_token => $one_to_rule_them_all,
      controller_node      => '127.0.0.1',
  }
}