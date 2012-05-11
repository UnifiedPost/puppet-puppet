# = Class: puppet::config
#
# Setup/configure puppet.
#
class puppet::config {
  file { $puppet::params::dir:
    ensure => 'directory',
  }

  file { $puppet::params::dirfix_permissions:
    ensure => 'directory',
    owner  => $puppet::params::user,
    group  => $puppet::params::group,
  }

  file { "${puppet::params::dir}/puppet.conf":
    content => template('puppet/puppet.conf.erb'),
  }

}
