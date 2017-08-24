function build_docker_image {
echo "----------------------"
echo "Building $tag"

if test -f setup.sh
 then 
  ./setup.sh
fi

cat Dockerfile | sed "/\$release/s//$release/" > Dockerfile.$release

if test -f nocache
 then
  args="build $extra --no-cache --rm=true -t $tag -f Dockerfile.$release ."
else
  args="build $extra --rm=true -t $tag -f Dockerfile.$release ."
fi
echo " Running   docker $args $TEE"
pwd


if test -z $TEE
 then
  docker $args  >& build.log
else
 echo "TEST"
  docker $args  | tee build.log
fi

if test $? -eq 0
 then
  echo "Built $tag"
    if test $# -gt 0
	  then
		if ! test -z $pushbuild 
		  then
		   docker push ${tag}
		fi
	fi
  touch last_built
  build_rest=1
  docker rmi $( docker images -f "dangling=true" -q) &>/dev/null
else
  echo "Failed to build $tag in $class/$dir"
  exit
fi						
}

function clear_old {
es=`docker ps  |grep -v CON | awk '{print $1}' &> /dev/null`

if ! test -z "$es"
 then
  docker stop $es
fi

es=`docker ps -a |grep -v CON | awk '{print $1}' &> /dev/null`

if ! test -z "$es"
 then
  docker rm $es &> /dev/null
fi
}


function process_args {
echo ARGS $ARGS

for arg in $ARGS
 do
  if test $arg = -h
   then
    echo "Usage\
    build all changed images $0\
    build all changed images and push freshly built $0 -p\
    build all changed images and push all images $0 -pushall \
    build all images and push all images $0 -A  \
    push all images $0 -pushonly "
    set the stop level dir -b dir  where dir is 01.BaseImages|02.FrameWorkImages|03.serviceImages|04.SystemServices|05.SystemApplications
    exit
  fi
  		
  if test $arg = '-A'
   then 	
     rm `find . -name last_built`
     echo "Force rebuild all"
     pushall=1
  elif test $arg = "-nocache"
   then
     extra=" --no-cache "
     echo "No Cache"
  	#--use-cache=false "	
  elif test $arg = "-pushall"
   then
     pushall=1		
     echo "Pushing all"      
  elif test $arg =  '-pushonly'
    then  
    echo "Pushing only" 
      pushonly=1
  elif test $arg = '-p'
   then 
     pushbuild=1
      echo "Push as built" 
  elif test $arg = '-t'
   then
     TEE=1
  elif test $arg = '-b'
   then
     build=1
  elif ! test -z $build 
   then
     builddir=$arg
     echo "using Builddir"
     unset  build 
  elif test $arg = '-c'
   then
     cname=1     
   elif ! test -z $cname
   then
     container=$arg
     echo "Build $cname"
     unset  cname      
  fi
done 	


}

function get_release {
if test -f release
then
  release=`cat release`
else
  release=latest
fi

export release
}
function eval_dependancies {
if test -f dependancies
 then
  for image_dir in `cat  dependancies`
   do
    if test -f /last_built
     then
       if test `find $image_dir -newer ./last_built|wc -c` -gt 1
        then
         echo clear last built due to change in $image_dir
         rm ./last_built
         break
       fi
     fi   
  done
 fi
}
function process_build_dir {
echo Processing Dir $dir


cd $dir

 if test -f TAG
   then 
     tag_r=`cat TAG`
     tag=$(eval "echo $tag_r")
     eval_dependancies 					
      if ! test -f ./last_built
       then
        echo "Forced Build"
        new=99
      else
        new=`find . -newer ./last_built|wc -c`
      fi      
      
      if ! test -z $pushonly
       then
        docker push ${tag}
      elif test 1 -lt $new
       then       
         build_docker_image
      fi
     echo "===========$tag==========="      				
      if ! test -z $pushall
       then
        docker push ${tag}
     fi
 fi
cd ..
}
 	