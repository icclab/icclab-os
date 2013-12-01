# http://docs.openstack.org/network-admin/admin/content/install_neutron-lbaas-agent.html

class icclab::services::loadbalancer {
	
	package { "haproxy":
		ensure => installed,
	} ->

	package { "neutron-lbaas-agent":
		ensure => installed,
	} ->

	exec { "horizon_enable_lb":
		command => "echo \"OPENSTACK_NEUTRON_NETWORK['enable_lb'] = True\" >> /etc/openstack-dashboard/local_settings.py",
		path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		unless  => "grep \"\['enable_lb'\] = True\" /etc/openstack-dashboard/local_settings.py",
		#require => Package['savanna-dashboard'],
	}

	neutron_lbaas_agent_config{
		'DEFAULT/interface_driver': value => 'neutron.agent.linux.interface.OVSInterfaceDriver';
		'DEFAULT/device_driver':    value => 'neutron.services.loadbalancer.drivers.haproxy.namespace_driver.HaproxyNSDriver';
	}

	service { "neutron-lbaas-agent":
	    enable => true,
		ensure => running,
		hasrestart => true,
		hasstatus => true,
		#require => Class["config"],
	}
}