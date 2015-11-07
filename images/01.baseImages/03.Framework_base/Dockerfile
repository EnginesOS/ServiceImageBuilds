FROM  engines/base:$release
ADD home /home
RUN apt-get -y update;\
	apt-get upgrade -y;\
	apt-get install -y  sendmail-bin ca-certificates mysql-client postgresql-client git-core imagemagick gawk sqlite3 bison  git-core sudo;\
	mkdir -p /home/fs;\
	echo "%containers ALL=(data-user) NOPASSWD: /home/engines/scripts/_revoke_rw_access.sh" >> /etc/sudoers.d/engines;\
	echo "%containers ALL=(data-user) NOPASSWD: /home/engines/scripts/_grant_rw_access.sh " >> /etc/sudoers.d/engines;\
	echo "%containers ALL=(ALL) NOPASSWD: /home/engines/scripts/_update_ca.sh " >> /etc/sudoers.d/engines;\
	echo "%containers ALL=(ALL) NOPASSWD: /home/engines/scripts/make_persistant.sh " >> /etc/sudoers.d/engines;\
	apt-get clean;\
	cat /etc/mail/sendmail.cf | sed "/^DS/s//DS=smtp.engines.internal/" > /tmp/sendmail.cf;\
	mv /tmp/sendmail.cf /etc/mail/sendmail.cf ;\
	adduser -q --disabled-password  -uid 11111 data-user
	
#FIXME above with sendmail.cf should really use m4 macros and not a sed kludge
	
ADD sources.list /etc/apt/