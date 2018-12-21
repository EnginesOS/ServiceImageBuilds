FROM engines/servicebase:$release

RUN  useradd -u 22033  -g uadmin -d /home/.home_dir  -m -G containers uadmin &&\
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get update -y &&\
	apt-get -y install ruby-dev \
						telnet \
						libsasl2-modules-gssapi-mit \
						libsqlite3-dev \
						libcurl4-openssl-dev \
						build-essential \
						libssl-dev \
						libreadline-dev \
						autoconf \
						libltdl-dev \
						zlib1g-dev &&\
	gem install --no-rdoc --no-ri git bundle  \
	 			gctools  sinatra thin  sinatra-contrib &&\		
 	/home/engines/scripts/build/post_build_clean.sh
	
	
COPY  home/ /home
COPY sudoers /etc/sudoers.d/uadmin
RUN chmod og-rw /etc/sudoers.d/uadmin &&\
	cd /home &&\
	gem install net-ldap &&\
	git clone https://github.com/lachdoug/user_admin.git /home/app &&\
	/home/engines/scripts/engine/deploy.sh &&\
	chown -R uadmin /home/app


ENV ContUser uadmin
ENV ContGrp uadmin

USER uadmin

CMD ["/home/engines/scripts/system/start.sh"]