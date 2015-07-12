FROM engines/frameworkbuild:$release
ENV ruby_version 2.2.2
ENV ContUser ruby
ENV ContGrp ruby
ENV  RBENV_ROOT /usr/local/rbenv

RUN mkdir ~/node_js_src && cd $_;wget -N http://nodejs.org/dist/node-latest.tar.gz;tar xzvf node-latest.tar.gz && cd node-v*;./configure; make ;make install;\
	groupadd ruby;\
	echo "Y" | adduser -q --ingroup ruby --uid 22672 --home /home/ruby --disabled-password ruby;\
	mkdir -p /usr/local/ ; cd /usr/local/ ; git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv;\ 
	cd /usr/local/rbenv ; git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-buil;\
	cd /usr/local/rbenv   ;echo 'export PATH="/usr/local/rbenv/bin:$PATH:/usr/local/rbenv/shims/"' >> ~/.bashrc ; echo 'eval "$(rbenv init -)"' >> ~/.bashrc ; exec $SHELL ; /usr/local/rbenv/bin/rbenv install $ruby_version ; /usr/local/rbenv/bin/rbenv global $ruby_version;\
	echo "gem: --no-ri --no-rdoc" > ~/.gemrc;\
	/usr/local/rbenv/bin/rbenv rehash;\
	cp -rp  ~/.gemrc ~/.bashrc ~ruby;\
	chmod -R g+w /usr/local/rbenv/versions/ ;chgrp -R ruby /usr/local/rbenv/versions/