FROM  engines/servicebase:$release

ENV  RBENV_ROOT /usr/local/rbenv

RUN /home/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install build-essential \
					   ruby-dev \
					   libssl-dev \
					   libreadline-dev \
					   zlib1g-dev &&\
	adduser -q  --uid 22023 --home /home/registry --disabled-password registry &&\
	usermod -G containers -a registry &&\
 	/home/post_build_clean.sh ;\
	gem install bundle gctools rest-client sinatra thin yajl-ruby rubytree ffi-yajl

COPY home home	

RUN	mkdir -p /home/registry &&\
	cd /home/registry &&\
	mkdir -p  /opt/engines/run/service_manager/ &&\	
	chown -R registry /opt/engines/run/service_manager/ /home/registry /var/log/
	
USER registry
	
RUN cd /home/registry &&\
	git clone https://github.com/EnginesOS/EnginesSystemRegistry &&\
	git  config --global user.email "registry@engines.onl" &&\
	git  config --global  user.name "Engines System Registry" &&\
	cd EnginesSystemRegistry &&\
	git checkout $release

ENV ContUser registry

CMD ["/home/engines/scripts/system/start.sh"]