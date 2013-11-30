# from http://docs.openstack.org/network-admin/admin/content/install_neutron-fwaas-agent.html

class icclab::firewall {
	neutron_config { 
		'DEFAULT/service_plugins': value => 'neutron.services.firewall.fwaas_plugin.FirewallPlugin';
		'fwaas/driver':            value => 'neutron.services.firewall.drivers.linux.iptables_fwaas.IptablesFwaasDriver';
		'fwaas/enabled':           value => 'True';
	}
}