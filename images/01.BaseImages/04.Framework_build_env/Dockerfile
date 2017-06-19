FROM  engines/frameworkbase:$release
ADD sources.list /etc/apt/ 
RUN apt-get update -y &&\
	apt-get install -y zlib1g zlib1g-dev python patch pkg-config libffi-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libpq-dev libmysqlclient-dev g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev autoconf libgdbm-dev libncurses5-dev automake libtool &&\
	apt-get install -y libmagickcore-dev libmagickwand-dev &&\
	rm -rf /tmp/*