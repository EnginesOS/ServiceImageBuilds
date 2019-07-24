FROM  engines/base:$release

ADD home /home
#ADD engines_sudoers /etc/sudoers.d/engines
ADD src/etc /etc
ENV HOME /home/home_dir

RUN apt-get update -y &&\
	apt-get install -y mysql-client \
	 				   postgresql-client \
	 				   git-core \
	 				   imagemagick \
	 				   gawk \
	 				   sqlite3 \
	 				   bison \
	 				   libnss-ldap \
	 				   libpam-ldap \
	 				   ldap-utils \
	 				   sudo &&\
	mkdir -p /home/fs &&\ 
	useradd -u 11111 data-user &&\
	chgrp containers /var/log/ &&\
	chmod g+w /var/log/ &&\
	mkdir -p /home/engines/scripts/actionators/saved/ &&\
	chgrp containers  /home/engines/scripts/actionators/saved/ &&\
	chmod g+w /home/engines/scripts/actionators/saved/ &&\	
	mkdir $HOME &&\
	chgrp containers $HOME &&\
	chmod g+w $HOME &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/ &&\
	rm -rf /tmp/* &&\
	mkdir /home/users &&\
	ln -s /home/users/ /home/fs/users &&\
	echo "session optional pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session



