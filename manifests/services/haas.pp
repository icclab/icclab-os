class icclab::services::haas {

	include icclab::params

	class { 'savanna::db::mysql':
		password      => $icclab::params::one_to_rule_them_all,
		allowed_hosts => ['127.0.0.1',$icclab::params::controller_node_int_address],
	}

    class {'savanna::keystone::auth':
		password           => $icclab::params::one_to_rule_them_all,
		public_address     => $icclab::params::controller_node_ext_address,
		admin_address      => $icclab::params::controller_node_int_address,
		internal_address   => $icclab::params::controller_node_int_address,
	}

	class{'savanna':
		savanna_host              => $icclab::params::controller_node_int_address,
		db_host                   => $icclab::params::controller_node_int_address,
		savanna_db_password       => $icclab::params::one_to_rule_them_all,
		keystone_auth_host        => $icclab::params::controller_node_int_address,
		keystone_password         => $icclab::params::one_to_rule_them_all,
		savanna_verbose           => $icclab::params::verbose,
	} 

	class {'savanna::dashboard':
		savanna_host          => $icclab::params::controller_node_int_address,
	    use_neutron           => true,
		require               => Class['Openstack::Horizon']
	}
}