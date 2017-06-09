FROM engines/node6:$release
ENV ruby_version 2.3.0
ENV ContUser ruby
ENV ContGrp ruby


ADD gemrc  /home/.gemrc

	
RUN	groupadd ruby;\
	echo "Y" | adduser -q --ingroup ruby --uid 22672 --home /home/ruby --disabled-password ruby;\
		usermod -G containers -a ruby;\
		mkdir -p ~www-data ;\
		apt-get -y update;\
		chown www-data ~www-data ;\
		apt-get install -y ruby-dev zlib1g zlib1g-dev gem ;\
		gem install bundle
		
