FROM  engines/base:$release
ADD home /home
ADD engines_sudoers /etc/sudoers.d/engines
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED8E640A;\
	apt-get -y update;\
	apt-get upgrade -y;\
	apt-get install -y  sendmail-bin ca-certificates mysql-client postgresql-client git-core imagemagick gawk sqlite3 bison  sudo;\
	mkdir -p /home/fs;\
	apt-get clean
	
COPY submit.mc /etc/mail
COPY sendmail.mc /etc/mail

ENV HOME /home/home_dir


RUN	echo y y |sendmailconfig --no-reload;\
	adduser -q --disabled-password  -uid 11111 data-user;\
	chgrp containers /var/log/ ;\
	chmod g+w /var/log/;\
	mkdir -p /home/actionators/saved/;\
	chgrp containers  /home/actionators/saved/;\
	chmod g+w /home/actionators/saved/ ;\	
	mkdir $HOME ; chgrp containers $HOME; chmod g+w  $HOME

	
ADD sources.list /etc/apt/





