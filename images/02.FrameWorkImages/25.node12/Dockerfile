FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 10.47
RUN mkdir ~/node_js_src && cd $_;wget -N http://nodejs.org/dist/latest-v0.12.x/node-v0.12.17.tar.xz;tar xvf node-v0.12.17.tar.xz && cd node-v0.12.17;./configure; make ;make install;\
	groupadd node;\
 	adduser --uid 22673 -q --ingroup node --home /home/node --disabled-password node;\
 	usermod -G containers -a node;\
 	npm -g install npm@latest;\
 	cd ~ ; rm -r ~/node_js_src  node-v0.12.17.tar.xz node-v0.12.17;\
 	chown node -R $HOME
