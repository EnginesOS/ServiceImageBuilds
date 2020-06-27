FROM  engines/servicebase:k

RUN usermod www-data -u 22005 &&\
	/home/engines/scripts/build/no_init.sh &&\			
	apt-get update -y &&\
	apt-get -y install build-essential \
	                  gcc \
	                  make \
	                  python-pip \
	                  libsasl2-dev \
	                  python-dev \
	                  libldap2-dev  &&\
	pip install wheel &&\
	pip install python-ldap &&\
	usermod -G containers -a www-data &&\
	mkdir /home/app &&\
	cd /tmp &&\
	git clone https://github.com/nginxinc/nginx-ldap-auth &&\
	cp /tmp/nginx-ldap-auth/nginx-ldap-auth-daemon.py /home/app/ &&\
 	/home/engines/scripts/build/post_build_clean.sh

COPY home home

ENV ContUser www-data
ENV ContGrp www-data

USER 22005

CMD ["/home/engines/scripts/system/start.sh"]