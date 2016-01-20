#
# == Class: DNSsec / Parameters
#
# Configuration parameters of module dnssec
#
class dnssec::params {
  
  $root_jail      = '/var/named/chroot/'
  #$package_name   = 'bind'
  $package_name = $::osfamily ? {
    'RedHat' => 'bind',
    'Debian' => 'bind9',
    default  => 'bind',
  }
  #$package_chroot = 'bind-chroot'
  $package_chroot = $::osfamily ? {
    'RedHat' => 'bind-chroot',
    'Debian' => 'bind9',
    default  => 'bind-chroot',
  }
  $service_name   = 'named'

  $config_file    = "${root_jail}etc/named.conf"
  $config_zone    = "${root_jail}etc/named.zones.conf"
  $dir_zone       = "${root_jail}var/named"
  $dir_log        = "${root_jail}var/log"
  $ip_addr        = $::ipaddress
  $dir_scripts    = 'puppet:///modules/dnssec/scripts'
  $script_sign    = 'dnssec_sign_zones.sh'

} # end class
