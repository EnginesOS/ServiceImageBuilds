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
						autoconf \
						libltdl-dev \
						zlib1g-dev &&\
	adduser -q --uid 21000 --gid 21999 --home /home/engines --disabled-password engines &&\
	mkdir -p /opt/engines/run/system/ &&\	
	chown -R engines /opt/engines/run/system/ /home/engines /var/log/ &&\
	usermod -G docker -a engines &&\
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 &&\
 	apt-get update -y &&\
	apt-get install -y apt-transport-https  &&\
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main >/etc/apt/sources.list.d/passenger.list &&\ 
	chmod 600 /etc/apt/sources.list.d/passenger.list &&\
	apt-get update -y &&\
	apt-get install -y passenger-dev &&\
	gem install passenger &&\   
	apt-get install -y nginx-common \
	                   nginx-extras \
	                   nginx &&\
 	mkdir -p /var/www/.passenger &&\
 	chown www-data /var/www/.passenger &&\
	usermod -G containers -a www-data &&\
 	chown www-data /var/lib/nginx/ &&\
 	passenger-config  build-native-support &&\
	gem install --no-rdoc --no-ri git bundle rest-client net_http_unix excon \
	 			gctools yajl-ruby sinatra thin rubytree  sinatra-contrib \
			 	warden data_mapper dm-sqlite-adapter ffi-yajl sqlite3 rb-inotify puma timers&&\		
 	/home/post_build_clean.sh
	
ADD home home
ADD src/profile /home/engines/.profile
COPY src/etc/nginx/ /etc/nginx
COPY src/ruby_env /home/
ADD sudoers /etc/sudoers.d/system 
ENV ContUser engines
ENV ContGrp ruby

#need to create as linking sqllite
RUN mkdir -p /home/app/db &&\
 	chown engines /home/app/db 	 &&\
	chown root /etc/sudoers.d/system &&\
	chmod og-rw /etc/sudoers.d/system 

WORKDIR /home/app/

RUN	git init

ADD src/gitconfig /home/app/.git/config

RUN mkdir -p /home/engines/.ssh/system /home/app/tmp/ /home/app/public &&\	
 	chown -R 21000 /home/app/public /home/engines/scripts/configurators/saved /home/app/tmp/ &&\
 	usermod -G containers -a engines

ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin
ENV HOME /home/engines/
		
USER 21000

CMD ["/home/engines/scripts/system/start.sh" ]