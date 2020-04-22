FROM  engines/ruby2.x:k

ADD src/Gems /home/

RUN  gem install bundle `cat /home/Gems`


