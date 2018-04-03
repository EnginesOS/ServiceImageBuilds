FROM  engines/servicebase:$release

RUN adduser -q --disabled-password -uid 22006 mysql &&\
    /home/engines/scripts/build/no_init.sh &&\		
	apt-get update -y &&\
	apt-get -y install mysql-server &&\
	echo max_allowed_packet = 4M >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo event-scheduler = 1 >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo 'sql_mode=""' >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	usermod -G containers -a mysql &&\
	mkdir /var/run/mysqld &&\
	chown mysql /var/run/mysqld &&\
 	/home/engines/scripts/build/post_build_clean.sh


ADD home home
ADD sudoers /etc/sudoers.d/mysqld
RUN chmod og-rwx /etc/sudoers.d/mysqld
EXPOSE 3306

ENV ContUser mysql
ENV ContGrp mysql

USER mysql
ENV ContUser mysql 

CMD ["/home/engines/scripts/system/start.sh"]

