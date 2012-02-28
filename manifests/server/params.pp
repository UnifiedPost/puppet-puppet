# = Class: puppet::server::params
#
# Configure settings for puppet server, If undefined, falls back to the
# parameters defined in puppet::params
#
# == Parameters:
#
# Most parameters are mirrored from puppet::params. These have been added:
#
# $rackconfig_source::    The config.ru file to run as a rack application.
#
# $servername::           Hostname to use when setting up the server.
#
# == Sample Usage:
#
#   class {'puppet::server::params':
#   }
#
# == Todo:
#
# * Remove params that are not server specific.
#
class puppet::server::params (
  $user              = $puppet::params::user,
  $dir               = $puppet::params::dir,
  $modules           = undef,
  $common_modules    = undef,
  $environments      = $puppet::params::environments,
  $ca                = $puppet::params::ca,
  $passenger         = $puppet::params::passenger,
  $apache_confdir    = undef,
  $approot           = undef,
  $rackconfig_source = undef,
  $ssl_dir           = $puppet::params::ssl_dir,
  $reports           = 'foreman',
  $servername        = $puppet::params::servername
){
  require puppet::params

  $modules_path =  $modules ? {
    undef   => $puppet::params::modules_path,
    default => $modules,
  }

  $common_modules_path =  $common_modules ? {
    undef   => $puppet::params::common_modules_path,
    default => $common_modules,
  }

  $apache_conf_dir = $apache_confdir ? {
    undef   => $puppet::params::apache_conf_dir,
    default => $apache_confdir,
  }

  $app_root = $approot ? {
    undef   => $puppet::params::app_root,
    default => $approot
  }
  $doc_root = "${app_root}/public/"

  $rack_config_source =  $rackconfig_source ? {
    undef   => 'puppet:///modules/puppet/config.ru',
    default => $rackconfig_source,
  }

  $hostname = $servername ? {
    undef   => $::fqdn,
    default => $servername
  }

  $ssl_cert      = "${ssl_dir}/certs/${hostname}.pem"
  $ssl_cert_key  = "${ssl_dir}/private_keys/${hostname}.pem"
  $ssl_noca_cert = "${ssl_dir}/certs/ca.pem"
  $ssl_chain     = "${ssl_dir}/ca/ca_crt.pem"
  $ssl_ca_cert   = "${ssl_dir}/ca/ca_crt.pem"
  $ssl_ca_crl    = "${ssl_dir}/ca/ca_crl.pem"


  ### Puppetmaster service configuration ###

  $service = $::operatingsystem ? {
    default => 'puppetmaster',
  }
  $service_pattern = $::operatingsystem ? {
    /(?i:centos|redhat)/ => 'puppetmasterd',
    /(?i:debian|ubuntu)/ => 'puppet master',
    default              => 'puppet master',
  }
  $service_hasstatus = $::operatingsystem ? {
    default => true
  }
  $service_hasrestart = $::operatingsystem ? {
    default => true
  }
  $service_requires = $::operatingsystem ? {
    default => []
  }

}

