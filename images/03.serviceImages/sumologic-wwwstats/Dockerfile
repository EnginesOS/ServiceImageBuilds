FROM engines/sumologic:$release
ENV collector_name www-logs
COPY sumo-sources.json /home/
USER syslog
CMD ["/home/start.sh"]