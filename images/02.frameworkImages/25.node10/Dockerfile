FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 10.46
RUN mkdir ~/node_js_src && cd $_;wget -N http://nodejs.org/dist/latest-v0.10.x/node-v0.10.46.tar.xz;tar xvf node-v0.10.46.tar.xz && cd node-v0.10.46;./configure; make ;make install;\
	groupadd node;\
 	echo "Y" | adduser --uid 22673 -q --ingroup node --home /home/node --disabled-password node;\
 	usermod -G containers -a node;\
 	npm -g install npm@latest;\
 	cd ~ ; rm -r ~/node_js_src  node-v0.10.46.tar.xz node-v0.10.46;\
 	chown node -R $HOME
