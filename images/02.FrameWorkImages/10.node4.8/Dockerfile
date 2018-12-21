FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 4.8.7

RUN apt-get -y install python &&\
    mkdir ~/node_js_src &&\
    cd ~/node_js_src &&\
    wget https://nodejs.org/dist/latest-v4.x/node-v${NODE_VERSION}.tar.gz &&\
    tar xzvf node-v${NODE_VERSION}.tar.gz &&\
    cd node-v* &&\
    ./configure &&\
    make &&\
    make install &&\
	groupadd node &&\
 	useradd -u 22673  -g node -d /home/node -m -G containers node &&\
 	npm -g install npm@latest &&\
 	ln -s /usr/local/bin/node /usr/local/bin/js &&\
 	cd ~ ; rm -r ~/node_js_src
