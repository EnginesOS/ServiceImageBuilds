FROM engines/servicebase:$release

RUN   apt-get -y update;\
		apt-get install -y   libnss-mysql-bg libpam-mysql mysql-client rpcbind 
	
COPY etc /etc/

RUN 	chmod 600 /etc/nss-mysql-root.conf ;\
	adduser --uid 22018 -q --home /home/nfs --disabled-password nfs;\
	 apt-get install -y git-core cmake build-essential syslogd portmap bison flex libkrb5-dev libtirpc1;\
	cd /tmp;\
	git clone --depth 1 https://github.com/nfs-ganesha/nfs-ganesha.git;\
	cd nfs-ganesha;\
	 git checkout -b V2.2-stable origin/V2.2-stable;\
	 git submodule update --init	;\
	 mkdir build;\
	cd build;\
	cmake  -DUSE_FSAL_CEPH=OFF ../src;\
	 make;\
	 make install;\
	 cd /tmp/;\
	 rm -r /tmp/nfs-ganesha;\
	 mkdir -p /home/nfs/.ssh;\
	 chown nfs /home/nfs/.ssh ;\
	 usermod -G containers -a nfs
	 
COPY	 ganesha.conf   /usr/local/etc/ganesha.conf
COPY 	home /home
USER nfs
CMD ["/home/init.sh"]