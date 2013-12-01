

class icclab::services::heat {
	
	include icclab::params

	class { 'heat::db::mysql':
		password => $icclab::params::one_to_rule_them_all,
		host     => $icclab::params::controller_node_int_address,
	} ->

	class {'heat::keystone::auth':
		password          => $icclab::params::one_to_rule_them_all,
		public_address    => $icclab::params::controller_node_ext_address,
		admin_address     => $icclab::params::controller_node_int_address,
		internal_address  => $icclab::params::controller_node_int_address,
	} ->

	class {'heat::keystone::auth_cfn':
		password           => $icclab::params::one_to_rule_them_all,
		public_address     => $icclab::params::controller_node_ext_address,
		admin_address      => $icclab::params::controller_node_int_address,
		internal_address   => $icclab::params::controller_node_int_address,
	} ->

	class { '::heat':
		keystone_password => $icclab::params::one_to_rule_them_all,
		sql_connection    => "mysql://heat:${icclab::params::one_to_rule_them_all}@${icclab::params::controller_node_int_address}/heat",
		auth_uri          => "http://${icclab::params::controller_node_int_address}:5000/v2.0",
		keystone_host     => $icclab::params::controller_node_int_address,
		verbose           => $icclab::params::verbose,
		rabbit_host       => $icclab::params::controller_node_int_address,
		rabbit_userid     => 'openstack', #fixme
		rabbit_password   => $icclab::params::one_to_rule_them_all,
	}
	
	class { 'heat::engine': 
		heat_stack_user_role          => 'heat_stack_user',
	  	heat_metadata_server_url      => "http://${icclab::params::controller_node_int_address}:8000",
	  	heat_waitcondition_server_url => "http://${icclab::params::controller_node_int_address}:8000/v1/waitcondition",
	  	heat_watch_server_url         => "http://${icclab::params::controller_node_int_address}:8003",
	}

	# heat's native API
	class { 'heat::api': 
		bind_host         => '0.0.0.0',
  		bind_port         => '8004',
	}

	# heat's cloudformation API
	class { 'heat::api_cfn': 
		bind_host         => '0.0.0.0',
	  	bind_port         => '8000',
	}

	# # heat's cloudwatch API
	class { 'heat::api_cloudwatch': 
		bind_host         => '0.0.0.0',
  		bind_port         => '8003',
	}

	class { 'heat::client': }

}