FROM  engines/servicebase:$release

RUN /home/no_init.sh &&\
	apt-get -y update &&\
	apt-get -y install openssh-server mysql-client krb5-kdc krb5-admin-server expect &&\
	echo "Y" | adduser -q --disabled-password --home /home/auth -uid 22017 auth &&\
	usermod -G containers -a auth &&\
 	/home/post_build_clean.sh

COPY home home
COPY kadm5.acl /etc/
COPY krb5.conf /etc/
COPY sudoers /etc/sudoers.d/auth

# HUGE SECURITY HOLE !!!
#RUN	ssh-keygen -f /home/auth/ssh/ssh_host_rsa_key -N '' -t rsa &&\
#	ssh-keygen -f /home/auth/ssh/ssh_host_dsa_key -N '' -t dsa &&\
#	ssh-keygen -f /home/auth/ssh/ssh_host_ecdsa_key -N '' -t ecdsa &&\
#	ssh-keygen -f /home/auth/ssh/ssh_host_ed25519_key -N '' -t ed25519 &&\
RUN	mv /var/lib/krb5kdc /var/lib/krb5kdc.init &&\
	mv /etc/krb5kdc /etc/krb5kdc.orig &&\
	mkdir -p  /home/auth/keys &&\
	chown -R auth /home/auth &&\
 	mkdir -p  /home/auth/static &&\
 	chown root /home/auth/static &&\
 	chmod g-w /home/auth &&\
	ln -s /home/.ssh /home/auth/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
 
#;\
#	/usr/sbin/kdb5_util create -s;\
#	 /usr/sbin/kadmin.local -q "addprinc administrator/admin"

USER auth
Env	ContUser auth
CMD ["/home/start.sh"]