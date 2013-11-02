
class icclab::ceilometer::compute inherits icclab::ceilometer::common {

  class { '::ceilometer::agent::compute': }
}