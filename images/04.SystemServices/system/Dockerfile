FROM  engines/servicebase:$release


RUN /usr/sbin/addgroup --gid 21999 edocker &&\
	/usr/sbin/addgroup --gid 909 docker &&\
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get install -y dirmngr gnupg  apt-transport-https &&\
 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 &&\
	echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main >/etc/apt/sources.list.d/passenger.list &&\ 
	chmod 600 /etc/apt/sources.list.d/passenger.list &&\
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
	useradd -u 21000  -g edocker -d /home/engines -M -G containers engines &&\
	mkdir -p /opt/engines/run/system/ &&\
	chown -R engines /opt/engines/run/system/ /home/engines /var/log/ &&\
	usermod -G docker -a engines &&\
	gem install passenger &&\
	apt-get install -y nginx-common \
	                   nginx-extras \
	                   nginx \
					   libnginx-mod-http-passenger &&\
 	mkdir -p /var/www/.passenger &&\
 	chown engines /var/www/.passenger &&\
	usermod -G containers -a www-data &&\
 	chown engines /var/lib/nginx/ &&\
 	passenger-config  build-native-support &&\
 	touch /home/.env_vars  &&\
 	chown engines /home/.env_vars /var/run/ &&\
    gem update &&\
    gem update --system &&\
    echo 'gem: --no-document' >> ~/.gemrc &&\
	gem install git bundle rest-client net_http_unix excon \
	 			gctools yajl-ruby sinatra thin rubytree  sinatra-contrib sinatra-cross_origin\
			 	warden data_mapper dm-sqlite-adapter ffi-yajl sqlite3 rb-inotify puma timers net-ldap &&\		
 	/home/engines/scripts/build/post_build_clean.sh
	
ADD home home
COPY src/etc/ /etc


ENV ContUser engines
ENV ContGrp ruby

#need to create as linking sqllite
RUN mkdir -p /home/app/db &&\
 	chown engines /home/app/db 	 &&\
	chown root /etc/sudoers.d/system &&\
	chmod og-rw /etc/sudoers.d/system &&\
	mv /home/engines/profile /home/engines/.profile &&\
    mkdir -p /home/engines/.ssh/system /home/app/tmp/ /home/app/public &&\	
	touch /home/.env_vars &&\
	chown 21000 /home/.env_vars &&\
 	chown -R 21000 /home/app/ /home/engines/scripts/configurators/saved &&\
 	usermod -G containers -a engines


ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/bin:/sbin/
ENV HOME /home/engines/
		
USER 21000

CMD ["/home/engines/scripts/system/start.sh" ]