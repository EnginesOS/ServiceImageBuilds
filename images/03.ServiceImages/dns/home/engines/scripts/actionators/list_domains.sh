#!/bin/sh


format_entry()
{
 if test $n -eq 0
 then
   n=1
 else
  echo -n ,
fi
 echo -n '"'$list_entry'"'
}

list_entries()
{
 for list_entry in `ls`
 do
  format_entry
 done
}


echo -n '{"internal":['
if test -d /home/bind/domain_list/lan/
 then
   cd /home/bind/domain_list/lan/
   n=0
   list_entries
fi

echo -n '],"external":['


if test -d /home/bind/domain_list/wan/
 then
  cd /home/bind/domain_list/wan/
  n=0
  list_entries
fi

echo ']}'