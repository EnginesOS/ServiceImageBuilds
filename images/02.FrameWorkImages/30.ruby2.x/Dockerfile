FROM engines/node:$release
ENV ruby_version 2.3.0
ENV ContUser ruby
ENV ContGrp ruby
ENV  RBENV_ROOT /usr/local/rbenv
ENV PATH $PATH:/usr/local/rbenv/shims/

ADD gemrc  /home/.gemrc

	
RUN	groupadd ruby;\
	echo "Y" | adduser -q --ingroup ruby --uid 22672 --home /home/ruby --disabled-password ruby;\
		usermod -G containers -a ruby;\
		mkdir -p ~www-data ;\
		chown www-data ~www-data ;\
		apt-get install ruby-dev gem ;\
		gem install bundle
		
#	mkdir -p /usr/local/ ; cd /usr/local/ ; git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv;\ 
#	cd /usr/local/rbenv ; git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-buil;\
#	cd /usr/local/rbenv   ;echo 'export PATH="/usr/local/rbenv/bin:$PATH:/usr/local/rbenv/shims/"' >> ~/.bashrc ; echo 'eval "$(rbenv init -)"' >> ~/.bashrc ; exec $SHELL ; /usr/local/rbenv/bin/rbenv install $ruby_version ; /usr/local/rbenv/bin/rbenv global $ruby_version;\
#	cp /home/.gemrc  ~/.gemrc;\
#	cp /home/.gemrc  ~www-data/.gemrc;\
#	cp /home/.gemrc  /home/home_dir/;\
#	/usr/local/rbenv/bin/rbenv rehash;\
#	cp -rp  ~/.gemrc ~/.bashrc /home/ruby/;\
#	 rm -r /home/home_dir/node_js_src;\
#	mkdir -p /home/home_dir/.bundle/;\
#	chgrp containers /home/home_dir/.bundle/;\
#	chmod g+w /home/home_dir/.bundle/
#	#chmod -R g+w /usr/local/rbenv/versions/ ;chgrp -R ruby /usr/local/rbenv/versions/;\