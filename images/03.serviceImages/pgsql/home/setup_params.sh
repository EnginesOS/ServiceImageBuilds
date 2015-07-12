#/bin/bash

n=1


echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi

res="${1//[^:]}"
echo $res
fcnt=${#res}
fcnt=`expr $fcnt + 1`

        while test $fcnt -ge $n
        do
                nvp="`echo $1 |cut -f$n -d:`"
                n=`expr $n + 1`
                name=`echo $nvp |cut -f1 -d=`
                export $name=`echo $nvp |cut -f2 -d=`
        done
        
su postgres -c psql  "alter user rma with PASSWORD '$pgsql_password';"
