FROM engines/servicebase:$release

RUN groupadd -g 22007 volmgr&&\
	useradd -u 22007  -g volmgr -d /home/volmgr -m -G containers volmgr 
	
VOLUME /var/fs/

COPY  sudoers /etc/sudoers.d/volmgr
ADD  home /home

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser volmgr
ENV ContGrp volmgr

USER volmgr

CMD ["/home/engines/scripts/system/start.sh"]