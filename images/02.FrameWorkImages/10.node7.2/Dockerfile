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
 	adduser --uid 22673 -q --ingroup node --home /home/node --disabled-password node &&\
 	usermod -G containers -a node &&\
 	npm -g install npm@latest &&\
 	cd ~ ; rm -r ~/node_js_src
