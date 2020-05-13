
-- attach to the database host_agent;
\c host_agent;

--check the existing databases
\dt;

-- DDL statement for host_info table creation
CREATE TABLE IF NOT EXISTS PUBLIC.host_info (
  id SERIAL         NOT NULL,
  hostname          VARCHAR NOT NULL,
  cpu_number        SMALLINT NOT NULL,
  cpu_architecture  VARCHAR NOT NULL,
  cpu_model         VARCHAR NOT NULL,
  cpu_mhz           FLOAT(4) NOT NULL,
  L2_cache          SMALLINT NOT NULL,
  total_mem         INTEGER NOT NULL,
  timestamp         TIMESTAMP NOT NULL,
  CONSTRAINT pk_hostname PRIMARY KEY(hostname),
  CONSTRAINT uni_hostname_id UNIQUE(hostname, ID)
);

-- DDL statement for host_usage table creation
CREATE TABLE IF NOT EXISTS PUBLIC.host_usage (
  host_id       SERIAL NOT NULL,
  "timestamp"   TIMESTAMP NOT NULL,
  memory_free   INTEGER NOT NULL,
  cpu_idle      INTEGER NOT NULL,
  cpu_kernel    INTEGER NOT NULL,
  disk_io       INTEGER NOT NULL,
  disk_available INTEGER NOT NULL

  );

  --check for the newly created tables
  \dt;