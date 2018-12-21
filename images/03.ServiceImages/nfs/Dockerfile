FROM engines/servicebase:$release

RUN  /home/engines/scripts/build/no_init.sh &&\	
	apt-get -y update &&\	
	apt-get install -y libnss-mysql-bg libpam-mysql mysql-client rpcbind 
	
COPY src/etc /etc/

RUN chmod 600 /etc/nss-mysql-root.conf &&\
	useradd -u 22018  -g nfs -d /home/nfs -m -G containers nfs&&\
	apt-get install -y git-core \
					   bison \
	                   cmake \
	                   build-essential \
	                   inetutils-syslogd \
	                   portmap \
	                   flex \
	                   libkrb5-dev \
	                   libtirpc1 &&\
	cd /tmp &&\
	git clone --depth 1 https://github.com/nfs-ganesha/nfs-ganesha.git &&\
	cd nfs-ganesha &&\
	git checkout -b V2.2-stable &&\
	git submodule update --init &&\
	mkdir build &&\
	cd build &&\
	cmake  -DUSE_FSAL_CEPH=OFF ../src &&\
	make &&\
	make install &&\
	cd /tmp/ &&\
	rm -r /tmp/nfs-ganesha &&\
	mkdir -p /home/nfs/.ssh &&\
	chown nfs /home/nfs/.ssh &&\
 	/home/engines/scripts/build/post_build_clean.sh
	 
COPY	src/ganesha.conf /usr/local/etc/ganesha.conf
COPY 	home /home

USER nfs

ENV ContUser nfs

CMD ["/home/engines/scripts/system/start.sh"]