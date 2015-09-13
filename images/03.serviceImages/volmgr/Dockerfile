FROM engines/servicebase:$release
RUN echo "Y" | adduser  -D -h /home/volmgr -u 22007 volmgr;\
	usermod -G containers -a volmgr
	
VOLUME /var/fs/

ENV ContUser volmgr
ENV ContGrp volmgr
USER volmgr
COPY 	home/ /home
CMD ["/home/start.sh"]