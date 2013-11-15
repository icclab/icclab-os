class icclab::controller {
  
  # this is needed as parameter names are different in 
  # openstack grizzly and havana manifests
  
  include icclab::params

  if $icclab::params::os_version == 'grizzly' {
    class {'icclab::os::grizzly_controller': }
  } else {
    class {'icclab::os::controller': }
  }
}
