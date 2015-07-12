FROM  engines/base:$release
ADD engines /home/engines
RUN apt-get -y update;\
	apt-get install -y  mysql-client postgresql-client git-core imagemagick gawk sqlite3 bison  git-core sudo;\
	mkdir -p /home/fs;\
	echo "www-data ALL=(data-user) NOPASSWD: /home/engines/scripts/_revoke_rw_access.sh" >> /etc/sudoers;\
	echo "www-data ALL=(data-user) NOPASSWD: /home/engines/scripts/_grant_rw_access.sh " >> /etc/sudoers;\
	apt-get clean;\
	adduser -q --disabled-password  -uid 11111 data-user
	
ADD sources.list /etc/apt/