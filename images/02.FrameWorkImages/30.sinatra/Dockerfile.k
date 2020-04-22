
FROM  engines/ruby2.x:k

ADD src/Gems /tmp

ADD home home
RUN	 gem install bundler   -v 1.17.3 &&\
	gem  install bundle &&\
    for gem in `cat /tmp/Gems` ;\
     do \
      gem install $gem ;\
      done;\ 
 	usermod -G containers -a ruby &&\
 	/usr/sbin/usermod -u 22671 www-data &&\
    usermod -G containers -a www-data 
     
ENV ContUser www-data
ENV ContGrp www-data
 	
 
 	



