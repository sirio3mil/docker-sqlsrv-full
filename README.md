# docker-sqlsrv-full
Dockerfile for SQL Server container in CentOS with FTS and agent enable

Example docker compose file

```yml
version: '3.7'
services:
  mssql:
    image: reynier3mil/centos-mssql-full:latest
    container_name: mssql
    volumes:
      - ./data/mssql/backups:/tmp/backups
    ports:
      - 1433:1433
    environment:
      - ACCEPT_EULA=Y
      - MSSQL_SA_PASSWORD=xxxxxxxx
      - MSSQL_PID=Developer
      - MSSQL_AGENT_ENABLED=true
```
