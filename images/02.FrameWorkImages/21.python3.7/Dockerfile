FROM engines/node10:$release

#engines/frameworkbuild:$release

ADD home home
ENV ContUser python
ENV ContGrp python
ENV python_version 3.7
RUN groupadd -g 22674 python &&\
	useradd -u 22674  -g python -d /home/python -m -G containers python&&\
	apt-get update -y &&\
	apt-get install -y python \
					   python-dev \
					   python3.7 \
					   python3-pip  &&\
    cd /tmp &&\
	 python3.7 -m pip install pip --upgrade &&\
	 python3.7 -m pip install setuptools --upgrade &&\
	 python3.7 -m pip install virtualenv --upgrade &&\
	chown python.python -R /usr/local/lib/python*/dist-packages/ &&\
	usermod -G python -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh&&\
 	chgrp -R python /usr/local &&\
 	chmod -R g+w /usr/local
 	
ADD home home
