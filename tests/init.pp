# Test DNSsec with local repository
class { '::dnssec':
  base_config    => '0_REPO/dnssec/pool_dmz',
  server_type    => 'master',
  dnssec_enabled => 'yes',
}
