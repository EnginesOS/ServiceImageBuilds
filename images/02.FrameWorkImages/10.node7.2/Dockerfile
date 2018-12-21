FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 7.10.0

RUN mkdir ~/node_js_src &&\
	cd ~/node_js_src &&\
	wget -N http://nodejs.org/dist/node-latest.tar.gz  &&\
	tar xzvf node-latest.tar.gz &&\
	cd node-v* &&\
	./configure &&\
	make &&\
	make install &&\
	groupadd node &&\
 	useradd -u 22673  -g node -d /home/node -m -G containers node &&\
 	npm -g install npm@latest &&\
 	cd ~ ; rm -r ~/node_js_src
