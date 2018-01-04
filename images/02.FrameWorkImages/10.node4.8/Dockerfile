FROM engines/frameworkbuild:$release

ENV ContUser node
ENV ContGrp node
ENV NODE_VERSION 4.8.7

RUN apt-get -y install python &&\
    mkdir ~/node_js_src &&\
    cd $_ &&\
    wget https://nodejs.org/dist/latest-v4.x/node-v${NODE_VERSION}.tar.gz &&\
    tar xzvf node-v${NODE_VERSION}.tar.gz &&\
    cd node-v* &&\
    ./configure &&\
    make &&\
    make install &&\
	groupadd node &&\
 	adduser --uid 22673 -q --ingroup node --home /home/node --disabled-password node &&\
 	usermod -G containers -a node &&\
 	npm -g install npm@latest &&\
 	ln -s /usr/local/bin/node /usr/local/bin/js &&\
 	cd ~ ; rm -r ~/node_js_src
