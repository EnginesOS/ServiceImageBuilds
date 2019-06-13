FROM  engines/servicebase:$release
ENV PGSQL_VERSION 10
RUN groupadd -g  22002 postgres &&\
	useradd -u 22002  -g postgres -d /home/postgres -m -G containers postgres &&\
	/home/engines/scripts/build/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install postgresql \
				       postgresql-contrib \
				       libpq-dev &&\
 	/home/engines/scripts/build/post_build_clean.sh
 	
ADD home home

RUN mv /var/lib/postgresql /var/lib/postgresql_firstrun &&\
 	sed "/ssl-cert-snakeoil\.pem/s//engines\.crt/"  /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf > /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf.new &&\ 	 
 	cp /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf.new /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf &&\ 
 	sed "/ssl-cert-snakeoil\.key/s//engines\.key/"  /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf > /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf.new &&\
 	cp /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf.new /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf &&\
 	echo "listen_addresses = '*'" >> /etc/postgresql/${PGSQL_VERSION}/main/postgresql.conf &&\
 	echo "host all all 172.17.0.0/16  md5" >> /etc/postgresql/${PGSQL_VERSION}/main/pg_hba.conf &&\
 	usermod -G containers -a postgres &&\
 	mkdir -p /var/run/postgresql/${PGSQL_VERSION}-main.pg_stat_tmp &&\
 	chown postgres -R /var/run/postgresql/
 	
ENV ContUser postgres
ENV ContGrp  postgres

USER postgres

CMD ["/home/engines/scripts/system/start.sh"]
