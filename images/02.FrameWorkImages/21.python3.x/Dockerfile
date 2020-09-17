FROM engines/node10:$release

#engines/frameworkbuild:$release

ADD home home
ENV ContUser python
ENV ContGrp python
ENV python_version 3.8
RUN groupadd -g 22674 python &&\
	useradd -u 22674  -g python -d /home/python -m -G containers python&&\
	apt-get update -y &&\
	apt-get install -y python \
					   python-dev \
					   python${python_version}-dev \
					   python${python_version} \
					   python3-pip  &&\
    cd /tmp &&\
	 python${python_version} -m pip install pip --upgrade &&\
	 python${python_version} -m pip install setuptools --upgrade &&\
	 python${python_version} -m pip install virtualenv --upgrade &&\
	chown python.python -R /usr/local/lib/python*/dist-packages/ &&\
	usermod -G python -a www-data &&\
 	/home/engines/scripts/build/post_build_clean.sh&&\
 	chgrp -R python /usr/local &&\
 	chmod -R g+w /usr/local
 	
ADD home home
