#MTulios Puppet Modules

####Table of Contents

[Overview](#overview)
[Module: named](#module-named)
*  [Modules - xxx](#modules-xx)

##Overview

Module to provisioning and keep configuration of DNS zones

* Keep these files:
named.conf
named_zones.conf
named_zones_..
> Notify daemon and rndc

master/
'- keys/
 '-- key symlinks to domain
'- db.zoneX
'- script_resign_zone.sh


