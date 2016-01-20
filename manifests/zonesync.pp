#
# == Class: DNSsec / ZoneSYNC
#
# This class sync your zones.
#
# == Logic Sequence:
#
#      1             2                           3
# SyncDirVar -> ScriptSignZone -> SyncDirZones (notify[ScriptSignZone,Service]
#
# == Directory tree:
#
# tree [master]
## /var/named/chroot/var/named/[master|slave]
##                                    '-/zones      [1]
##                                    '-/zones/keys [2]
##                                    '-/zones/dsset[3]
##                                    '-/signed     [4]
##                          '-/default              [5]
# Where:
## [1] Directory of zones
## [2] Directory of each keys of zones [key files must be here]
## [3] Directory of each dsset of zones [dsset files must be here - script will
##      generate at once]
## [4] Directory of signed zones (if dnssec is enable). NOTE: This dir will be 
##     created after script[dnssec_sign_zones.sh] have been ran with success.
## [5] Default zones: stub, localhost, etc
#
define dnssec::zonesync (
  $files_zone  = undef,
  $server_type = $server_type,
  $dnssec_en   = $dnssec_en,

  ## GLOBALS ##
  $config_file   = $dnssec::params::config_file,
  $dir_zone      = $dnssec::params::dir_zone,
  $dir_scripts   = $dnssec::params::dir_scripts,
  $script_sign   = $dnssec::params::script_sign
) {

  include dnssec::params

  # Set globals permissions
  File {
    owner => 'root',
    group => 'named',
    mode  => '0640',
  }

  #1 Sync directory /var/named/master/
  file {'SyncDirVar':
    ensure  => directory,
    name    => "${dir_zone}/${server_type}",
    before  => File[$config_file],
    require => Package['bind','bind-chroot'],
  }

  file {'SyncDirZones':
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    name    => "${dir_zone}/${server_type}/zones",
    source  => ["puppet:///modules/${files_zone}/zones/"],
    require => File['SyncDirVar'],
    notify  => [Exec['ExecSignAll'],Service['named']],
  }

  if $server_type == 'master' and $dnssec_en == 'yes' {
      #notice("script [${dir_scripts}/${script_sign}]")
      file {'ScriptSignZone':
        path    => "${dir_zone}/${server_type}/${script_sign}",
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => "${dir_scripts}/${script_sign}",
        require => File['SyncDirVar'],
        before  => File['SyncDirZones'],
      }
  }

  ########################
  # Sync pool_default/zones
  file {'SyncDirZonesDefault':
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    name    => "${dir_zone}/default",
    source  => ['puppet:///modules/dnssec/pool_default/zones/default/'],
    before  => File[$config_file],
    require => Package['bind','bind-chroot'],
  }
}
