FROM  engines/base:$release

ADD home /home
ADD engines_sudoers /etc/sudoers.d/engines
ADD sources.list /etc/apt/

RUN apt-get update -y &&\
	apt-get install -y sendmail-bin \
	 				   ca-certificates \
	 				   mysql-client \
	 				   postgresql-client \
	 				   git-core \
	 				   imagemagick \
	 				   gawk \
	 				   sqlite3 \
	 				   bison \
	 				   sudo &&\
	mkdir -p /home/fs &\\
	usermod -d /home/home_dir www-data
	
COPY submit.mc /etc/mail
COPY sendmail.mc /etc/mail

ENV HOME /home/home_dir

RUN	echo y y |sendmailconfig --no-reload &&\
	useradd -u 11111 data-user &&\
	chgrp containers /var/log/ &&\
	chmod g+w /var/log/ &&\
	mkdir -p /home/engines/scripts/actionators/saved/ &&\
	chgrp containers  /home/engines/scripts/actionators/saved/ &&\
	chmod g+w /home/engines/scripts/actionators/saved/ &&\	
	mkdir $HOME &&\
	chgrp containers $HOME &&\
	chmod g+w $HOME &&\
	chmod g+w /var/spool/mqueue &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/ &&\
	rm -rf /tmp/*



