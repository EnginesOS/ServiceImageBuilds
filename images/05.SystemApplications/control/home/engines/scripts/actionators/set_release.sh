#!/bin/sh


required_values="release"
check_required_values 

if test $release = `cat /home/app/release`
 then
  echo "Already release $release"
  exit 0
fi

echo -n $release > /home/app/release

if test -d /home/app
 then
  rm -rf /home/app/control
fi 

if ! test -d /home/app/control
 then
	git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui /home/app/control
 else
   cd /home/app/control
   git pull	
 fi	
cd /home/app/control
echo installing Gems
bundle install --standalone  
kill -TERM `cat /home/engines/run/control.pid`
 