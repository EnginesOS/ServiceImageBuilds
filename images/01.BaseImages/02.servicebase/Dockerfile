FROM  engines/base:$release
COPY home /home
RUN apt-get install -y  sendmail-bin;\ 
	cp no_tls  /tmp/submit.head;\
	cat /etc/mail/submit.mc >> /tmp/submit.head;\
	cp /tmp/submit.head etc/mail/submit.mc ;\
	cat  /tmp/submit.head /home/smarthost >> /etc/mail/submit.mc ;\
	cd /etc/mail ;\
	make submit.cf

