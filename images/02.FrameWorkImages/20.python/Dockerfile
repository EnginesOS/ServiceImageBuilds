FROM engines/node10:$release

#engines/frameworkbuild:$release

ADD home home
ENV ContUser python
ENV ContGrp python
ENV python_version 3.6
RUN groupadd -g 22674 python &&\
	useradd -u 22674  -g python -d /home/python -m -G containers python&&\
	apt-get update -y &&\
	apt-get install -y python \
					   python-dev \
					   python3.6 \
					   python3-setuptools \
					   python3-pip \
					   apache2 \
					   libapache2-mod-wsgi &&\
    cd /tmp &&\
	chown python.python -R /usr/local/lib/python*/dist-packages/ &&\
	usermod -G python -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh&&\
 	chgrp -R python /usr/local &&\
 	chmod -R g+w /usr/local
 	
ADD home home
