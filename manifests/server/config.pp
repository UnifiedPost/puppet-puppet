# = Class: puppet::server::config
#
# Configure and setup puppet and puppet master
#
class puppet::server::config inherits puppet::config {
  require puppet::params
  require puppet::server::params
  $user                = $puppet::server::params::user
  $grp                 = $puppet::server::params::group
  $hostname            = $puppet::server::params::hostname
  $puppet_dir          = $puppet::server::params::dir
  $environments        = $puppet::server::params::environments
  $passenger           = $puppet::server::params::passenger
  $modules_path        = $puppet::server::params::modules_path
  $common_modules_path = $puppet::server::params::common_modules_path
  $autosign            = $puppet::server::params::autosign
  $ca                  = $puppet::server::params::ca
  $ssl_cert            = $puppet::server::params::ssl_cert
  $ssl_ca_crl          = $puppet::server::params::ssl_ca_crl
  $ssl_ca_cert         = $puppet::server::params::ssl_ca_cert
  $ssl_ca_pass         = $puppet::server::params::ssl_ca_pass
  $ssl_ca_key          = $puppet::server::params::ssl_ca_key
  $stored_config       = $puppet::server::params::stored_config
  $manage_modules_path = $puppet::server::params::manage_modules_path
  $manifest            = $puppet::server::params::manifest
  $default_environment = $puppet::server::params::default_environment

  if $passenger  { include puppet::server::passenger }
  if $stored_config  { include puppet::server::storedconfig }

  File ["${puppet_dir}/puppet.conf"] {
    content => template(
      'puppet/puppet.conf.erb',
      'puppet/server/puppet.conf.erb'
    ),
  }

  if $autosign {
    file { "${puppet_dir}/autosign.conf":
      ensure  => 'present',
      mode    => '0664',
      owner   => $user,
      group   => $grp,
      content => template('puppet/server/autosign.conf.erb'),
    }
  }

  if ($manage_modules_path) {
    file { [$modules_path, $common_modules_path]:
      ensure => 'directory',
    }
  }

  exec {'generate_ca_cert':
    creates => $ssl_cert,
    command => "puppetca --generate ${hostname}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require => File["${puppet_dir}/puppet.conf"],
  }

  if $ca {
    file {$ssl_ca_crl:
      ensure  => 'present',
      mode    => '0664',
      require => Exec['generate_ca_cert'],
    }
    file {$ssl_ca_cert:
      ensure  => 'present',
      mode    => '0660',
      require => Exec['generate_ca_cert'],
    }
    file {$ssl_ca_pass:
      ensure  => 'present',
      mode    => '0660',
      require => Exec['generate_ca_cert'],
    }
    file {$ssl_ca_key:
      ensure  => 'present',
      mode    => '0660',
      require => Exec['generate_ca_cert'],
    }
  }
  # setup empty directories for our environments
  puppet::server::env {$environments: }

}
