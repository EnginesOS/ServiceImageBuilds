FROM  engines/ruby2.x:$release

ADD src/Gems /home/

RUN gem  install  `cat /home/Gems` &&\ 
	gem  install  bundle &&\
 	usermod -G containers -a ruby
 	
 
 	



