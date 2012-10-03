# = Class: puppet::install
#
# Installs puppet.
#
class puppet::install {
  package { 'puppet': ensure => installed }

}
