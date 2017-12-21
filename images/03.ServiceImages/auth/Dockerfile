FROM  engines/servicebase:$release

RUN /home/no_init.sh &&\
	apt-get -y update &&\
	apt-get -y install krb5-kdc \
				       krb5-admin-server &&\
	adduser -q --disabled-password --home /home/auth -uid 22017 auth &&\
	usermod -G containers -a auth &&\
 	/home/post_build_clean.sh

COPY home home
COPY src/kadm5.acl /etc/krb5/kadm5.acl
COPY src/krb5.conf /etc/
COPY src/kdc.conf /etc/krb5kdc/
COPY sudoers /etc/sudoers.d/auth


RUN	mkdir -p  /home/auth/keys &&\
	chown -R auth /home/auth &&\
 	mkdir -p  /home/auth/static &&\
 	chown root /home/auth/static &&\
 	chmod g-w /home/auth &&\
	ln -s /home/.ssh /home/auth/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/ &&\
	chmod og-rwx /home/engines/scripts/first_run/key_list

USER auth
Env	ContUser auth
CMD ["/home/start.sh"]