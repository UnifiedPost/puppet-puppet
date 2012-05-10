# = Class: puppet::server::passenger
#
# Configure and install passenger
#
class puppet::server::passenger inherits puppet::server::rack {
  include apache::ssl
  include ::passenger

  $apache_conf_dir = $puppet::server::params::apache_conf_dir
  $app_root        = $puppet::server::params::app_root

  file {'puppet_vhost':
    path    => "${apache_conf_dir}/puppet.conf",
    content => template('puppet/server/puppet-vhost.conf.erb'),
    mode    => '0644',
    notify  => Exec['reload-apache'],
  }

  exec {'restart_puppet':
    command     => "/bin/touch ${app_root}/tmp/restart.txt",
    refreshonly => true,
    cwd         => $app_root,
    path        => [
      '/usr/local/sbin',
      '/usr/local/bin',
      '/usr/sbin',
      '/usr/bin',
      '/sbin',
      '/bin',
    ],
    require     => Class['puppet::server::install']
  }

  File["${puppet::server::params::app_root}/config.ru"] {
    notify => Exec['restart_puppet'],
  }

}
