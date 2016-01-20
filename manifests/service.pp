#
# == Class: DNSsec / Package
#
# Manage service.
#
class dnssec::service (
  $service_name = $dnssec::params::service_name
) inherits dnssec {

  service { 'named':
    ensure  => running,
    name    => $service_name,
    enable  => true,
    require => Package['bind','bind-chroot'],
  }
}
