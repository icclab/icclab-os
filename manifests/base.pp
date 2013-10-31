class icclab::base {

	include icclab::params
	
	class { 'ntp':
		servers    => $icclab::params::ntp_servers,
	}

	if $icclab::params::NewRelic_API_Key {
		newrelic::server { 'controller': 
			newrelic_license_key => $icclab::params::NewRelic_API_Key,
		}
	}
}