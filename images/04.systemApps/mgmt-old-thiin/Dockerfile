FROM  engines/rails4
RUN apt-get -y install openssh-server
RUN /usr/sbin/addgroup --gid 999 docker
RUN echo "Y" | adduser -q --uid 21000 --gid 999 --home /home/dockuser --disabled-password dockuser

ADD home home
ADD profile /home/dockuser/.profile

ADD ssh /home/dockuser/.ssh

ENV ContUser dockuser
ENV ContGrp ruby

RUN chown -R dockuser /home/app/ ; usermod -G ruby -a dockuser


RUN cp -rp  ~/.gemrc ~/.bashrc ~dockuser

ADD mgmt.pub /home/dockuser/.ssh/authorized_keys
RUN chown -R dockuser /home/dockuser/
RUN chmod -R  700 /home/dockuser/.ssh
RUN mkdir -p /var/log/apache2/ /var/run/apache2
RUN chown -R dockuser /home/app/ /var/log/apache2/ /var/run/apache2
EXPOSE 80
EXPOSE 22

CMD /home/app/Procfile.sh
USER 21000
#GROUP 999