FROM engines/servicebase:$release

RUN  /home/engines/scripts/build/no_init.sh &&\			
	apt-get update -y &&\
	apt-get install -y  samba \
						smbldap-tools \
	                    libnss-mysql-bg \
	                    libpam-mysql \
	                    mysql-client \
	                    rpcbind &&\
 	/home/engines/scripts/build/post_build_clean.sh
	
COPY src/etc /etc/

RUN chmod 600 /etc/nss-mysql-root.conf &&\
	useradd -u 22019  -g samba -d /home/samba -m -G containers samba 
	
CMD ["/home/engines/scripts/system/start.sh"]
#USER samba