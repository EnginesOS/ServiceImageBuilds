FROM  engines/frameworkbase:$release
ADD sources.list /etc/apt/ 
RUN apt-get install -y zlib1g zlib1g-dev python patch pkg-config libffi-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libmagickcore-dev libmagickwand-dev libpq-dev libmysqlclient-dev g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev autoconf libgdbm-dev libncurses5-dev automake libtool;\
	apt-get clean ;\
		rm -rf /tmp/*