class icclab::images {
  
  include icclab::params
  
  glance_image { "Cirros 0.3.1 x86_64":
    ensure           => present,
    name             => "Cirros 0.3.1 x86_64",
    is_public        => yes,
    container_format => bare,
    disk_format      => 'qcow2',
    source           => 'http://download.cirros-cloud.net/0.3.1/cirros-0.3.1-x86_64-disk.img',
    require          => Class['Openstack::Glance']
  }

  if icclab::params::install_haas{
    # also: http://savanna-files.mirantis.com/savanna-0.3-vanilla-1.2.1-fedora-19.qcow2
    glance_image { "savanna-0.3-vanilla-1.2.1-ubuntu-13.04":
      ensure           => present,
      name             => "savanna-0.3-vanilla-1.2.1-ubuntu-13.04",
      is_public        => yes,
      container_format => bare,
      disk_format      => 'qcow2',
      source           => 'http://savanna-files.mirantis.com/savanna-0.3-vanilla-1.2.1-ubuntu-13.04.qcow2',
      require          => Class['Openstack::Glance']
    }  
  }

  if icclab::params::install_heat {
    # glance_image { "F18-x86_64-cfntools":
    #   ensure           => present,
    #   name             => "F18-x86_64-cfntools",
    #   is_public        => yes,
    #   container_format => bare,
    #   disk_format      => 'qcow2',
    #   source           => 'http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F18-x86_64-cfntools.qcow2',
    #   require          => Class['Openstack::Glance']
    # } 
    glance_image { "F18-x86_64-openshift-origin-broker-cfntools":
      ensure           => present,
      name             => "F18-x86_64-openshift-origin-broker-cfntools",
      is_public        => yes,
      container_format => bare,
      disk_format      => 'qcow2',
      source           => 'http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F18-x86_64-openshift-origin-broker-cfntools.qcow2',
      require          => Class['Openstack::Glance']
    } 
    glance_image { "F18-x86_64-openshift-origin-node-cfntools":
      ensure           => present,
      name             => "F18-x86_64-openshift-origin-node-cfntools",
      is_public        => yes,
      container_format => bare,
      disk_format      => 'qcow2',
      source           => 'http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F18-x86_64-openshift-origin-node-cfntools.qcow2',
      require          => Class['Openstack::Glance']
    } 
  }
}