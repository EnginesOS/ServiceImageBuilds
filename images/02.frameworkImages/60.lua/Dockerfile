FROM engines/frameworkbuild:$release

ENV ContUser python
ENV ContGrp python

RUN echo "Y" | adduser -q --uid 22676 --home /home/lua --disabled-password lua;\
	apt-get update -y;\
	apt-get upgrade -y;\
	apt-get install -y wget lua5.1 liblua5.1-dev libidn11-dev libssl-dev ;\
	apt-get clean ;\    
    usermod -G containers -a  lua ;\
    cd /tmp;\
    wget http://luarocks.org/releases/luarocks-2.3.0.tar.gz;\
    tar zxpf luarocks-2.3.0.tar.gz;\
	cd luarocks-2.3.0;\
	./configure;\
 	make build ;\
 	make install;\
 	cd /;\ 	
 	/home/post_build_clean.sh
    
ADD home home
