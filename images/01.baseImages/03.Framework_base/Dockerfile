FROM  engines/base:$release
ADD home /home
RUN apt-get -y update;\
	apt-get upgrade -y;\
	apt-get install -y ca-certificates mysql-client postgresql-client git-core imagemagick gawk sqlite3 bison  git-core sudo;\
	mkdir -p /home/fs;\
	echo "%containers ALL=(data-user) NOPASSWD: /home/engines/scripts/_revoke_rw_access.sh" >> /etc/sudoers.d/engines;\
	echo "%containers ALL=(data-user) NOPASSWD: /home/engines/scripts/_grant_rw_access.sh " >> /etc/sudoers.d/engines;\
	echo "%containers ALL=(ALL) NOPASSWD: /home/engines/scripts/_update_ca.sh " >> /etc/sudoers.d/engines;\
	echo "%containers ALL=(ALL) NOPASSWD: /home/engines/scripts/make_persistant.sh " >> /etc/sudoers.d/engines;\
	apt-get clean;\
	adduser -q --disabled-password  -uid 11111 data-user
	
ADD sources.list /etc/apt/