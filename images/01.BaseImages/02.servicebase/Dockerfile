FROM  engines/base:$release

ADD sources.list /etc/apt/

COPY home /home
ADD sudoers /etc/sudoers.d/ldap

	
RUN apt-get update -y &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/ &&\
	apt-get install -y sendmail-bin &&\ 
	cp /home/no_tls /tmp/submit.head &&\
	cat /etc/mail/submit.mc >> /tmp/submit.head &&\
	cp /tmp/submit.head /etc/mail/submit.mc &&\
	cat /tmp/submit.head /home/smarthost >> /etc/mail/submit.mc &&\
	echo "CLIENT_OPTIONS(\`Family=inet, M=S, Addr=0.0.0.0')dnl" >> /etc/mail/submit.mc&&\
	cd /etc/mail &&\
	make submit.cf

