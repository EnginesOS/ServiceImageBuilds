FROM  engines/base:$release
COPY home /home
RUN apt-get install -y  sendmail-bin;\ 
	cat /home/smarthost >> /etc/mail/submit.mc ;\
	cd /etc/mail ;\
	make submit.cf

