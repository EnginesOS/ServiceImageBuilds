FROM  engines/servicebase:$release


RUN /usr/sbin/addgroup --gid 21999 edocker &&\
	/usr/sbin/addgroup --gid 909 docker &&\
	/home/no_init.sh &&\	
	apt-get update -y &&\
	apt-get -y install ruby-dev \
						telnet \
						libsqlite3-dev \
						libcurl4-openssl-dev \
						build-essential \
						libssl-dev \
						libreadline-dev \
						zlib1g-dev &&\
	echo "Y" | adduser -q --uid 21000 --gid 21999 --home /home/engines --disabled-password engines &&\
	mkdir -p /opt/engines/run/system/ &&\	
	chown -R engines /opt/engines/run/system/ /home/engines /var/log/ &&\
	usermod -G docker -a engines &&\
	gem install --no-rdoc --no-ri git bundle rest-client net_http_unix excon \
	 			gctools yajl-ruby sinatra thin rubytree  sinatra-contrib \
			 	warden data_mapper dm-sqlite-adapter ffi-yajl sqlite3 &&\				
 	/home/post_build_clean.sh
	
ADD home home
ADD profile /home/engines/.profile

ENV ContUser engines
ENV ContGrp ruby

#need to create as linking sqllite
RUN mkdir -p /home/app/db;\
 	chown engines /home/app/db 

WORKDIR /home/app/

RUN	git init

ADD gitconfig /home/app/.git/config
ADD sudoers /etc/

RUN mkdir -p /home/engines/.ssh/mgmt /home/app/tmp/ /home/app/public &&\	
 	chown -R 21000 /home/app/public /home/configurators/saved /home/app/tmp/ &&\
 	usermod -G containers -a engines &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin
ENV HOME /home/engines/
		
USER 21000

CMD ["/home/start.sh"]