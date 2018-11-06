#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

 mkdir -p /tmp/big/
Archive=/tmp/big/archive
cd /home/fs
dirname=`basename $engine_path `
cp -rp $engine_path /tmp/big/$dirname.bak

if test -f  /tmp/extract.err
 then
rm /tmp/extract.err
fi

cat - > $Archive
cd /
type=`file -i $Archive |grep application/gzip`
if test $? -eq 0
 then
echo Gzip
 echo xxx
echo "cat $Archive | gzip -d | tar -xpf  -"
cat  $Archive  | gzip -d  | tar -xpf  -  2>/tmp/extract.err
else
cat $Archive | tar -xpf  - 2>/tmp/extract.err

  fi
        if test $? -eq 0
          then
           rm  $Archive
           rm -r /tmp/big/$dirname.bak
           exit 0
           else
            rm -r $engine_path/*
            cp -rp /tmp/big/$dirname.bak/. $engine_path
            cat  /tmp/extract.err
            echo  Rolled back >&2
         fi
