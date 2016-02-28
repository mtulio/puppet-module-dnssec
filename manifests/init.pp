#
# == Class: DNSsec
#
# This module to install and configure DNS server using BIND.
#
# === Examples
#
#  See test/ directory or README[Usage] documentation.
#
class dnssec (
  ## GLOBAL config ##
  $package_name   = $dnssec::params::package_name,
  $package_chroot = $dnssec::params::package_chroot,
  $service_name   = $dnssec::params::service_name,
  $config_file    = $dnssec::params::config_file,
  $config_zone    = $dnssec::params::config_zone,
  $dir_zone       = $dnssec::params::dir_zone,
  $dir_log        = $dnssec::params::dir_log,
  $ip_addr        = $dnssec::params::ip_addr,
  $script_sign      = $dnssec::params::script_sign,

  $gb_dnssec_en      = $dnssec::params::gb_dnssec_en,
  $gb_opt_directory  = $dnssec::params::gb_opt_directory,
  $gb_opt_version    = $dnssec::params::gb_opt_version,
  $gb_opt_recursion  = $dnssec::params::gb_opt_recursion,

  ## CLASS config ##
  $base_config     = undef,
  $server_type     = 'master',
) inherits dnssec::params {

  # Instala e inicia o serviço
  include dnssec::package
  include dnssec::service
  include dnssec::exec

  if $base_config {
    $files_zone = "${base_config}/${server_type}/var_named"
    $files_conf = "${base_config}/${server_type}/etc"
    $use_template = 'yes'
  }
  else {
    # path of 'files' directory
    $files_zone = "dnssec/pool_example/${server_type}/var_named"
    $files_conf = "dnssec/pool_example/${server_type}/etc"
    $use_template = 'yes'
  }

  dnssec::zonesync { $::hostname:
    files_zone   => $files_zone,
    server_type  => $server_type,
    gb_dnssec_en => $gb_dnssec_en,
  }

  # Config server
  dnssec::config { $::hostname:
    files_conf   => $files_conf,
    use_template => $use_template,
    gb_dnssec_en => $gb_dnssec_en,
  }
  
  notice('# Todos os dados foram sincronizados do servidor MASTER')


  # Setup firewall rules
  if $::osfamily == 'redhat' and $::operatingsystemmajrelease == 7 {

    ensure_packages('iptables-services', {'ensure' => 'latest'})

    Package['iptables-services'] -> Firewall <| |>

    service { 'firewalld':
      enable => false,
    }

    service { 'iptables':
      enable => true,
    }
  }

  firewall { '000 accept TCP DNS queries ':
    proto   => 'tcp',
    port    => '53',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
  firewall { '000 accept UDP DNS queries ':
    proto   => 'udp',
    port    => '53',
    action  => 'accept',
  }
}
