# = Class: puppet::server::install
#
# Installs the puppet-server package.
#
class puppet::server::install {
  package { 'puppet-server': ensure => installed }


}
