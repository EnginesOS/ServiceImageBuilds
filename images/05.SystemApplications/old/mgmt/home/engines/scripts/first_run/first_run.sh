#!/bin/sh

mkdir -p /home/fs/persistent/db/

if ! test -f /home/fs/persistent/db/database.sqllite
  then
	touch /home/fs/persistent/db/database.sqllite
fi

if ! test -d /var/log/app
  then
	mkdir /var/log/app
fi

rm -rf /home/engines/var/log/ 

if ! test -f /home/fs/persistent/.setup	
	then
		cp -rp /home/app/public/system /home/fs/persistent/
		rm -r /home/app/public/system
		ln -s /home/fs/persistent/system /home/app/public/system
		touch /home/fs/persistent/.setup	
	fi
if ! test -h /home/app/public/system
 then
 	rm -r /home/app/public/system
	ln -s /home/fs/persistent/system /home/app/public/system
 fi
 

ln -s /var/log/app /home/engines/var/log/ 
bundle exec rake db:migrate 
bundle exec rake db:seed >/dev/null