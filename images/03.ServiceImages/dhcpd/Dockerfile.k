FROM  engines/servicebase:k

RUN /home/engines/scripts/build/no_init.sh &&\	
	apt-get  update &&\
	apt-get -y install isc-dhcp-server &&\
 	/home/engines/scripts/build/post_build_clean.sh &&\
	/usr/sbin/usermod -u 22025 dhcpd
	
COPY sudoers /etc/sudoers.d/dhcpd
COPY home /home/

ENV ContUser dhcpd
ENV ContGrp dhcpd

RUN chown dhcpd /home/engines/scripts/configurators/saved/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/ &&\
	mkdir -p /var/lib/dhcp/ &&\
	touch /var/lib/dhcp/dhcpd.leases &&\
	rm /etc/dhcp/dhcpd.conf
	
USER dhcpd

CMD ["/home/engines/scripts/system/start.sh"]