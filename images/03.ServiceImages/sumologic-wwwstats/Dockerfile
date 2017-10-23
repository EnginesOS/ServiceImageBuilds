FROM engines/sumologic:$release

ENV ContUser syslog
ENV collector_name www-logs

COPY src/sumo-sources.json /home/

USER syslog

CMD ["/home/start.sh"]