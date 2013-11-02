class icclab::params{

  /* ---------------Important to set!------------------*/
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
  $install_ceilometer           = false
  $install_heat                 = false
  /* --------------------------------------------------*/

  $enabled_apis                 = 'ec2,osapi_compute,metadata'
  $ntp_servers                  = ['time.apple.com iburst', 'pool.ntp.org iburst', 'clock.redhat.com iburst']
  $external_bridge_name         = 'br-ex'
  $verbose                      = true
  $foreman_svcs                 = '192.168.100.2'

  if $is_vagrant {
    $libvirt                    = 'qemu'
  } else {
    $libvirt                    = 'kvm'
  }
}