#!/bin/bash
#dc=engines,dc=internal
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/init.ldif

#tree root groups and ous 
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/initial_ous.ldif

#Schema for postfix virtual accounts integration
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/postfix.ldif
 
