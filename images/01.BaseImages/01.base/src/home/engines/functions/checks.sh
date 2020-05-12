check_required_values()
{
for val in $required_values 
 do
   value=`eval echo \\$${val}`
    if test -z "$value"
     then
       echo '{"Error":"Abort no value receieved for '$val'"}'
       exit 2
    fi
done

}
