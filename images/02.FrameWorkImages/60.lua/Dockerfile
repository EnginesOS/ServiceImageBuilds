FROM engines/frameworkbuild:$release

ADD home home
ENV ContUser lua
ENV ContGrp lua
ENV LUA_ROCKS_VERSION 3.3.1
ENV LUA_VERSION 5.3
RUN groupadd -g 22676 lua &&\
	useradd -u 22676  -g lua -d /home/lua -m -G containers lua&&\
	apt-get update -y &&\
	apt-get install -y  lua${LUA_VERSION} \
		               libtolua-dev \
		               libidn11-dev \
		               libssl-dev &&\
	apt-get clean &&\    
    usermod -G containers -a lua &&\
    cd /tmp &&\
    wget http://luarocks.org/releases/luarocks-${LUA_ROCKS_VERSION}.tar.gz &&\
    tar zxpf luarocks-${LUA_ROCKS_VERSION}.tar.gz &&\
	cd luarocks-${LUA_ROCKS_VERSION} &&\
	./configure &&\
 	make build  &&\
 	make install &&\
 	cd / &&\ 	
 	/home/engines/scripts/build/post_build_clean.sh
    
ADD home home
