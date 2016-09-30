
FROM  engines/ruby2.x:$release

ADD Gems.full /home/
RUN /usr/local/rbenv/shims/gem  install --no-rdoc --no-ri `cat /home/Gems.full`;\ 
	/usr/local/rbenv/shims/gem  install --no-rdoc --no-ri  bundle;\
  	/usr/local/rbenv/bin/rbenv rehash;\
 	usermod -G containers -a ruby
 	
 
 	



