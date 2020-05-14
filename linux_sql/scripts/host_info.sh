#! /bin/bash

# CLI arguments set to local variables
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
#psql_password=$5

EXPORT PGPASSWORD = $5

#hardware specifications from various commands formatted.
#lscpu_out=`lscpu`
#save hostname to a variable
hostname=$(hostname -f)
#save number of cpu's to a variable
cpu_number=$(lscpu  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
#echo "$cpu_number"
#save the architecture of cpu to a variable
cpu_architecture=$(lscpu | egrep "^Architecture:" | awk '{print $2}' | xargs)
#to capture the model of the cpu
cpu_model=$(lscpu | egrep "^Model name:" | awk '{print $3 $4 $5 $6 $7}' |xargs)
#to capture the frequence of the cpu
cpu_mhz=$(lscpu | egrep "^CPU MHz:" | awk '{print $3 $4}' |xargs)
# to capture the cache details of cpu
l2_cache=$(lscpu | egrep "^L2 cache:" | awk '{print $3}' |xargs|egrep -o '[0-9]+')
#to fetch the total memory in the cpu
total_mem=$(cat /proc/meminfo | egrep "^MemTotal:" | awk '{print $2}' |xargs)
#to fetch the time stamp of the current transaction
#timestamp=$(vmstat -t | awk '{print $18 " " $19}'|xargs)
timestamp=$(vmstat -t | awk '{print $18 " " $19}'|xargs | awk '{print $2}' |xargs)
# -h specifies the hostname of the machine on which the server is running
# -U specifies the username
# -d specifies the name of the database to connect to

# -c specified that we are running single command
# -p specifies the port number on which the server is running
psql -h "$psql_host" -U "$psql_user" -d "$db_name" -p "$psql_port" POSTGRES_PASSWORD="$PGPASSWORD" -c "INSERT INTO host_info(
                                                   hostname, cpu_number, cpu_architecture,
                                                  cpu_model, cpu_mhz, l2_cache, total_mem,
                                                    timestamp
                                                  ) VALUES
  ('"$hostname"', "$cpu_number", '"$cpu_architecture"', '"$cpu_model"', "$cpu_mhz","$l2_cache","$total_mem",'"$timestamp"');"

#to execute the script in terminal
#./scripts/host_info.sh "localhost" 5432 "host_agent" "postgres" "password"
#./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password







