FROM  engines/servicebase:$release


RUN apt-get -y update;\
	apt-get upgrade -y;\
	/home/no_init.sh ;\		
	apt-get -y install isc-dhcp-server;\
 	/home/post_build_clean.sh;\
	/usr/sbin/usermod -u 22025 dhcpd
	
	
COPY sudoers /etc/	
ENV ContUser dhcpd
ENV ContGrp dhcpd

COPY home /home/
RUN chown dhcpd /home/configurators/saved
USER dhcpd
ENV ContUser dhcpd
CMD ["/home/start.sh"]