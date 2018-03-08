FROM  engines/base:$release

ADD sources.list /etc/apt/

COPY home /home
ADD sudoers /etc/sudoers.d/service_base

	
RUN apt-get update -y &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/ &&\
	apt-get install -y sendmail-bin &&\ 
	mv /home/no_tls /tmp/submit.head &&\
	cat /etc/mail/submit.mc >> /tmp/submit.head &&\
	cp /tmp/submit.head /etc/mail/submit.mc &&\
	cat /home/smarthost >> /etc/mail/submit.mc &&\
	rm /home/smarthost &&\
	echo "CLIENT_OPTIONS(\`Family=inet, M=S, Addr=0.0.0.0')dnl" >> /etc/mail/submit.mc&&\
	cd /etc/mail &&\
	make submit.cf

