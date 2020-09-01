FROM  engines/servicebase:$release

RUN groupadd -g 22006 mysql &&\
	useradd -u 22006  -g mysql -d /home/mysql -m -G containers mysql &&\
    /home/engines/scripts/build/no_init.sh &&\		
	apt-get update -y &&\
	apt-get -y install mysql-server &&\
	echo max_allowed_packet = 4M >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo event-scheduler = 1 >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	echo 'sql_mode=""' >> /etc/mysql/mysql.conf.d/mysqld.cnf &&\
	mkdir /var/run/mysqld &&\
	chown mysql /var/run/mysqld &&\
 	/home/engines/scripts/build/post_build_clean.sh


ADD home home
ADD sudoers /etc/sudoers.d/mysqld
RUN chmod og-rwx /etc/sudoers.d/mysqld &&\
    chgrp -R containers /home/engines/scripts
EXPOSE 3306

ENV ContUser mysql
ENV ContGrp mysql

USER mysql
ENV ContUser mysql 

CMD ["/home/engines/scripts/system/start.sh"]

