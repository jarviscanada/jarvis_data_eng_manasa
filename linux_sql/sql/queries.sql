--group hosts by CPU number
SELECT
   first_value(cpu_number) over(partition by cpu_number) AS cpunumber,
   id AS host_id,
   total_mem
FROM host_info
ORDER BY total_mem DESC;

--UPDATE host_usage SET timestamp=date_round_down('$timestamp','5 minutes');
--average memory usage
SELECT
   first_value(u.host_id) over(partition by u.host_id) AS hostid,
   i.hostname,
   u.timestamp_round,
   (i.total_mem - u.memory_free) AS used_memory
FROM host_usage u
INNER JOIN host_info i ON  i.id=u.host_id;