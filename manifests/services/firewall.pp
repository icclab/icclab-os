# from http://docs.openstack.org/network-admin/admin/content/install_neutron-fwaas-agent.html

class icclab::services::firewall {
	neutron_config { 
		'fwaas/enabled':           value => 'True';
		'fwaas/driver':            value => 'neutron.services.firewall.drivers.linux.iptables_fwaas.IptablesFwaasDriver';
	} ->

	exec { "horizon_enable_fw":
		command => "echo \"OPENSTACK_NEUTRON_NETWORK['enable_fw'] = True\" >> /etc/openstack-dashboard/local_settings.py",
		path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		unless  => "grep \"\['enable_fw'\] = True\" /etc/openstack-dashboard/local_settings.py",
		#require => Package['savanna-dashboard'],
	}
}