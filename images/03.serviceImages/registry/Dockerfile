FROM  engines/servicebase:$release

	

ENV ruby_version 2.2.2
ENV  RBENV_ROOT /usr/local/rbenv

RUN apt-get -y update;\
	echo "Y" | adduser -q --ingroup registry --uid 22672 --home /home/registry --disabled-password registry;\
	usermod -G containers -a registry ;\
	mkdir -p /usr/local/ ; cd /usr/local/ ; git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv;\ 
	cd /usr/local/rbenv ; git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-buil;\
	cd /usr/local/rbenv   ;echo 'export PATH="/usr/local/rbenv/bin:$PATH:/usr/local/rbenv/shims/"' >> ~/.bashrc ; echo 'eval "$(rbenv init -)"' >> ~/.bashrc ; exec $SHELL ; /usr/local/rbenv/bin/rbenv install $ruby_version ; /usr/local/rbenv/bin/rbenv global $ruby_version;\
	/usr/local/rbenv/bin/rbenv rehash;\
	apt-get -y clean ;\
	mkdir -p /home/registry;\
	cd /home/registry;\
	git clone https://github.com/EnginesOS/EnginesSystemRegistry





COPY home home
USER registry

CMD ["/home/start.sh"]