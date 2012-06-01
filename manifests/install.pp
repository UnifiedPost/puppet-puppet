# = Class: puppet::install
#
# Installs puppet.
#
class puppet::install {
  package { 'puppet': ensure => installed }
  file { '/usr/lib/ruby/site_ruby/1.8/puppet/type/yumrepo.rb':
    source  => 'puppet:///modules/puppet/yumrepo.rb',
    group   => '0',
    owner   => '0',
    mode    => '0644',
  }

}
