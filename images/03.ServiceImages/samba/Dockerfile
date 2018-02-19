FROM engines/servicebase:$release

RUN  /home/no_init.sh &&\			
	apt-get update -y &&\
	apt-get install -y  samba \
						smbldap-tools \
	                    libnss-mysql-bg \
	                    libpam-mysql \
	                    mysql-client \
	                    rpcbind &&\
 	/home/post_build_clean.sh
	
COPY src/etc /etc/

RUN chmod 600 /etc/nss-mysql-root.conf &&\
	adduser --uid 22019 -q --home /home/samba --disabled-password samba &&\
	usermod -G containers -a samba
	
CMD ["/home/engines/scripts/startup/start.sh" ]
#USER samba