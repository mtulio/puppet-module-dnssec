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

  ## GLOBAL options ##
  $gb_opt_directory       = '/var/named/chroot/var/named'
  $gb_opt_dump_file       = '/var/named/data/cache_dump.db'
  $gb_opt_stats_file      = '/var/named/data/named_stats.txt'
  $gb_opt_mstats_file     = '/var/named/data/named_mem_stats.txt'
  
  $gb_opt_version         = 'undisclosed'
  
  $gb_opt_recursion       = 'no'
  $gb_opt_allow_recursion = 'any'

  $gb_opt_allow_query     = 'any'
  $gb_opt_cli_per_query   = '0'
  $gb_opt_max_cli_p_query = '0'

  $gb_dnssec_en           = 'yes'

} # end class
