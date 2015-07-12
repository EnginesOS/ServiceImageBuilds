FROM busybox
RUN echo "Y" | adduser  -D -h /home/volmgr -u 22007 volmgr

VOLUME /fs/

ENV ContUser volmgr
ENV ContGrp volmgr

ADD home/init.sh /home/init.sh

CMD ["/home/init.sh"]