FROM  engines/servicebase:$release

RUN /usr/sbin/addgroup --gid 21999 edocker;\
	/usr/sbin/addgroup --gid 909 docker;\
	/home/no_init.sh ;\	
	apt-get update -y;\
	apt-get -y install ruby-dev telnet libsqlite3-dev libcurl4-openssl-dev build-essential libssl-dev libreadline-dev zlib1g-dev ;\
	echo "Y" | adduser -q --uid 21000 --gid 21999 --home /home/engines --disabled-password engines;\
	 mkdir -p  /opt/engines/run/system/;\	
	chown -R engines /opt/engines/run/system/ /home/engines /var/log/;\
	usermod -G docker -a engines


#ENV ruby_version 2.3.0
#ENV  RBENV_ROOT /usr/local/rbenv

#RUN 	mkdir -p /usr/local/ ; cd /usr/local/ ; git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv;\ 
#	cd /usr/local/rbenv ; git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-buil;\
#	cd /usr/local/rbenv   ;echo 'export PATH="/usr/local/rbenv/bin:$PATH:/usr/local/rbenv/shims/"' >> /home/engines/.bashrc ; echo 'eval "$(rbenv init -)"' >> ~/.bashrc ; exec $SHELL  ;/usr/local/rbenv/bin/rbenv install $ruby_version ; /usr/local/rbenv/bin/rbenv global $ruby_version
	
RUN	gem install  --no-rdoc --no-ri  git bundle  rest-client net_http_unix excon;\
				gem install  gctools yajl-ruby  sinatra thin rubytree  sinatra-contrib \
				  warden data_mapper dm-sqlite-adapter ffi-yajl sqlite3;\				
 				/home/post_build_clean.sh
	
ADD home home
ADD profile /home/engines/.profile


ENV ContUser engines
ENV ContGrp ruby

#need to create as linking sqllite
RUN mkdir -p /home/app/db
RUN chown engines /home/app/db 

WORKDIR /home/app/
RUN	git init

ADD gitconfig /home/app/.git/config
ADD sudoers /etc/
RUN mkdir -p /home/engines/.ssh/mgmt /home/app/tmp/ ;\	
 	chown -R 21000 /home/app/public /home/configurators/saved /home/app/tmp/;\
 	usermod -G containers -a engines  ;\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
 	

ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin
ENV HOME /home/engines/
		
USER 21000


CMD ["/home/start.sh"]