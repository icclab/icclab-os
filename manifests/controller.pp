class icclab::controller {

  # inherits icclab::base

  include icclab::params
  include icclab::base #installs ntp, newrelic
  include 'apache'

  class { 'openstack::controller':

    #network
    public_interface         => $icclab::params::public_interface, #eth1
    private_interface        => $icclab::params::private_interface, #eth0

    public_address           => $ipaddress_eth1, #fixme
    internal_address         => $icclab::params::controller_node_int_address,
    admin_address            => $icclab::params::controller_node_int_address,
    
    #quantum
    ## Note: addtional /etc/network/interfaces configuration needs to take place
    external_bridge_name     => $icclab::params::external_bridge_name,
    bridge_interface         => $icclab::params::traffic_egress_interface, # what br-ex gets connected to - eth1
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

  if $::operatingsystem == 'Ubuntu' {
    file { "/etc/network/interfaces":
      path    => '/etc/network/interfaces',
      ensure => file,
      content => template('icclab/controller_interface.erb'),
      owner  => "root",
      group  => "root",
      mode   => 750,
      notify  => Service["networking"],
    }
  }else {
    warning {"Cannot modify network settings. Only ubuntu is currently supported. You will need to make the changes manually."}
  }
}