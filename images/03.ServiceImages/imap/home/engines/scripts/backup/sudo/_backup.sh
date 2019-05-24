#!/bin/bash


tar -cpf - /var/lib/dovecot  /var/mail 
rm /tmp/database.sql 
