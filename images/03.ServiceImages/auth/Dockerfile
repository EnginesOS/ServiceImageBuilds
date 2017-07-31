FROM  engines/servicebase:$release

RUN /home/no_init.sh &&\
	apt-get -y update &&\
	apt-get -y install openssh-server mysql-client krb5-kdc-ldap krb5-kdc krb5-admin-server expect &&\
	echo "Y" | adduser -q --disabled-password --home /home/auth -uid 22017 auth &&\
	usermod -G containers -a auth &&\
 	/home/post_build_clean.sh

COPY home home
COPY kadm5.acl /etc/krb5kdc
COPY krb5.conf /etc/
COPY sudoers /etc/sudoers.d/auth


RUN	mkdir -p  /home/auth/keys &&\
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