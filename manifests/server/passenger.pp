# = Class: puppet::server::passenger
#
# Configure and install passenger
#
class puppet::server::passenger {
  include apache::ssl
  include ::passenger

  file {'puppet_vhost':
    path    => "${puppet::server::params::apache_conf_dir}/puppet.conf",
    content => template('puppet/server/puppet-vhost.conf.erb'),
    mode    => '0644',
    notify  => Exec['reload-apache'],
  }

  exec {'restart_puppet':
    command     => "/bin/touch ${puppet::server::params::app_root}/tmp/restart.txt",
    refreshonly => true,
    cwd         => $puppet::server::params::app_root,
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require     => Class['puppet::server::install']
  }

  file {
    [$puppet::server::params::app_root, "${puppet::server::params::app_root}/public", "${puppet::server::params::app_root}/tmp"]:
      ensure => directory,
      owner  => $puppet::server::params::user,
  }
  file {
    "${puppet::server::params::app_root}/config.ru":
      owner  => $puppet::server::params::user,
      source => 'puppet:///modules/puppet/config.ru',
      notify => Exec['restart_puppet'],
  }

}
