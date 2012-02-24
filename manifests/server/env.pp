# = Class: puppet::server::env
#
# Setup module directory for each environment
#
#
define puppet::server::env () {
  require puppet::server::params

  file { "${puppet::server::params::modules_path}/${name}":
    ensure => directory,
  }
}
