# = Class: puppet::service
#
# Run the puppet client as a service.
#
class puppet::service {

  require puppet::params
  $service    = $puppet::params::service
  $pattern    = $puppet::params::service_pattern
  $hasrestart = $puppet::params::service_hasrestart
  $hasstatus  = $puppet::params::service_hasstatus
  $requires   = $puppet::params::service_requires

  service {$service:
    ensure     => 'running',
    enable     => true,
    pattern    => $pattern,
    hasrestart => $hasrestart,
    hasstatus  => $hasstatus,
    requires   => $requires,
  }

}

