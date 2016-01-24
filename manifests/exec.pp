#
# == Class: DNSsec / EXEC
#
# Commands to be executed by 'notify commands'.
#
class dnssec::exec (
  $dir_zone    = $dir_zone,
  $script_sign = $script_sign,
  $dnssec_en   = $gb_dnssec_en
) inherits dnssec {

  if $dnssec_en == 'yes' {
    exec { 'ExecSignAll' :
      command     => "${dir_zone}/master/${script_sign}",
      refreshonly => true,
      require     => File['ScriptSignZone']
    }
  }
}
