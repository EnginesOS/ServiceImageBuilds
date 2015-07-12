FROM engines/frameworkbuild:$release

ENV ContUser python
ENV ContGrp python

RUN echo "Y" | adduser -q --uid 22674 --home /home/python --disabled-password python;\
	apt-get update -y;\
	apt-get install -y wget python python-dev python-lxml;\
	apt-get clean ;\
    mkdir ~/node_js_src && cd $_;wget -N http://nodejs.org/dist/node-latest.tar.gz;tar xzvf node-latest.tar.gz && cd node-v*;./configure; make ;make install;\
    usermod -G containers -a  python
    
ADD home home
