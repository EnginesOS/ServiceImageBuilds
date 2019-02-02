FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 6.16.0

RUN mkdir ~/node_js_src &&\
	cd ~/node_js_src &&\
	wget http://nodejs.org/dist/latest-v6.x/node-v${NODE_VERSION}.tar.xz &&\
	tar xvf node-v${NODE_VERSION}.tar.xz &&\
	cd node-v* &&\
	./configure &&\
	make &&\
	make install &&\
	groupadd node &&\
 	useradd -u 22673  -g node -d /home/node -m -G containers node&&\
 	npm -g install npm@latest &&\
 	cd ~ &&\
 	rm -r ~/node_js_src
