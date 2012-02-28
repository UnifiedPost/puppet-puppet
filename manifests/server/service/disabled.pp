# = Class: puppet::server::service::disabled
#
# Sets up but does not enable the service
#
# == Sample Usage:
#
# include puppet::server::service::disabled
#
class puppet::server::service::disabled inherits puppet::server::service {

  require puppet::server::params
  $service = $puppet::server::params::service

  Service[$service] {
    ensure => 'stopped',
    enable => false,
  }

}

