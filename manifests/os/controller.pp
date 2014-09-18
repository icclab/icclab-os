# Class: icclab::os:controller
#
#
class icclab::os::controller {

  include icclab::params
  include 'apache'

  #use stages so we've a little more ordering
  class { 'icclab::base':
    ntp_servers            => $icclab::params::ntp_servers,
  } ->

  class { 'openstack::controller':
    # network
    public_interface       => $icclab::params::public_interface, # eth1
    private_interface      => $icclab::params::private_interface, # eth0

    public_address         => $icclab::params::controller_node_ext_address,
    internal_address       => $icclab::params::controller_node_int_address,
    admin_address          => $icclab::params::controller_node_int_address,
    # neutron
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
    neutron_user_password  => $icclab::params::one_to_rule_them_all,
    neutron_db_password    => $icclab::params::one_to_rule_them_all,
    secret_key             => $icclab::params::one_to_rule_them_all,
  } ->

  class { 'openstack::auth_file':
    admin_password       => $icclab::params::one_to_rule_them_all,
    keystone_admin_token => $icclab::params::one_to_rule_them_all,
    controller_node      => '127.0.0.1',
  } ->

  class {'icclab::networking':
    network_interface_template => 'icclab/controller_interfaces.erb',
    require => Class['Openstack::Controller'],
  }

  if $icclab::params::use_ryu{

    class {'ryu':
      wsapi_host      => $icclab::params::controller_node_int_address,
      ofp_listen_host => $icclab::params::controller_node_int_address,
    }

    class {'ryu::os::ryu_server':
      db_pass            => $icclab::params::one_to_rule_them_all,
      db_host            => $icclab::params::controller_node_int_address,
      ryu_server_ip      => $icclab::params::controller_node_int_address,
      ovsdb_interface    => $icclab::params::public_interface,
      tunnel_interface   => $icclab::params::public_interface,
    }
  }

  if $icclab::params::install_images {
    class {'icclab::images':
      require => Class['Openstack::Controller'],
    }
  }

  if $icclab::params::install_ceilometer {
    class { 'icclab::services::ceilometer::controller':
      require => Class['Openstack::Controller'],
    }
  }

  if $icclab::params::install_haas {
    class {'icclab::services::haas':
      require => Class['Openstack::Controller'],
    }
  }

  if $icclab::params::install_heat {
    class {'icclab::services::heat':
      require => Class['Openstack::Controller'],
    }
  }

  if $icclab::params::install_lb{
    class {'neutron::agents::lbaas':
      debug            => false,
      interface_driver => 'neutron.agent.linux.interface.OVSInterfaceDriver',
      device_driver    => 'neutron.services.loadbalancer.drivers.haproxy.namespace_driver.HaproxyNSDriver',
    } ->

    exec { "horizon_enable_lb":
      command => "echo \"OPENSTACK_NEUTRON_NETWORK['enable_lb'] = True\" >> /etc/openstack-dashboard/local_settings.py",
      path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      unless  => "grep \"\['enable_lb'\] = True\" /etc/openstack-dashboard/local_settings.py",
      #require => Package['savanna-dashboard'],
    }
  }

  if $icclab::params::install_fw{
    class {'neutron::services::fwaas':
      require => Class['Neutron'],
    } ->

    exec { "horizon_enable_fw":
      command => "echo \"OPENSTACK_NEUTRON_NETWORK['enable_firewall'] = True\" >> /etc/openstack-dashboard/local_settings.py",
      path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      unless  => "grep \"\['enable_firewall'\] = True\" /etc/openstack-dashboard/local_settings.py",
      #require => Package['savanna-dashboard'],
    }
  }

  if $icclab::params::install_vpn{
    class {'neutron::agents::vpnaas':
      vpn_device_driver => 'neutron.services.vpn.device_drivers.ipsec.OpenSwanDriver',
    } ->

    exec { "horizon_enable_vpn":
      command => "echo \"OPENSTACK_NEUTRON_NETWORK['enable_vpn'] = True\" >> /etc/openstack-dashboard/local_settings.py",
      path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      unless  => "grep \"\['enable_vpn'\] = True\" /etc/openstack-dashboard/local_settings.py",
      #require => Package['savanna-dashboard'],
    }
  }
}
