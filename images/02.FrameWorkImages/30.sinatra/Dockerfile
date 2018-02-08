
FROM  engines/ruby2.x:$release

ADD src/Gems /tmp

RUN	gem  install bundle &&\
    for gem in `cat /tmp/Gems` ;\
     do \
      gem install $gem &&\
      done;\ 
 	usermod -G containers -a ruby &&\
 	usr/sbin/usermod -u 22671 www-data &&\
    usermod -G containers -a www-data 
     
ENV ContUser www-data
ENV ContGrp www-data
 	
 
 	



