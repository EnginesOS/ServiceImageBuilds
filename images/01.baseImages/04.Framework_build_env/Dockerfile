FROM  engines/frameworkbase:$release
RUN apt-get -y  --force-yes update;\
	apt-get install -y patch zlib1g-dev pkg-config libffi-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libmagickcore-dev libmagickwand-dev libpq-dev libmysqlclient-dev g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev autoconf libgdbm-dev libncurses5-dev automake libtool;\
	apt-get clean
ADD sources.list /etc/apt/ 