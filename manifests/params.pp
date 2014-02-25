class icclab::params{

  /* ---------------Important to set!------------------*/
  $os_version                   = 'havana' # can be 'havana' or 'grizzly'
  $is_vagrant                   = true
	$one_to_rule_them_all         = 'admin'
	$controller_node_int_address  = '10.10.10.51'
	$controller_node_ext_address  = '192.168.100.4'
	$public_interface             = 'eth2'
  $traffic_egress_interface     = 'eth2'
	$private_interface            = 'eth1' #10.10.10.0/24
	$NewRelic_API_Key             = ''
  $install_images               = false
  $install_haas                 = false
  $install_ceilometer           = true
  $install_heat                 = true
  $use_ryu                      = false
  # $network_services = [
  #           'neutron.services.loadbalancer.plugin.LoadBalancerPlugin', 
  #           'neutron.services.firewall.fwaas_plugin.FirewallPlugin',
  #           'neutron.services.vpn.plugin.VPNDriverPlugin',
  # ]
  $network_services = [
            'neutron.services.loadbalancer.plugin.LoadBalancerPlugin', 
  ]
  /* --------------------------------------------------*/

  $enabled_apis                 = 'ec2,osapi_compute,metadata'
  $ntp_servers                  = ['time.apple.com iburst', 'pool.ntp.org iburst', 'clock.redhat.com iburst']
  $external_bridge_name         = 'br-ex'
  $verbose                      = true
  $foreman_svcs                 = '192.168.100.2'
  $controller_gateway           = '160.85.4.1'
  $controller_nameserver        = '8.8.8.8'
  if $is_vagrant {
    $libvirt                    = 'qemu'
  } else {
    $libvirt                    = 'kvm'
  }

  if member($network_services, 'neutron.services.loadbalancer.plugin.LoadBalancerPlugin'){
    $install_lb = true
  }
  if member($network_services, 'neutron.services.firewall.fwaas_plugin.FirewallPlugin'){
    $install_fw = true
  }
  if member($network_services, 'neutron.services.vpn.plugin.VPNDriverPlugin'){
    $install_vpn = true
  }

  if size($network_services) > 0{
    neutron_config{
      'DEFAULT/service_plugins': value => join($network_services,",");    
    } 
  }
}
