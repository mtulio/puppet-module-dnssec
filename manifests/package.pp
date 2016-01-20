#
# == Class: DNSsec / Package
#
# Manage packages.
#
class dnssec::package (
  $package_name = $dnssec::params::package_name,
  $package_chroot = $dnssec::params::package_chroot
) inherits dnssec {

  package { 'bind':
    ensure => present,
    name   => $package_name,
  }
  package { 'bind-chroot':
    ensure => present,
    name   => $package_chroot,
  }
}
