#
# == Class: DNSsec / CONFIG
#
# This class configure BIND server.
#
define dnssec::config (
  $files_conf     = undef,
  $use_template   = 'yes',
  ## GLOBALS ##
  $root_jail     = $dnssec::params::root_jail,
  $config_file   = $dnssec::params::config_file
) {
  include dnssec::params

  # Set globals permissions
  File {
    owner => 'root',
    group => 'named',
    mode  => '0640',
  }

  # Main config file [/etc/named.conf]
  if $use_template == 'yes' {
    file { $config_file :
      path    => $config_file,
      content => template('dnssec/named.conf.erb'),
      notify  => Service['named'],
      require => Package['bind', 'bind-chroot'],
    }
  }
  else {
    file { $config_file :
      path    => $config_file,
      source  => ["puppet:///modules/${files_conf}/named.conf"],
      notify  => Service['named'],
      require => Package['bind', 'bind-chroot'],
    }
  }
  file { '/etc/named.conf' :
    ensure => 'link',
    target => $config_file,
  }

  # Creating tree
  ## /var/named/chroot/etc/
  ##                    '-/named.conf
  ##                    '-/named/
  ##                    '-/named/acl.conf
  ##                    '-/named/key.conf
  ##                    '-/named/logging.conf
  ##                    '-/named/conf.conf
  ## /etc/named/named.conf -> /var/named/chroot/etc/named.conf
  ##   '-/named/acl.conf -> /var/named/chroot/etc/named/acl.conf
  ##   '-/named/key.conf -> /var/named/chroot/etc/named/key.conf
  ##   '-/named/logging.conf -> /var/named/chroot/etc/named/logging.conf
  ##   '-/named/zones.conf -> /var/named/chroot/etc/named/zones.conf
  ##

  # Sync directory confs [/etc/named] & Create a link to root jail
  file {'DirConfSync':
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    mode    => '0650',
    name    => "${root_jail}/etc/named",
    source  => ["puppet:///modules/${files_conf}/named"],
    require => Package['bind', 'bind-chroot'],
    before  => File[$config_file],
  }

  # Create syn links to config:acl.conf  key.conf  logging.conf  zones.conf
  file { 'DirConfLinkAcl' :
    ensure  => 'link',
    path    => '/etc/named/acl.conf',
    target  => "${root_jail}/etc/named/acl.conf",
    require => File['DirConfSync'],
  }
  file { 'DirConfLinkKey' :
    ensure  => 'link',
    path    => '/etc/named/key.conf',
    target  => "${root_jail}/etc/named/key.conf",
    require => File['DirConfSync'],
  }
  file { 'DirConfLinkLog' :
    ensure  => 'link',
    path    => '/etc/named/logging.conf',
    target  => "${root_jail}/etc/named/logging.conf",
    require => File['DirConfSync'],
  }
  file { 'DirConfLinkZones' :
    ensure  => 'link',
    path    => '/etc/named/zones.conf',
    target  => "${root_jail}/etc/named/zones.conf",
    require => File['DirConfSync'],
  }
}
