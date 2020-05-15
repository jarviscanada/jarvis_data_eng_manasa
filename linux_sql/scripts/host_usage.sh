#! /bin/bash

#pseudo code

#hint: use a subquery to get id by hostname)


# CLI arguments to variable

#environment variable for the password
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4

export PGPASSWORD=$5

#variable
hostname=$(hostname -f)
timestamp=$(vmstat -t | awk '{print $18 " " $19}'|xargs | awk '{print $2 " " $3}' |xargs)
memory_free=$(cat /proc/meminfo | egrep "^MemFree:" | awk '{print $2}' |xargs)
cpu_idle=$(vmstat -t | awk '{print $14}'|xargs| awk '{print $2}')
cpu_kernel=$(vmstat -t | awk '{print $13}'|xargs| awk '{print $2}'|xargs)
disk_io=$(vmstat -d | awk '{print $10}'|xargs | awk '{print $2}'|xargs)
disk_available=$(df -BM |egrep "^/dev/sda2" |awk '{print $4}'| xargs| egrep -o '[0-9]+' |xargs)

#need to store it in a variable - get the host_id (use the sub query host name available)
host_id=$(psql -h "$psql_host" -U "$psql_user" -p "$psql_port" -d "$db_name"  POSTGRES_PASSWORD="$PGPASSWORD" -c "SELECT id
                                                                                                        from host_info;" |awk '{print $1}'|xargs| awk '{print $3}'|xargs)
                                                                                                        #where hostname="$hostname";"  )                                                                                                                                                                             hostname='"$hostname"');")
#echo "$hostname"
#echo "$host_id"
psql -h "$psql_host" -U "$psql_user" -d "$db_name" -p "$psql_port" POSTGRES_PASSWORD="$PGPASSWORD" -c "INSERT INTO host_usage
                                                                                                      (host_id,timestamp, memory_free, cpu_idle,
                                                                                                      cpu_kernel, disk_io, disk_available)
                                                                                                    VALUES
                                                               ("$host_id",'$timestamp',"$memory_free","$cpu_idle","$cpu_kernel","$disk_io","$disk_available");"



# Script usage
#bash -x ./scripts/host_usage.sh "$psql_host" "$psql_port" "$db_name" "$psql_user" POSTGRES_PASSWORD="$PGPASSWORD"
# bash -x ./scripts/host_usage.sh localhost 5432 host_agent postgres password