#/!bin/bash


function load_service_hash_to_environment {

n=1

echo $service_hash |grep = >/dev/null
        if test $? -ne 0
        then
        		echo Error:No Arguments
                exit -1
        fi

#Strip preceeding and trailing :
new=`echo $service_hash | sed "/^:/s///" |  sed "/:$/s///"`
echo new
echo $new
service_hash=$new



res="${service_hash//[^:]}"
echo $res
fcnt=${#res}
fcnt=`expr $fcnt + 1`

        while test $fcnt -ge $n
        do
                nvp="`echo $service_hash |cut -f$n -d:`"
                n=`expr $n + 1`
                name=`echo $nvp |cut -f1 -d=`
                value=`echo $nvp |cut -f2 -d=`
                if test ${#name} -gt 0
                	then
                		export $name="$value"
                	fi
        done
}
