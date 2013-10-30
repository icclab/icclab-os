class icclab::images {
  #add images as are needed here
  glance_image { "Cirros 0.3.1 x86_64":
    ensure           => present,
    name             => "Cirros 0.3.1 x86_64",
    is_public        => yes,
    container_format => bare,
    disk_format      => 'qcow2',
    source           => 'http://download.cirros-cloud.net/0.3.1/cirros-0.3.1-x86_64-disk.img',
  }
}