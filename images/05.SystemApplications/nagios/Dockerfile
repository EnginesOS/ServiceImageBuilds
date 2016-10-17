FROM  engines/base:$release

RUN apt-get update;\
   apt-get -y install nagios3;\
    echo "Y" | adduser -q --home /home/rma --disabled-password rma;\
	apt-get clean
	
ADD sudoers /etc/
RUN chown 0 /etc/sudoers
ADD apache2.nagios3.conf /etc/apache2/conf.d/nagios3.conf
ADD apache2.conf /etc/apache2/
ADD nagios.cfg /etc/nagios3/

ADD nagios.pub /home/rma/.ssh/authorized_keys
RUN chown rma -R /home/rma/.ssh

ADD mysql.cfg	/etc/nagios3/conf.d/
ADD nginx.cfg	/etc/nagios3/conf.d/
ADD groups.cfg	/etc/nagios3/conf.d/


#FIXME Much better method id probaly to copy a htpasswd file across need to set a better passwd
RUN htpasswd -c -b  /etc/nagios3/htpasswd.users nagiosadmin admin

ADD home home


EXPOSE 80
EXPOSE 22

ENV ContUser www-data
ENV ContGrp www-data