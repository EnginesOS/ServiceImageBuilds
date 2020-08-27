FROM  engines/base:$release

ADD sources.list /etc/apt/


COPY sudoers /etc/sudoers.d/service_base

RUN apt-get update -y &&\
    apt-get install -y libkrb5-dev  &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
COPY home /home
