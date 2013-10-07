class icclab::params{

  /* ---------------Important to set!------------------*/
	$one_to_rule_them_all         = 'admin'
	$controller_node_int_address  = '10.10.10.51'
	$private_interface            = 'eth0' #10.10.10.0/24
	$verbose                      = true
	# set to 'kvm' if deploying on metal
	$libvirt                      = 'qemu'
	$enabled_apis                 = 'ec2,osapi_compute,metadata'
	$ntp_servers                  = ['time.apple.com iburst', 'pool.ntp.org iburst', 'clock.redhat.com iburst']
	$NewRelic_API_Key             = ''
  /* --------------------------------------------------*/
}