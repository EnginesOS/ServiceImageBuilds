FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 10.46
RUN mkdir ~/node_js_src && cd $_;wget -N http://nodejs.org/dist/latest-v0.10.x/node-v0.10.48.tar.xz;tar xvf node-v0.10.48.tar.xz && cd node-v0.10.48;./configure; make ;make install;\
	groupadd node;\
 	useradd -u 22673  -g node -d /home/node -m -G containers node&&\
 	npm -g install npm@latest;\
 	cd ~ ; rm -r ~/node_js_src  node-v0.10.48.tar.xz node-v0.10.48;\
 	chown node -R $HOME
