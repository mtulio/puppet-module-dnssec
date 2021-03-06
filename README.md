# dnssec

[![Puppet Forge](http://img.shields.io/puppetforge/v/mtulio/dnssec.svg)](https://forge.puppetlabs.com/mtulio/dnssec)
[![Build Status](https://travis-ci.org/mtulio/puppet-mod-dnssec.png?branch=master)](https://travis-ci.org/mtulio/puppet-mod-dnssec)

#### Table of Contents

1. [Overview](#1-overview)
2. [Module Description](#2-module-description)
3. [Setup](#3-setup)
    * [What module affects](#what-module-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning](#beginning)
4. [Usage](#4-usage)
5. [Tests](#5-tests)
6. [Limitations](#5-limitations)
7. [Development](#6-development)
8. [Release Notes](#7-release-notes)


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
* /var/named/chroot/var/named/master/zones				: Zones files
* /var/named/chroot/var/named/master/zones/keys				: Zones keys, if dnssec is enabled
* /var/named/chroot/var/named/default					: Default zones files - localhost, hint, etc

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

1. Using default template [zone example.com]

```
class { '::dnssec': 
  server_type    => 'master',
  dnssec_enabled => 'yes',
}
```

## 5. Tests

1. Check BIND version
```
# dig @127.0.0.1 -c CH -t txt version.bind +short
```

## 6. Limitations

OS compatibility [tested]: 
* Red Hat family 7+ 

We're working to support more OS.

## 7. Development

See project page at :
* Github: https://github.com/mtulio/puppet-mod-dnssec
* Puppet forge: https://forge.puppetlabs.com/mtulio/dnssec

## 8. Release Notes

[1.0.2]
* Create firewall rules on all interfaces

[1.0.1]
* Fix metadata dependences

[1.0.0]
* Add dnssec support to be configured from templates
* Add script to sign zones
* Fix directories of templates
* Fix bugs on 'example' zone

[0.0.1]
* Initial version, basic bind configuration
