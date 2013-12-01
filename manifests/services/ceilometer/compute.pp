
class icclab::services::ceilometer::compute inherits icclab::services::ceilometer::common {

  class { '::ceilometer::agent::compute': }
}