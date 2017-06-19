FROM  engines/ruby2.x:$release

ADD Gems /home/

RUN gem  install --no-ri `cat /home/Gems` &&\ 
	gem  install --no-ri bundle &&\
 	usermod -G containers -a ruby
 	
 
 	



