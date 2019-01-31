FROM engines/node6:$release

ENV ruby_version 2.5.1
ENV ContUser ruby
ENV ContGrp ruby

ADD src/gemrc  /home/.gemrc
	
RUN	groupadd  -g 22672 ruby &&\
	useradd -u 22672  -g ruby -d /home/ruby -m -G containers ruby&&\
	mkdir -p ~www-data &&\
	apt-get -y update &&\
	chown www-data ~www-data &&\
	apt-get install -y ruby-dev \
					   zlib1g \
					   zlib1g-dev \
					   gem &&\
	gem install bundle
		
