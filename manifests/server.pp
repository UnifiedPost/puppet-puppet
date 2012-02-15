# = Class: puppet::server
#
# Install and configure the puppet master
#
class puppet::server {
  include puppet::server::install
  include puppet::server::config
}
