FROM engines/servicebase:$release
RUN adduser -q --disabled-password --home /home/volmgr -uid 22007 volmgr;\
	usermod -G containers -a volmgr
	
VOLUME /var/fs/

ENV ContUser volmgr
ENV ContGrp volmgr
USER volmgr
COPY 	home/ /home
CMD ["/home/start.sh"]