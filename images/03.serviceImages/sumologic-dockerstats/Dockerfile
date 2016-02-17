FROM engines/sumologic:$release
env collector_name dockerstats 
COPY sumo-sources.json /home/
USER syslog
CMD ["/home/start.sh"]