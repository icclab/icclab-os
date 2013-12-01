# https://github.com/openstack-dev/devstack/blob/master/lib/neutron_plugins/services/vpn

class icclab::services::vpn {
	
	package { "openswan":
		ensure => installed,
	} ->

	package { "neutron-plugin-vpn-agent":
		ensure => installed,
	} ->

	neutron_vpnaas_agent_config{
		'vpnagent/vpn_device_driver': value => 'neutron.services.vpn.device_drivers.ipsec.OpenSwanDriver';
	} ->

	service { "neutron-plugin-vpn-agent":
	    enable => true,
		ensure => running,
		hasrestart => true,
		hasstatus => true,
		#require => Class["config"],
	} ->

	exec { "horizon_enable_vpn":
		command => "echo \"OPENSTACK_NEUTRON_NETWORK['enable_vpn'] = True\" >> /etc/openstack-dashboard/local_settings.py",
		path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		unless  => "grep \"\['enable_vpn'\] = True\" /etc/openstack-dashboard/local_settings.py",
		#require => Package['savanna-dashboard'],
	}
}