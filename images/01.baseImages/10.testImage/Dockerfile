FROM engines/base:$release
ADD home home
RUN mkdir -p  /var/run/sshd
CMD /usr/sbin/sshd -D
#CMD /bin/bash /home/init.sh
#CMD /bin/bash /home/tests.sh
