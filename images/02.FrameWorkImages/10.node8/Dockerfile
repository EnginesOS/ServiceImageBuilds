FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 8.9.4

RUN mkdir ~/node_js_src &&\
	cd $_ &&\
	wget http://nodejs.org/dist/latest-v8.x/node-v${NODE_VERSION}.tar.xz &&\
	tar xvf node-v${NODE_VERSION}.tar.xz &&\
	cd node-v* &&\
	./configure &&\
	make &&\
	make install &&\
	groupadd node &&\
 	adduser --uid 22673 -q --ingroup node --home /home/node --disabled-password node &&\
 	usermod -G containers -a node &&\
 	npm -g install npm@latest &&\
 	cd ~ &&\
 	rm -r ~/node_js_src
