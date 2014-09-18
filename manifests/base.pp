class icclab::base (
	$ntp_servers,
){

	include icclab::params

	class { 'ntp':
		servers    => $ntp_servers,
	}

	if $icclab::params::NewRelic_API_Key {
		#class { 'newrelic': license => $icclab::params::NewRelic_API_Key }
		newrelic::server { 'controller':
			newrelic_license_key => $icclab::params::NewRelic_API_Key,
		}
	}

	# setup ubuntu cloud repos
	class {'openstack::repo::uca':
		release => $icclab::params::os_version,
	}
}
