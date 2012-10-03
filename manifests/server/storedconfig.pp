# = Class: puppet::server::storedconfig
#
# Configure and install storedconfig
#
class puppet::server::storedconfig  {

  package { 'rubygem-mysql':
    ensure => '2.8.1-1',
    notify => Service['httpd'],
  }
  package { 'rubygem-activerecord':
    ensure => '2.3.8-1',
  }
  package { 'rubygem-activesupport':
    ensure => '2.3.8-1',
  }



}
