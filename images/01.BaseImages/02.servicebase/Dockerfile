FROM  engines/base:$release
COPY home /home
RUN apt-get install -y  sendmail-bin;\ 
	echo "define(`SMART_HOST', `smtp.engines.internal')" >> /etc/mail/submit.mc ;\
	cd /etc/mail ;\
	make submit.cf

