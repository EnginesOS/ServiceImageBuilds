FROM busybox
RUN echo "Y" | adduser  -D -h /home/volmgr -u 22007 volmgr

VOLUME /fs/

ENV ContUser volmgr
ENV ContGrp volmgr

ADD home/start.sh /home/start.sh

CMD ["/home/start.sh"]