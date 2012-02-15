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
