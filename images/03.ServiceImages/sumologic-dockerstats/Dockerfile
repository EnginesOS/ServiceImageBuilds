FROM engines/sumologic:$release
env collector_name dockerstats 
COPY sumo-sources.json /home/
USER syslog
ENV ContUser syslog
CMD ["/home/start.sh"]