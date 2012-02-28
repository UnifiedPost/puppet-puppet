# = Class: puppet::service::disabled
#
# Sets up but does not enable the service
#
# == Sample Usage:
#
# include puppet::service::disabled
#
class puppet::service::disabled inherits puppet::service {

  Service['puppet'] {
    ensure => 'stopped',
    enable => false,
  }

}

