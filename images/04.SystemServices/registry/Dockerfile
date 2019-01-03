FROM  engines/servicebase:$release

ENV  RBENV_ROOT /usr/local/rbenv

RUN /home/engines/scripts/build/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install build-essential \
					   ruby-dev \
					   libssl-dev \
					   libreadline-dev \
					   zlib1g-dev &&\
	useradd -u 22023  -g registry -d /home/registry-m -G containers registry &&\
 	/home/engines/scripts/build/post_build_clean.sh ;\
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