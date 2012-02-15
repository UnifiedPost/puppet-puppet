# = Class: puppet::server::env
#
# Setup module directory for each environment
#
#
define puppet::server::env () {
  require puppet::params
  file { "${puppet::params::modules_path}/${name}":
    ensure => directory,
  }
}
