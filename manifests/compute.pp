class icclab::compute{

  include icclab::params

  class {'openstack::compute':
    #network
    internal_address        => $ipaddress_eth0,
    private_interface       => $private_interface, #eth0

    #quantum
    ovs_local_ip            => $ipaddress_eth0,
    quantum_auth_url        => "http://${controller_node_int_address}:35357/v2.0",
    keystone_host           => $controller_node_int_address,
    quantum_host            => $controller_node_int_address,

    #passwords
    rabbit_password         => $one_to_rule_them_all,
    nova_user_password      => $one_to_rule_them_all,
    nova_db_password        => $one_to_rule_them_all,
    quantum_user_password   => $one_to_rule_them_all,
    cinder_db_password      => $one_to_rule_them_all,

    #database
    db_host                 => $controller_node_int_address,

    #misc
    libvirt_type            => 'qemu',
    setup_test_volume       => true,
    verbose                 => true,
    rabbit_host             => $controller_node_int_address,
    glance_api_servers      => "${controller_node_int_address}:9292",
    vncproxy_host           => $controller_node_int_address,
  }
}