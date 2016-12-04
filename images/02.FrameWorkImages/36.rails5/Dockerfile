FROM  engines/ruby2.x:$release


ADD Gems /home/
RUN /usr/local/rbenv/shims/gem  install  bundle `cat /home/Gems`
#RUN /usr/local/rbenv/shims/gem  install --no-rdoc --no-ri `cat /home/Gems`;\ 
#	/usr/local/rbenv/shims/gem --no-rdoc --no-ri install bundle;\
#  	/usr/local/rbenv/bin/rbenv rehash;\
# 	usermod -G containers -a ruby
# 	


