FROM engines/sumologic:$release

ENV ContUser syslog
ENV collector_name syslog

COPY sumo-sources.json /home/

USER syslog

CMD ["/home/start.sh"]