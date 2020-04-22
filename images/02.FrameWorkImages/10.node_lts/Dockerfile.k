FROM engines/frameworkbuild:k

ADD home home
ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 12.16.1
ENV ARCHIVE node-v12.16.1-linux-x64.tar.xz
#ENV ARCHIVE node-v12.16.1.tar.gz
ENV SRC_URL=https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-x64.tar.xz
#ENV SRC_URL=https://nodejs.org/dist/v12.16.1/node-v12.16.1.tar.gz


RUN mkdir /node_js_src &&\
	cd /node_js_src &&\
	wget -N ${SRC_URL}  &&\
	if [ -z $ARCHIVE ] ; then export ARCHIVE=node-v${NODE_VERSION}.tar.gz ;  fi &&\
	tar -xvf $ARCHIVE &&\
	rm $ARCHIVE &&\
	ls . &&\
	cd node-v* &&\
	ls . &&\
	cp -rp * /usr/local/&&\
	groupadd node ;\
 	useradd -g node -d /home/node -m -G containers node ;\
 	npm -g install npm@latest &&\
 	cd / ; rm -r /node_js_src
 	 
