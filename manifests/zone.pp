define dnssec::zone (
  $pool,
  $domain, 
  $zone_dir, 
  $zone_file
) {

  # Create/update files
  file { "${zone_dir}/${zone_file}" :
    path    => "${zone_dir}/${zone_file}",
    source  => ["puppet:///modules/dnssec/pool_${pool}/zones/${zone_file}"],
    #notify  => Service['named'],
    notify  => Exec["sign_${domain}"],
    owner   => 'root',
    group   => 'named',
    mode    => 0640,
  }
}
