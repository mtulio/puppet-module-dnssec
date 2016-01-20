# dnssec

#### Table of Contents

1. [Overview](#1-overview)
2. [Module Description](#2-module-description)
3. [Setup](#3-setup)
    * [What module affects](#what-module-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning](#beginning)
4. [Usage](#4-usage)
5. [Limitations](#5-limitations)
6. [Development](#6-development)
7. [Release Notes](#7-release-notes)


## 1. Overview

This module to install and configure DNS server using BIND.

## 2. Module Description


Module to manage DNS server using BIND.

This module install and configure DNS server using BIND and sign DNSsec zones using script. 

Chroot is defined on config file. 

The struct of directories and files are:

* /etc/named.conf -> /var/named/chroot/etc/named.conf			: Main config file.
* /etc/named/acl.conf -> /var/named/chroot/etc/named/acl.conf		: Access control list.
* /etc/named/key.conf -> /var/named/chroot/etc/named/key.conf		: Keys management.
* /etc/named/logging.conf -> /var/named/chroot/etc/named/logging.conf	: Configuration of loggins and channels
* /etc/named/zones.conf -> /var/named/chroot/etc/named/zones.conf	: Zones configuration.

## 3. Setup

 See [Usage](#4-usage)

### What module affects

* This module module will install Bind9, copy configuration files to chroot directory, copy zones to zones directory, and sign zones.

### Setup Requirements 

* Firewall module: puppetlabs-firewall (v1.1.3)

### Beginning 

This is a great module to configure BIND server. Now the configuration is static in pools of configuration or the templates. But soon you will configure all the configuration options at declaration of class.

## 4. Usage

You have three ways to usage the class: 

1. Using default template

```
class { '::dnssec': 
  base_config    => '0_REPO/dnssec/pool_dmz',
  server_type    => 'master',
  dnssec_enabled => 'yes',
}
```

## 5. Limitations

OS compatibility [tested]: 
* Red Hat family 7+ 

We're working to support more OS.

## 6. Development

See project page at :
* Github: https://github.com/mtulio/puppet-mod-dnssec
* Puppet forge: https://forge.puppetlabs.com/mtulio/dnssec

## 7. Release Notes

[1.0.0]
* Add dnssec support to be configured from templates

