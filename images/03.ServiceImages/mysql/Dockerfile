FROM  engines/servicebase:$release

RUN echo "Y" | adduser -q --disabled-password -uid 22006 mysql

RUN  /home/no_init.sh &&\		
	apt-get update -y &&\
	apt-get -y install mysql-server &&\
	echo max_allowed_packet = 4M >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo event-scheduler = 1 >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo 'sql_mode=""' >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	usermod -G containers -a mysql &&\
 	/home/post_build_clean.sh

	# cat /etc/mysql/my.cnf |grep -v  event-scheduler=DISABLED |sed "/127.0.0.1/s//0.0.0.0/" >/etc/mysql/my.cnf.sed;\
	#mv /etc/mysql/my.cnf.sed /etc/mysql/my.cnf;\

ADD home home

RUN chown mysql /home/firstrun.sh

EXPOSE 3306

ENV ContUser mysql
ENV ContGrp mysql

USER mysql
ENV ContUser mysql 
CMD ["/home/start.sh"]

