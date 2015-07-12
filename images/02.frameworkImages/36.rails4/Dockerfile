FROM  engines/ruby2.x:$release

ADD Gems /home/
RUN /usr/local/rbenv/shims/gem  install `cat /home/Gems`;\ 
	/usr/local/rbenv/shims/gem install bundle;\
  	/usr/local/rbenv/bin/rbenv rehash;\
 	chmod -R g+w /usr/local/rbenv/versions/ ;\
 	chgrp -R ruby /usr/local/rbenv/versions/;\
 	usermod -G containers -a ruby



