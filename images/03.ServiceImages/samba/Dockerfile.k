FROM engines/servicebase:k

RUN  /home/engines/scripts/build/no_init.sh &&\			
	apt-get update -y &&\
	apt-get install -y  samba \
						smbldap-tools \
						libnss-ldap libnss-winbind libpam-ldap ldap-auth-config\
	                    rpcbind && \
 	/home/engines/scripts/build/post_build_clean.sh
	
COPY src/etc /etc/
COPY home home
ADD sudoers /etc/sudoers.d/samba	 

RUN chmod -R go-rw /etc/sudoers /etc/sudoers.d/samba &&\
	groupadd -g 22019 samba &&\
	useradd -u 22019  -g samba -d /home/samba -m -G containers samba &&\
	mkdir -p /home/engines/etc/samba/smd.d/ &&\
	chown samba /home/engines/etc/samba/smd.d/
	
CMD ["/home/engines/scripts/system/start.sh"]
#
USER samba