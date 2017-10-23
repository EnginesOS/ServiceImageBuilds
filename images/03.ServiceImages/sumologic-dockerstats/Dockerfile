FROM engines/sumologic:$release

ENV collector_name dockerstats
ENV ContUser syslog
 
COPY src/sumo-sources.json /home/

USER syslog

CMD ["/home/start.sh"]