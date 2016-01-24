# Test DNSsec with local repository
class { '::dnssec':
  server_type  => 'master',
  gb_dnssec_en => 'yes',
}
