class icclab::compute {

  # this is needed as parameter names are different in 
  # openstack grizzly and havana manifests
  
  include icclab::params

  if $icclab::params::os_version == 'grizzly'{
    class {'icclab::os::grizzly_compute': }
  } else {
    class {'icclab::os::compute': }
  }
}
