# = Class: puppet::server::service
#
# Sets up the puppet master service.
#
class puppet::server::service {

  require puppet::server::params
  $service    = $puppet::server::params::service
  $pattern    = $puppet::server::params::service_pattern
  $hasrestart = $puppet::server::params::service_hasrestart
  $hasstatus  = $puppet::server::params::service_hasstatus
  $requires   = $puppet::server::params::service_requires

  service {$service:
    ensure     => 'running',
    enable     => true,
    pattern    => $pattern,
    hasrestart => $hasrestart,
    hasstatus  => $hasstatus,
    requires   => $requires,
  }

}

