class icclab::base {

	#ensure ntp installed on all nodes
	class { 'ntp':
		servers    => $ntp_servers,
	}

	# TODO: fixme, I timeout on the 1st run, not the 2nd
	if $NewRelic_API_Key {
		newrelic::server { 'controller': 
			newrelic_license_key => $NewRelic_API_Key,
		}
	}else {
		warning ('Cannot install newrelic, NewRelic_API_Key is not set')
	}
}