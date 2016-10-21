FROM  engines/servicebase:$release


RUN 	/home/no_init.sh ;\	
	apt-get  update;\
	apt-get -y install isc-dhcp-server;\
 	/home/post_build_clean.sh;\
	/usr/sbin/usermod -u 22025 dhcpd
	
	
COPY sudoers /etc/	
ENV ContUser dhcpd
ENV ContGrp dhcpd

COPY home /home/
RUN chown dhcpd /home/configurators/saved/;\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/  ;\
	mkdir -p /var/lib/dhcp/ ;\
	touch /var/lib/dhcp/dhcpd.leases 
	
USER dhcpd
ENV ContUser dhcpd
CMD ["/home/start.sh"]