# = Class: puppet::server::params
#
# Configure settings for puppet server, If undefined, falls back to the
# parameters defined in puppet::params
#
# == Parameters:
#
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
  $user           = $puppet::params::user,
  $dir            = $puppet::params::dir,
  $modules        = undef,
  $common_modules = undef,
  $environments   = $puppet::params::environments,
  $ca             = $puppet::params::ca,
  $passenger      = $puppet::params::passenger,
  $apache_confdir = undef,
  $approot        = undef,
  $ssl_dir        = $puppet::params::ssl_dir,
  $reports        = 'foreman'
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

  $ssl_cert = "${ssl_dir}/certs/${::fqdn}.pem"
  $ssl_cert_key = "${ssl_dir}/private_keys/${::fqdn}.pem"
  $ssl_noca_cert = "${ssl_dir}/certs/ca.pem"
  $ssl_chain  = "${ssl_dir}/ca/ca_crt.pem"
  $ssl_ca_cert = "${ssl_dir}/ca/ca_crt.pem"
  $ssl_ca_crl = "${ssl_dir}/ca/ca_crl.pem"
}

