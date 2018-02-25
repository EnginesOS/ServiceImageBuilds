FROM engines/servicebase:$release

RUN adduser -q --disabled-password --home /home/.home_dir -uid 22033 uadmin &&\
	usermod -G containers -a uadmin &&\
	apt-get -y install    &&\
	/home/no_init.sh &&\	
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
 	/home/post_build_clean.sh
	
	
COPY  home/ /home
COPY sudoers /etc/sudoers.d/uadmin
RUN chmod og-rw /etc/sudoers.d/uadmin &&\
	cd /home &&\
	git clone https://github.com/lachdoug/user_admin.git /home/app &&\
	/home/engines/scripts/engine/deploy.sh


ENV ContUser uadmin
ENV ContGrp uadmin

USER uadmin

CMD ["/home/engines/scripts/startup/start.sh"]