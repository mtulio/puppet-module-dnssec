$TTL	5m
@	60	IN SOA	ns1.example. root.example.com. (
			2016010603 ; serial
			900       ; refresh (2 hours)
			3600       ; retry (1 hour)
			604800     ; expire (1 week)
			900       ; minimum (1 hour)
)
				
				
;---------------> REGISTRO: Name Servers

@		60		IN		A		1.1.1.1
@		60		IN		A		2.2.2.2
@		60		NS		ns1.example.com.
@		60		NS		ns2.example.com.

ns1.example.com.		IN		A 		1.1.1.1
ns2.example.com.		IN		A 		2.2.2.2

;---------------> REGISTRO: EMAIL

@		60		MX		20 		mx1.example.com.
@		60		MX		20 		mx2.example.com.
@		60		IN     TXT		"v=spf1 +a +mx +ip4:1.1.1.1/32 ip4:2.2.2.0/24 ?all"

mx1.example.com.		IN		A		1.1.1.1
mx2.example.com.		IN		A		2.2.2.2


;---------------> REGISTRO: IPs 


;---------------> REGISTRO: Keys

$INCLUDE keys/Kexample.com.+007+32378.key
$INCLUDE keys/Kexample.com.+007+46686.key

; EOF && EOL

