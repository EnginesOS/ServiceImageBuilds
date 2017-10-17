FROM  engines/servicebase:$release

RUN adduser -q --disabled-password -uid 22006 mysql &&\
    /home/no_init.sh &&\		
	apt-get update -y &&\
	apt-get -y install mysql-server &&\
	echo max_allowed_packet = 4M >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo event-scheduler = 1 >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo 'sql_mode=""' >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	usermod -G containers -a mysql &&\
 	/home/post_build_clean.sh


ADD home home

EXPOSE 3306

ENV ContUser mysql
ENV ContGrp mysql

USER mysql
ENV ContUser mysql 
CMD ["/home/start.sh"]

