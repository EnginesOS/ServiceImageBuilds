FROM  engines/servicebase:$release

RUN /home/engines/scripts/build/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install build-essential \
					   ruby-dev \
					   libssl-dev \
					   libreadline-dev \
					   zlib1g-dev &&\
	groupadd -g 22023 registry &&\
	useradd -u 22023 -g registry -d /home/registry -m -G containers registry &&\
 	/home/engines/scripts/build/post_build_clean.sh ;\
    echo 'gem: --no-document' >> ~/.gemrc &&\
    gem update &&\
    gem update --system &&\
	gem install bundle gctools rest-client sinatra thin yajl-ruby rubytree ffi-yajl sinatra-contrib sinatra-cross_origin

COPY home home	

RUN	mkdir -p /home/registry &&\
	cd /home/registry &&\
	mkdir -p /opt/engines/run/service_manager/ &&\	
	chown -R registry /opt/engines/run/service_manager/ /home/registry /var/log/
	
USER registry
	
RUN cd /home/registry &&\
	git clone https://github.com/EnginesOS/EnginesSystemRegistry &&\
	git config --global user.email "registry@engines.org" &&\
	git config --global user.name "Engines System Registry" &&\
	cd EnginesSystemRegistry &&\
	git checkout $release

ENV ContUser registry

CMD ["/home/engines/scripts/system/start.sh"]

