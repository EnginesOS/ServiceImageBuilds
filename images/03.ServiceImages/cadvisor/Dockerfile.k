FROM  google/cadvisor:latest

COPY home home

USER 0

ENV ContUser 0
ENV ContGrp 0

CMD ["/home/engines/scripts/system/start.sh"]
