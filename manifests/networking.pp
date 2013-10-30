class icclab::networking (
  $network_interface_template,
){
  
  include icclab::params

  if $::operatingsystem == 'Ubuntu' {
    file { "/etc/network/interfaces":
      path    => '/etc/network/interfaces',
      ensure  => file,
      content => template($network_interface_template),
      owner   => "root",
      group   => "root",
      mode    => 750,
    # notify  => Service["networking"],
    }
  } else {
    warning { "Cannot modify network settings. Only ubuntu is currently supported. You will need to make the changes manually.": }
  }
}
