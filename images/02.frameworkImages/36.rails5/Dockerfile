FROM  engines/ruby2.x:$release
#FROM  engines/rails4:$release

ADD Gems /home/
RUN /usr/local/rbenv/shims/gem  install `cat /home/Gems`;\ 
	/usr/local/rbenv/shims/gem install bundle;\
  	/usr/local/rbenv/bin/rbenv rehash;\
 	usermod -G containers -a ruby
 	

 	#chmod -R g+w /usr/local/rbenv/versions/ ;\
 	#chgrp -R ruby /usr/local/rbenv/versions/;\


