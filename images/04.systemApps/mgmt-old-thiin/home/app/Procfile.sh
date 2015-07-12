#!/bin/bash
PATH="/usr/local/rbenv/bin:$PATH" 

cd /home/app


/usr/local/rbenv/shims/gem install git bundle oink
/usr/local/rbenv/shims/gem install vmstat

git pull

#cat /home/app/config/environments/production.rb |sed "/config.serve_static_assets = false/s//config.serve_static_assets = true/" >/tmp/t
#cp /tmp/t /home/app/config/environments/production.rb


/usr/local/rbenv/shims/bundle install

/usr/local/rbenv/shims/bundle exec rake db:migrate 
# RAILS_ENV=production 
/usr/local/rbenv/shims/bundle exec rake db:populate 
# RAILS_ENV=production 
/usr/local/rbenv/shims/bundle exec rake assets:precompile 
# RAILS_ENV=production 
#/usr/local/rbenv/shims/bundle exec rake generate_secret_token 
# RAILS_ENV=production 
RAILS_ENV=development

touch  /engines/var/run/startup_complete
chown 21000 /engines/var/run/startup_complete
SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE RAILS_ENV
	if test -f /opt/engines/etc/ssl/keys/engines.key -a  -f /opt/engines/etc/ssl/certs/engines.crt 
	then
	 	/usr/local/rbenv/shims/bundle exec thin -p 8000   --ssl --ssl-key-file /opt/engines/etc/ssl/keys/engines.key --ssl-cert-file /opt/engines/etc/ssl/certs/engines.crt start
	else
	 	/usr/local/rbenv/shims/bundle exec thin -p 8000   start
	fi
	
rm /engines/var/run/startup_complete