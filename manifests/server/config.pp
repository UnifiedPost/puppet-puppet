# = Class: puppet::server::config
#
# Configure and setup puppet and puppet master
#
class puppet::server::config inherits puppet::config {
  require puppet::server::params
  if $puppet::server::params::passenger  { include puppet::server::passenger }

  File ["${puppet::server::params::dir}/puppet.conf"] {
    content => template('puppet/puppet.conf.erb', 'puppet/server/puppet.conf.erb'),
  }

  file { [$puppet::server::params::modules_path, $puppet::server::params::common_modules_path]:
    ensure => directory,
  }

  exec {'generate_ca_cert':
    creates => "${puppet::server::params::ssl_dir}/certs/${::fqdn}.pem",
    command => "puppetca --generate ${::fqdn}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  # setup empty directories for our environments
  puppet::server::env {$puppet::server::params::environments: }

}
