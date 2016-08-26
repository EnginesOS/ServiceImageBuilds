FROM  engines/servicebase:$release
RUN apt-get -y update;\
	/home/no_init.sh ;\
	apt-get -y install syslogd openssh-server mysql-client krb5-kdc krb5-admin-server expect;\
	echo "Y" | adduser -q --disabled-password --home /home/auth -uid 22017 auth;\
	usermod -G containers -a auth ;\
 	/home/post_build_clean.sh

COPY home home
COPY kadm5.acl /etc/
COPY krb5.conf /etc/

COPY sudoers /etc/	
RUN	ssh-keygen -f /home/auth/ssh/ssh_host_rsa_key  -N '' -t rsa;\
	ssh-keygen -f /home/auth/ssh/ssh_host_dsa_key  -N '' -t dsa;\
	ssh-keygen -f /home/auth/ssh/ssh_host_ecdsa_key  -N '' -t ecdsa;\
	ssh-keygen -f /home/auth/ssh/ssh_host_ed25519_key  -N '' -t ed25519;\
	mkdir -p  /home/auth/keys; \
	 chown -R auth /home/auth;\
 mkdir -p  /home/auth/static;\
 chown root /home/auth/static;\
 chmod g-w /home/auth
 
#;\
#	/usr/sbin/kdb5_util create -s;\
#	 /usr/sbin/kadmin.local -q "addprinc administrator/admin"

USER auth
Env	ContUser auth
CMD ["/home/start.sh"]