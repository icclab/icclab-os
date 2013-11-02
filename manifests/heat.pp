# Class: icclab::heat
#
#
class icclab::heat {
	
	include icclab::params

	class { 'heat::db::mysql':
		password => $icclab::params::one_to_rule_them_all,
		host     => $icclab::params::controller_node_int_address,
	}

	class {'heat::keystone::auth':
		password          => $icclab::params::one_to_rule_them_all,
	}

	class { 'heat':
		keystone_password => $icclab::params::one_to_rule_them_all,
		sql_connection    => 'mysql://heat:${icclab::params::one_to_rule_them_all}@${icclab::params::controller_node_int_address}/heat',
		auth_uri          => 'http://${icclab::params::controller_node_int_address}:5000/v2.0',
		keystone_host     => $icclab::params::controller_node_int_address
		verbose           => $icclab::params::verbose
		rabbit_host       => $icclab::params::controller_node_int_address
		rabbit_userid     => $icclab::params::one_to_rule_them_all,
		rabbit_password   => $icclab::params::one_to_rule_them_all,
	}

	class { 'heat::engine': }

	class { 'heat::api': }
}