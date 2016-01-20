

Detalhes dos DIRETÓRIOS:
* 0.antigos  		: Zonas/domínios antigos
* 0.desativados  	: Zonas/domínios desativados
* 1.keys  		: Diretórios de chaves PSK e KSK de cada zone [SINCRONIZADO]
* 2.zonas  		: Diretórios de definição de zonas/domínios [SINCRONIZADO]
* 3.signed  		: Diretórios que contém as zonas assinadas (criados pelo script atualiza_dnssec.sh) [SINCRONIZADO]
* atualiza_dnssec.sh 	: Script de assinatura de zona. Assina todas as zonas iniciadas com 'db.' no diretório 2.zonas/ e salva em 3.signed/ [SINCRONIZADO]
* keys			: Link de 1.keys/ , criado pelo Puppet. 
* signed		: Link de 3.signed/ , criado pelo Puppet. 
* zonas			: Link de 2.zonas/ , criado pelo Puppet. 


[SINCRONIZADO] => Diretório SINCRONIZADO automáticamente pelo puppet (módulo named).

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
