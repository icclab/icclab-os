class icclab::base {

	include icclab::params
	
	#ensure ntp installed on all nodes
	class { 'ntp':
		servers    => $icclab::params::ntp_servers,
	}

	if $icclab::params::NewRelic_API_Key {
		newrelic::server { 'controller': 
			newrelic_license_key => $icclab::params::NewRelic_API_Key,
		}
	}else {
		warning ('Cannot install newrelic, NewRelic_API_Key is not set')
	}
}