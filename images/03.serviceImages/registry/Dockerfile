FROM  engines/servicebase:$release

	

ENV ruby_version 2.3.0
ENV  RBENV_ROOT /usr/local/rbenv

RUN /home/no_init.sh ;\			
apt-get update -y;\
	apt-get -y install build-essential libssl-dev libreadline-dev zlib1g-dev ;\
	echo "Y" | adduser -q  --uid 22023 --home /home/registry --disabled-password registry;\
	usermod -G containers -a registry ;\
	mkdir -p /usr/local/ ; cd /usr/local/ ; git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv;\ 
	cd /usr/local/rbenv ; git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-buil;\
	cd /usr/local/rbenv   ;echo 'export PATH="/usr/local/rbenv/bin:$PATH:/usr/local/rbenv/shims/"' >> ~/.bashrc ; echo 'eval "$(rbenv init -)"' >> ~/.bashrc ; exec $SHELL ;/usr/local/rbenv/plugins/ruby-build/install.sh  ;/usr/local/rbenv/bin/rbenv install $ruby_version ; /usr/local/rbenv/bin/rbenv global $ruby_version;\
	/usr/local/rbenv/bin/rbenv rehash;\
 	/home/post_build_clean.sh
	
COPY home home	
RUN	/usr/local/rbenv/shims/gem install rest-client sinatra thin yajl-ruby rubytree
RUN	mkdir -p /home/registry;\
	cd /home/registry;\
	mkdir -p  /opt/engines/run/service_manager/;\	
	chown -R registry /opt/engines/run/service_manager/ /home/registry /var/log/
	
USER registry
	
RUN  cd /home/registry;\
	git clone https://github.com/EnginesOS/EnginesSystemRegistry ;\
	git  config  --global user.email "registry@engines.onl";\
	git  config  --global  user.name "Engines System Registry";\
	cd EnginesSystemRegistry ;\
	git checkout $release

ENV ContUser registry

CMD ["/home/start.sh"]