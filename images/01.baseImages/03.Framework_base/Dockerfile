FROM  engines/base:$release
ADD home /home
ADD engines_sudoers /etc/sudoers.d/engines
RUN apt-get -y update;\
	apt-get upgrade -y;\
	apt-get install -y  sendmail-bin ca-certificates mysql-client postgresql-client git-core imagemagick gawk sqlite3 bison  git-core sudo;\
	mkdir -p /home/fs;\
	apt-get clean;\
	cat /etc/mail/submit.cf | sed "/^DS/s//DS=smtp.engines.internal/" > /tmp/submit.cf;\
	mv /tmp/submit.cf /etc/mail/submit.cf ;\
	cat /etc/mail/sendmail.cf | sed "/^DS/s//DS=smtp.engines.internal/" > /tmp/sendmail.cf;\
	mv /tmp/sendmail.cf /etc/mail/sendmail.cf ;\
	adduser -q --disabled-password  -uid 11111 data-user
	
#FIXME above with sendmail.cf should really use m4 macros and not a sed kludge
	
ADD sources.list /etc/apt/