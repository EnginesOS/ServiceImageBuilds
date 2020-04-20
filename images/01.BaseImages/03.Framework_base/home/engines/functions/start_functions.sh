wait_for_debug()
{
if ! test -z "$Engines_Debug_Run"
 then
  if test "$Engines_Debug_Run" = true
   then  
     echo "Stopped by Sleeping for 500 seconds to allow debuging"
     sleep 500 &
     echo -n " $!" >> $PID_FILE
     wait
   fi
fi  	 
 }
 
blocking()
{
if test -f /home/engines/scripts/run/blocking.sh 
  then
	 /home/engines/scripts/run/blocking.sh  &
	 echo -n " $!" >>  $PID_FILE
fi
}

volume_setup()
{	 
if test  ! -f /home/engines/run/flags/volume_setup_complete
 then
   echo "Waiting for Volume setup to Complete"
 	while test ! -f /home/engines/run/flags/volume_setup_complete
 	  do
 	  echo  "."
 		sleep 4
 	 done
 echo "Volume setup to Complete "
fi
}

dynamic_persistence()
{	  
if test -f "$VOLDIR/.dynamic_persistence"
  then
	if ! test -f /home/app/.dynamic_persistence_restored
	  then
 		/home/engines/scripts/restore_dynamic_persistence.sh
 		echo "Dynamic persistence restore Complete"
 	fi
 fi
}


first_run()
{

if ! test -f /home/engines/run/flags/first_run_done
 then  
  if test -f /home/engines/scripts/run/first_run.sh
   then
    /home/engines/scripts/run/first_run.sh > /home/engines/scripts/run/first_run.sh
     touch /home/engines/run/flags/first_run_done		
  fi  
  if test -f /home/engines/scripts/run/post_install.sh
	then 				
	  echo "Has Post install"
	   if ! test -f /home/engines/run/flags/post_install.done
		 then
		  if test -f /home/engines/run/flags/started_once
		   then		  
		   echo "Running Post Install"
		   /bin/sh /home/engines/scripts/run/post_install.sh 	> 	/home/engines/run/flags/post_install.done						
		   touch /home/engines/run/flags/post_install.done		
		  fi	
	  fi
  fi
fi	
}

framework_start(){
if test -f /home/engines/scripts/startup/framework_start.sh
 then
   /home/engines/scripts/startup/framework_start.sh
 then
 fi
}

restart_required()
{	
if test -f /home/engines/run/flags/restart_required 
 then
  if test -f /home/engines/run/flags/started_once
   then
  	rm -rf /home/engines/run/flags/restart_required  
  else
    touch /home/engines/run/flags/started_once
  fi
fi

}

custom_start()
{
#if not blocking continues
if test -f /home/engines/scripts/run/start.sh
 then
   echo "Custom start"	   
   result=`/home/engines/scripts/run/start.sh`
   exit_code=$?
	 if test "$result" = "exit"
	  then 
		shutdown_complete
		exit $exit_code
	  fi
fi
}


