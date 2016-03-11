FROM  engines/base:$release
COPY home /home

RUN mkdir /var/run/engines ; chgrp containers; chmod g+w /var/run/engines

#RUN apt-get -y  --fix-missing install  sudo vim  openssh-server 