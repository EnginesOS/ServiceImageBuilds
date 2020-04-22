FROM engines/frameworkbuild:k

ADD home home
ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION v10.15.3
ENV SRC_URL=https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz

#RUN mkdir ~/node_js_src &&\
#	cd ~/node_js_src &&\
#	wget -N https://nodejs.org/dist/v${NODE_VERSION}/node-v$NODE_VERSION.tar.gz  &&\
#	tar node-v${NODE_VERSION}-linux-x64.tar.gz &&\
#	cd node-v* &&\
#	./configure &&\
#	make &&\
#	make install &&\
#	groupadd node &&\
# 	useradd -u 22673  -g node -d /home/node -m -G containers node &&\
# 	npm -g install npm@latest &&\
# 	cd .. ; rm -r ~/node_js_src 

RUN mkdir /node_js_src &&\
	cd /node_js_src &&\
	wget -N ${SRC_URL}  &&\
	if [ -z $ARCHIVE ] ; then export ARCHIVE=node-v${NODE_VERSION}-linux-x64.tar.gz ;  fi &&\
	tar -xvf $ARCHIVE &&\
	rm $ARCHIVE &&\
	cd node-* &&\
	./configure &&\
	make &&\
	make install &&\
	groupadd node ;\
 	useradd -g node -d /home/node -m -G containers node ;\
 	npm -g install npm@latest &&\
 	cd / ; rm -r /node_js_src
 	 