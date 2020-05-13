#Linux Cluster Monitoring Agent

##Introduction
In an organisation, there are a number of computers connected over a secured network. This connection between the computers and servers is maintained in the network through the use of a switch.
It is through this switch, the data is transferred. This network is maintained and monitored by administrators by observing various parameters like CPUtime, disk usage, memory available etc.
These parameters really help the administrators to identify if new hardware resources have been added or if they are under utilized.
Architecture and Design

##Current Project
This project is about monitoring the computer(host) usage for a single computer which is similar to tracking the parameters over a network.

##Database and Tables
We have modelled a database- host agent to enable us to store the information of our host. There are 2 tables -host_info and host_usage which has various parameters describing the host hardware specifications and the host usage details respectively.
 
##### Parameters captured in host_info table
Column Name | Description
----------------------------------------------------
id | This is the primary and auto increment field
host_name| 
cpu_number|
cpu_architecture|
cpu_model |
cpu_mhz |
L2_cache|
total_mem |
timestamp |
-----------------------------------------------------
##### Parameters captured in host_usage table
##Implementation
