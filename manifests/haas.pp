class icclab::haas {

	#TODO parameterise with...
	include icclab::params

	class { 'savanna::db::mysql':
		user          => 'savanna',
		password      => 'savanna',
		dbname        => 'savanna',
		allowed_hosts => ['127.0.0.1'],
	}

    class {'savanna::keystone::auth':
		password           => 'savanna',
		auth_name          => 'savanna',
		email              => 'savanna@localhost',
		tenant             => 'services',
		configure_endpoint => true,
		service_type       => 'mapreduce',
		public_address     => '127.0.0.1',
		admin_address      => '127.0.0.1',
		internal_address   => '127.0.0.1',
		port               => '8386',
		region             => 'RegionOne',
		public_protocol    => 'http',
		internal_protocol  => 'http',
	}

	class{'savanna':
		savanna_host              => '127.0.0.1',
		savanna_port              => '8386',
		db_host                   => '127.0.0.1',
		savanna_db_name           => 'savanna',
		savanna_db_user           => 'savanna',
		savanna_db_password       => 'savanna',
		keystone_auth_protocol    => 'http',
		keystone_auth_host        => '127.0.0.1',
		keystone_auth_port        => '35357',
		keystone_user             => 'savanna',
		keystone_password         => 'savanna',
		savanna_verbose           => true,
		savanna_debug             => false,
	} 

	class {'savanna::dashboard':
		savanna_host          => '127.0.0.1',
	    savanna_port          => '8386',
	    use_neutron           => true,
		require               => Class['Openstack::Horizon']
	}
}