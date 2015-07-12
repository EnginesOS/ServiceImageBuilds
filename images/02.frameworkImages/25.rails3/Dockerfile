FROM engines/ruby19:$release


RUN gem install rails --version 3.2.19;\
 	gem install mysql2;\
	apt-get -y install  libxslt-dev libxml2-dev;\
 	gem install nokogiri -- --use-system-libraries;\
 	usermod -G containers -a 
