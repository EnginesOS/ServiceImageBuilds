FROM  engines/ruby2.x:$release

ADD src/Gems /home/

RUN  gem uninstall bundler -v  2.0.1&&\
	gem install bundler   -v 1.17.3 &&\
	gem install bundle `cat /home/Gems`


