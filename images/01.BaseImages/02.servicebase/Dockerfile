FROM  engines/base:$release

COPY sudoers /etc/sudoers.d/service_base

RUN apt-get install -y -f libc-dev comerr-dev krb5-multidev libgssrpc4 libkadm5clnt-mit11 libkadm5srv-mit11 libkdb5-9 libkrb5-dev    &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
COPY home /home
