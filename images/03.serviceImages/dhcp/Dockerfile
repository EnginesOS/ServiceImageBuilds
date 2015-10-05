FROM  engines/servicebase:$release


RUN apt-get -y update;\
	apt-get -y install isc-dhcp-server
	apt-get clean;\
	/usr/sbin/usermod -u 22025 dhcpd
	
COPY sudoers /etc/	
ENV ContUser dhcpd
ENV ContGrp dhcpd

USER dhcpd

copy dhcpd.conf /home/

CMD ["/home/start.sh"]