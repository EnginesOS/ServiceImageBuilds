FROM  engines/servicebase:$release

RUN echo "Y" | adduser -q --disabled-password -uid 22002 postgres

RUN apt-get update -y ;\
	 apt-get -y install postgresql postgresql-contrib libpq-dev;\
	apt-get clean
ADD home home
COPY pgpass /home/postgres/.pgpass

RUN kill -TERM `cat /var/run/postgresql/9.3-main.pid`;\
	mv /var/lib/postgresql /var/lib/postgresql_firstrun;\
 	chmod 600 /home/postgres/.pgpass ;\
 	 sed "/ssl-cert-snakeoil\.pem/s//engines\.crt/"  /etc/postgresql/9.3/main/postgresql.conf > /etc/postgresql/9.3/main/postgresql.conf.new ;\ 	 
 	 cp /etc/postgresql/9.3/main/postgresql.conf.new /etc/postgresql/9.3/main/postgresql.conf;\ 
 	 sed "/ssl-cert-snakeoil\.key/s//engines\.key/"  /etc/postgresql/9.3/main/postgresql.conf > /etc/postgresql/9.3/main/postgresql.conf.new ;\
 	 cp /etc/postgresql/9.3/main/postgresql.conf.new /etc/postgresql/9.3/main/postgresql.conf	;\
 	 echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf;\
 	 echo "host all all 172.17.42.0/16  md5" >> /etc/postgresql/9.3/main/pg_hba.conf;\
 	 chown postgres /home/firstrun.sh;\
 	 usermod -G containers -a postgres
 	
ENV ContUser postgres
ENV ContGrp  postgres

#CMD /home/init.sh
USER postgres

CMD [ "/home/start.sh" ]
#CMD /usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf
