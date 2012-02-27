# = Class: puppet::server::config
#
# Configure and setup puppet and puppet master
#
class puppet::server::config inherits puppet::config {
  require puppet::server::params
  $hostname            = $puppet::server::params::hostname
  $ssl_cert            = $puppet::server::params::ssl_cert
  $puppet_dir          = $puppet::server::params::dir
  $environments        = $puppet::server::params::environments
  $passenger           = $puppet::server::params::passenger
  $modules_path        = $puppet::server::params::modules_path
  $common_modules_path = $puppet::server::params::common_modules_path

  if $passenger  { include puppet::server::passenger }

  File ["${puppet_dir}/puppet.conf"] {
    content => template('puppet/puppet.conf.erb', 'puppet/server/puppet.conf.erb'),
  }

  file { [$modules_path, $common_modules_path]:
    ensure => 'directory',
  }

  exec {'generate_ca_cert':
    creates => $ssl_cert,
    command => "puppetca --generate ${hostname}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require => File["${puppet_dir}/puppet.conf"],
  }

  # setup empty directories for our environments
  puppet::server::env {$environments: }

}
