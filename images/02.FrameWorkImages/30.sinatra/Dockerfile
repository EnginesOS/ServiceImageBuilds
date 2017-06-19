
FROM  engines/ruby2.x:$release

ADD Gems /home/

RUN	gem  install bundle &&\
 	usermod -G containers -a ruby &&\
 	usr/sbin/usermod -u 22671 www-data &&\
    usermod -G containers -a www-data 
     
ENV ContUser www-data
ENV ContGrp www-data
 	
 
 	



