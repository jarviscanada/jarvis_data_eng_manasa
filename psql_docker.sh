#! /bin/bash

# CLI arguments are assigned to variables.
db_username=$2
db_password=$3

if [ $(systemctl status docker | wc -l) == 20 ]; then
   #systemctl start docker
   echo "The docker engine is running"
fi
# in create mode, we check for the existence of docker
if [ "$1" == "create" ]; then
  #check to see if there is any existing container names -jrvs-psql
  if [ $(docker container ls -a -f name=jrvs-psql | wc -l) == "2" ]; then
     echo "The container jrvs-psql has already been existing."
     exit 1
  fi

# To check for the username and password parameters sent as CLI arguments
  if [ "$2" == "" ] || [ "$3" == "" ]; then
    echo "Please pass both the username and password."
    exit 1
  fi

 #Here an extra drive is created
  docker volume create pgdata
 # Grab the postgres image from the library or download if not available
  docker pull postgres
 # Create a container with the name-jrvs-psql with the postgres image
  docker run --name jrvs-psql -e POSTGRES_PASSWORD=db_password -e POSTGRES_USER=db_username -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres
  exit $?

  if [ $(docker ps -f name=jrvs-psql| wc -l) == 1 ]; then
      echo "The container jrvs-sql has not been created"
      exit 1
  else
      echo "The container jrvs-sql has been created"
  fi

elif [ "$1" = "start" ]; then
  docker container start jrvs-psql
  echo "The container has been started."
  exti $?


elif [ "$1" = "stop" ]; then
  docker container stop jrvs-psql
  echo "The container has been stopped"
  exit $?


else
  echo "This command is invalid"
  exit 1
fi
