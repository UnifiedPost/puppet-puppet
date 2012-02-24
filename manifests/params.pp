# = Class: puppet::params
#
# Change the way this puppet module to manage puppet behaves.
#
# == Parameters:
#
# $user::           The user puppet is running as. Defaults to 'puppet'.
#
# $dir::            The default main configuration directory for puppet.
#                   Defaults to '/etc/puppet'.
#
# $modules::        Path to the folder containing puppet modules.
#                   Defaults to <main config dir>/modules.
#
# $common_modules:: Location of the common puppet module.
#                   Defaults to <main modules dir>/common
#
# $environments::   Array of environments we need to setup.
#                   Defaults to ['development','production' ]
#
# $ca::             Be the CA. Defaults to true.
#
# $passenger::      Run using passenger. Defaults to true.
#
# $apache_confdir:: Main apache configuration directory.
#
# $approot::        Foreman application root. Defaults to <puppet dir>/rack.
#
# $ssldir::         Folder where to store ssl certs.
#                   Defaults to /var/lib/puppet/ssl.
#
class puppet::params (
  $user                = 'puppet',
  $dir                 = '/etc/puppet',
  $modules             = undef,
  $common_modules      = undef,
  $environments        = [ 'development', 'production' ],
  $ca                  = true,
  $passenger           = true,
  $apache_confdir      = undef,
  $approot             = undef,
  $ssl_dir             = '/var/lib/puppet/ssl'
) {

  include foreman::params


  ## Setup defaults for vars that dont have a fixed str only default (undef).
  $modules_path = $modules ? {
    undef   => "${dir}/modules",
    default => $modules,
  }
  $common_modules_path = $common_modules ? {
    undef   => "${modules_path}/common",
    default => $common_modules,
  }
  $apache_conf_dir = $apache_confdir ? {
    undef   => $foreman::params::apache_conf_dir,
    default => $apache_confdir,
  }

  $app_root = $approot ? {
    undef   => "${dir}/rack",
    default => $approot,
  }

}
