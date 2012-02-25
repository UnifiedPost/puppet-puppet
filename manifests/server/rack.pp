# = Class: puppet::server::rack
#
# Description of puppet::server::rack
#
# == Actions:
#
# Create a directory structure to use with passenger
#
# == Sample Usage:
#
# include puppet::server::rack
#
class puppet::server::rack {

  require puppet::server::params

  File {
    owner => $puppet::server::params::user,
  }

  file {$puppet::server::params::app_root:
    ensure => 'directory',
  }
  file {"${puppet::server::params::doc_root}":
    ensure  => 'directory',
    require => File[$puppet::server::params::app_root],
  }
  file {"${puppet::server::params::app_root}/tmp":
    ensure  => 'directory',
    require => File[$puppet::server::params::app_root],
  }
  file {"${puppet::server::params::app_root}/config.ru":
    source => 'puppet:///modules/puppet/config.ru',
  }
}

