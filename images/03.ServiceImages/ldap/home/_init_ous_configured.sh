#!/bin/bash

#Create dc=engines,dc=internal
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/init.ldif

#ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif
#ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif

#tree root groups and ous 
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/initial_ous.ldif

#Schema for postfix virtual accounts integration
ldapadd -Y EXTERNAL -H ldapi:/// -f /home/tmpls/postfix.ldif
 
#setup sasl params and user mapping to kererbos principles
ldapmodify -Y EXTERNAL -H ldapi:/// -f /home/tmpls/auth.ldif