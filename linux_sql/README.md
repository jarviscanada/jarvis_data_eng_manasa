
*#Linux Cluster Monitoring Agent*

##Introduction
In an organisation, there are a number of computers connected over a secured network. This connection between the computers and servers is maintained in the network through the use of a switch.
It is through this switch, the data is transferred. This network is maintained and monitored by administrators by observing various parameters like CPUtime, disk usage, memory available etc.
These parameters really help the administrators to identify if new hardware resources have been added or if they are under utilized.
Architecture and Design

##Current Project
This project is about monitoring the computer(host) usage for a single computer which is similar to tracking the parameters over a network.

##Architecture and Design
![Image of Architecture Diagram](./images/Architecture.png)

###Database and Tables
We have modelled a database with two tables.
* Database 
  *Host_agent -This database enables us to capture all the hardware and disk usage information of our hosts.
* Tables
  *Host_info - This table stores all the hardware specification of the hosts in the network.
  *Host_usage- This table captures the usage details of the various parameters like memory, CPU and so on.
* Scripts
  *Psql_docker.sh - This script file carries the control instructions of Docker container. This allows us to create/start or stop the docker container from command line.
  *host_info.sh - This script contains the Data Definition scripts for creation of the database tables.
  *host_usage.sh - this script contains the Data Manipulation queries to fulfill the tables.  
 
##### Parameters captured in host_info table
Column Name | Description
-------------|---------------------------------------
id | This is the primary and auto increment field
host_name| This displays the name of the host computer. In a network, there are many computers and each one has a name. 
cpu_number|This is the number of CPUs on the host.
cpu_architecture| This parameter describes the architecture of the host.
cpu_model | This talks about the model of the CPU
cpu_mhz | This describes the frequency of the CPU.
L2_cache| This talks about the L2 cache memory.
total_mem | This gives the total memory of the host.
timestamp | This tracks the timestamp of the information captured.
---------------|--------------------------------------
##### Parameters captured in host_usage table
Column Name | Description
--------------|---------------------------------------
host_id | This is a foreign key referencing from the id of the host info table.
timestamp | The timestamp for each data entered is captured.
memory_free| The memory available is noted.
cpu_idle| The cpu idle information
cpu_kernel| The details of the cpu kernel is captured.
disk_io | This has the disk input output information.
disk_available | This gives the available disk option.
----------------|-------------------------------------

###Usage
The database tends to capture the network details of the host computer in the network. To make the capture efficient, since the network and memory usage change every minute, 
we also want to implement this feature in our data capture. For this, we use a technique called, crontab. This crontab generates the insert query every minute for effifcient 
network usage tracking.

###Improvements
* We could handle the hardware update also frequently rather than just once.
* We could also try to capture the network usage as a whole rather than at the host computer level.

