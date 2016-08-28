FROM engines/frameworkbuild:$release

ENV ContUser python
ENV ContGrp python

RUN echo "Y" | adduser -q --uid 22674 --home /home/python --disabled-password python;\
	apt-get install -y wget python python-dev python-lxml;\
    mkdir ~/node_js_src && cd $_;wget -N http://nodejs.org/dist/node-latest.tar.gz;tar xzvf node-latest.tar.gz && cd node-v*;./configure; make ;make install;\
    usermod -G containers -a  python ;\
    cd /tmp;\
    wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py ;\ 
	python get-pip.py;\
	chown python.python -R	/usr/local/lib/python2.7/dist-packages/;\
	usermod -G python -a www-data;\
	ln -s /usr/include/freetype2 /usr/include/freetype2/freetype;\
 	/home/post_build_clean.sh
ADD home home
