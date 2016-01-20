#
# == Class: DNSsec / EXEC
#
# Commands to be executed by 'notify commands'.
#
class dnssec::exec (
  $dir_zone    = $dnssec::params::dir_zone,
  $script_sign = $dnssec::params::script_sign
) inherits dnssec {
  exec { 'ExecSignAll' :
    command     => "${dir_zone}/master/${script_sign}",
    refreshonly => true,
    require     => File['ScriptSignZone']
  }
}
