# = Class: puppet::service::disabled
#
# Sets up but does not enable the service
#
# == Sample Usage:
#
# include puppet::service::disabled
#
class puppet::service::disabled inherits puppet::service {

  require puppet::params
  $service = $puppet::params::service

  Service[$service] {
    ensure => 'stopped',
    enable => false,
  }

}

