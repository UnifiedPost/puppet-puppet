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
# $ssl_dir::        Folder where to store ssl certs.
#                   Defaults to /var/lib/puppet/ssl.
#
# == Todo:
#
# * Remove params that are not specific to the client. -> puppet::server::params
#
class puppet::params (
  $user                = 'puppet',
  $group               = 'puppet',
  $dir                 = '/etc/puppet',
  $modules             = undef,
  $common_modules      = undef,
  $environments        = [ 'development', 'production' ],
  $ssl_dir             = '/var/lib/puppet/ssl',
  $servername          = undef,
  $prerun_command      = undef,
  $report              = undef
) {

##  include foreman::params

  $dirfix_permissions = [
    '/var/lib/puppet/reports',
  ]


  ## Setup defaults for vars that dont have a fixed str only default (undef).
  $modules_path = $modules ? {
    undef   => "${dir}/modules",
    default => $modules,
  }
  $common_modules_path = $common_modules ? {
    undef   => "${modules_path}/common",
    default => $common_modules,
  }


  ### Puppet client service configuration ###

  $service            = $::operatingsystem ? {
    default => 'puppet',
  }
  $service_pattern    = $::operatingsystem ? {
    /(?i:centos|redhat)/ => 'puppetd',
    /(?i:debian|ubuntu)/ => 'puppet agent',
    default              => 'puppet agent',
  }
  $service_hasstatus =  $::operatingsystem ? {
    default => true
  }
  $service_hasrestart = $::operatingsystem ? {
    default => true
  }
  $service_requires = $::operatingsystem ? {
    default => []
  }

}
