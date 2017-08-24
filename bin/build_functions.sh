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

if test -z $TEE
 then
  docker $args  >& build.log
else
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
for arg in $*
 do
  if test $arg = -h
   then
    echo "Usage\
    build all changed images $0\
    build all changed images and push freshly built $0 -p\
    build all changed images and push all images $0 -pushall \
    build all images and push all images $0 -A \
    push all images $0 -pushonly "
    exit
  fi
  		
  if test $arg = "-A"
   then 	
     rm `find . -name last_built`
  elif test $arg = "-nocache"
   then
     extra=" --no-cache "
  	#--use-cache=false "	
  elif test $arg = "-pushall"
   then
     pushall=1		 
  elif test $arg =  -pushonly
    then  
      pushonly=1
  elif test $arg =  -p
   then 
     pushbuild=1
  elif test $arg = -t
   then
     TEE=1
  elif test $arg = -b
   then
     build=1
  elif ! test -z $build 
   then
     builddir=$arg
     unset  build 
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

function process_build_dir {
echo Processing Dir $dir
 if ! test -d $dir
  then 
	continue
 fi

cd $dir

 if test -f TAG
   then 
     tag_r=`cat TAG`
     tag=$(eval "echo $tag_r") 					
      if ! test -f ./last_built
       then
        new="yesy yesy yesy"
      else
        new=`find . -newer ./last_built`
      fi      
      if ! test -z $pushonly
       then
        docker push ${tag}
      elif test 1 -lt `echo $new |wc -c`
       then
         build_docker_image
      fi
     echo "===========$tag==========="      				
      if ! test -z $pushall
       then
        docker push ${tag}
     fi
 fi
}
 	