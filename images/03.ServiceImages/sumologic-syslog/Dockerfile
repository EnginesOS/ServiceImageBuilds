FROM engines/sumologic:$release

ENV ContUser syslog
ENV collector_name syslog

COPY src/sumo-sources.json /home/

USER syslog

CMD ["/home/engines/scripts/startup/start.sh"]