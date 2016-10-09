
FROM  engines/ruby2.x:$release

ADD Gems /home/
RUN	/usr/local/rbenv/shims/gem  install --no-rdoc --no-ri  bundle;\
  	/usr/local/rbenv/bin/rbenv rehash;\
 	usermod -G containers -a ruby;\
 	usr/sbin/usermod -u 22671 www-data ;\
     usermod -G containers -a www-data 
     
ENV ContUser www-data
ENV ContGrp www-data
 	
 
 	



