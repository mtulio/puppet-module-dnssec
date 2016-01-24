
# DNSsec keys management

---

Create ZSK and KSK key (creating entropy):

~~~
 dnssec-keygen -a NSEC3RSASHA1 -b 512 -n ZONE example.com &\
 dnssec-keygen -f KSK -a NSEC3RSASHA1 -b 512 -n ZONE example.com &\
 while true ; do test "$(pidof dnssec-keygen >/dev/null && echo $?)" == "0" && ls -R / >/dev/null || break; done
~~~

Update Keys on zone:
~~~
 for key in `ls Kexample.com*.key`
 do
   echo "\$INCLUDE keys/$key">> db.example.com
 done
~~~


FONTE:
* [Setup DNSSEC] (https://www.digitalocean.com/community/tutorials/how-to-setup-dnssec-on-an-authoritative-bind-dns-server--2)
