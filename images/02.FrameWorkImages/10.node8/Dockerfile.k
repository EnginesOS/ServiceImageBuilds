FROM engines/frameworkbuild:k

ADD home home
ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION v8.16.0
ENV SRC_URL=http://nodejs.org/dist/latest-v8.x/node-${NODE_VERSION}.tar.xz

#RUN mkdir node_js_src &&\
#	cd  node_js_src &&\
#	wget http://nodejs.org/dist/latest-v8.x/node-${NODE_VERSION}.tar.xz &&\
#	tar xvf node-v${NODE_VERSION}.tar.xz &&\
#	cd node-v* &&\
#	./configure &&\
#	make &&\
#	make install &&\
#	groupadd node &&\
# 	useradd -u 22673  -g node -d /home/node -m -G containers node &&\
# 	npm -g install npm@latest &&\
# 	cd ~ &&\
# 	rm -r ~/node_js_src
#
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
 	 