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
  $app_owner = $puppet::server::params::user
  $app_group = $puppet::server::params::group
  $app_root = $puppet::server::params::app_root
  $doc_root = $puppet::server::params::doc_root
  $rack_config_source = $puppet::server::params::rack_config_source

  File {
    owner => $app_user,
    group => $app_group,
  }

  file {$app_root:
    ensure => 'directory',
  }
  file {$doc_root:
    ensure  => 'directory',
    require => File[$app_root],
  }
  file {"${app_root}/tmp":
    ensure  => 'directory',
    require => File[$app_root],
  }
  file {"${app_root}/config.ru":
    source => $rack_config_source,
  }
}

