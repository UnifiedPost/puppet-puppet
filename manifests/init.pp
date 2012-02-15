# = Class: puppet
#
# Configure/Install/Setup puppet
#
class puppet {
  include puppet::params
  include puppet::install
  include puppet::config
}
