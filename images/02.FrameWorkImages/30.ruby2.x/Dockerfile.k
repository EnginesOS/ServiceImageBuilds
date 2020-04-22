FROM engines/node_lts:k

ENV ruby_version 2.5.1
ENV ContUser ruby
ENV ContGrp ruby

ADD src/gemrc  /home/.gemrc
	
RUN	groupadd  -g 22672 ruby &&\
	useradd -u 22672  -g ruby -d /home/ruby -m -G containers ruby&&\
	apt-get -y update &&\
	apt-get install -y ruby-dev \
					   zlib1g \
					   zlib1g-dev &&\
   gem update --system &&\
   gem update &&\					 
   gem install bundler &&\  				   
   gem install bundle 
		
