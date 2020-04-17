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
  if test -f /home/engines/scripts/engine/first_run.sh
   then
    /home/engines/scripts/engine/first_run.sh
     touch /home/engines/run/flags/first_run_done		
  fi  
  if test -f /home/engines/scripts/engine/post_install.sh
	then 				
	  echo "Has Post install"
	   if ! test -f /home/engines/run/flags/post_install.done
		 then
		  if test -f /home/engines/run/flags/started_once
		   then		  
		   echo "Running Post Install"
		   /bin/sh /home/engines/scripts/engine/post_install.sh 							
		   touch /home/engines/run/flags/post_install.done		
		  fi	
	  fi
  fi
fi	
}

framework_start(){
if test -f /home/engines/scripts/startup/framework_start.sh
 then
   /home/engines/scripts/startup/framework
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
if test -f /home/engines/scripts/engine/custom_start.sh
 then
   echo "Custom start"	   
   result=`/home/engines/scripts/engine/custom_start.sh`
   exit_code=$?
	 if test "$result" = "exit"
	  then 
		shutdown_complete
		exit $exit_code
	  fi
fi
}

pre_running()
{
if test -f /home/engines/scripts/engine/pre-running.sh
 then
	echo "launch pre running"
	/home/engines/scripts/engine/pre-running.sh
fi	
}

