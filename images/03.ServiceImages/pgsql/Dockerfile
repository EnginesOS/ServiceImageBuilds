FROM  engines/servicebase:$release

RUN adduser -q --disabled-password -uid 22002 postgres &&\
	/home/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install postgresql \
				       postgresql-contrib \
				       libpq-dev &&\
 	/home/post_build_clean.sh
 	
ADD home home

RUN mv /var/lib/postgresql /var/lib/postgresql_firstrun &&\
 	sed "/ssl-cert-snakeoil\.pem/s//engines\.crt/"  /etc/postgresql/9.5/main/postgresql.conf > /etc/postgresql/9.5/main/postgresql.conf.new &&\ 	 
 	cp /etc/postgresql/9.5/main/postgresql.conf.new /etc/postgresql/9.5/main/postgresql.conf &&\ 
 	sed "/ssl-cert-snakeoil\.key/s//engines\.key/"  /etc/postgresql/9.5/main/postgresql.conf > /etc/postgresql/9.5/main/postgresql.conf.new &&\
 	cp /etc/postgresql/9.5/main/postgresql.conf.new /etc/postgresql/9.5/main/postgresql.conf &&\
 	echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf &&\
 	echo "host all all 172.17.0.0/16  md5" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
 	chown postgres /home/firstrun.sh &&\
 	usermod -G containers -a postgres &&\
 	mkdir -p /var/run/postgresql/9.5-main.pg_stat_tmp &&\
 	chown postgres -R /var/run/postgresql/
 	
ENV ContUser postgres
ENV ContGrp  postgres

USER postgres

CMD [ "/home/start.sh" ]
