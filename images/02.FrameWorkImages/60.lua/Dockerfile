FROM engines/frameworkbuild:$release

ENV ContUser lua
ENV ContGrp lua

RUN adduser -q --uid 22676 --home /home/lua --disabled-password lua &&\
	apt-get update -y &&\
	apt-get install -y lua5.3 \
		               liblua5.3-dev \
		               libidn11-dev \
		               libssl-dev &&\
	apt-get clean &&\    
    usermod -G containers -a lua &&\
    cd /tmp &&\
    wget http://luarocks.org/releases/luarocks-2.4.4.tar.gz &&\
    tar zxpf luarocks-2.4.4.tar.gz &&\
	cd luarocks-2.4.4 &&\
	./configure &&\
 	make build  &&\
 	make install &&\
 	cd / &&\ 	
 	/home/engines/scripts/build/post_build_clean.sh
    
ADD home home
