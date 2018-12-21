FROM engines/node6:$release

#engines/frameworkbuild:$release

ENV ContUser python
ENV ContGrp python

RUN groupadd -g 22674 python &&\
	useradd -u 22674  -g python -d /home/python -m -G containers python&&\
	apt-get update -y &&\
	apt-get install -y python \
					   python-dev &&\
					   python3-pip &&\
					   python-lxml &&\
    cd /tmp &&\
	pip3 install --upgrade pip
	chown python.python -R /usr/local/lib/python*/dist-packages/ &&\
	usermod -G python -a www-data &&\
	ln -s /usr/include/freetype2 /usr/include/freetype2/freetype &&\
 	/home/engines/scripts/build/post_build_clean.sh
 	
ADD home home
