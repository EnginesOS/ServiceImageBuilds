FROM engines/sumologic:k

ENV collector_name dockerstats
ENV ContUser syslog
 
COPY src/sumo-sources.json /home/

USER syslog

CMD ["/home/engines/scripts/system/start.sh"]