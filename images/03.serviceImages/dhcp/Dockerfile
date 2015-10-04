FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /var/cache/dhcpd -uid 22025 dhcpd

RUN apt-get -y update;\
	apt-get -y install isc-dhcp-server
	apt-get clean;\

COPY sudoers /etc/	
ENV ContUser dhcpd
ENV ContGrp dhcpd
USER dhcpd

copy dhcpd.conf /etc/dhcpd/

CMD ["/home/start.sh"]