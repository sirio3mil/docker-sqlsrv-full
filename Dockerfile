# mssql-server-rhel
# Maintainers: Travis Wright (twright-msft on GitHub)
# GitRepo: https://github.com/twright-msft/mssql-server-rhel

# Base OS layer: latest CentOS 7
FROM centos:7

# Install latest mssql-server package
RUN curl https://packages.microsoft.com/config/rhel/7/mssql-server-preview.repo > /etc/yum.repos.d/mssql-server.repo && \
    curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-tools.repo && \
    ACCEPT_EULA=Y yum install -y mssql-server mssql-tools mssql-server-fts && \
    yum clean all

ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin

RUN MSSQL_PID=Developer ACCEPT_EULA=Y MSSQL_SA_PASSWORD='2_;bT=%!ca' MSSQL_AGENT_ENABLED=true /opt/mssql/bin/mssql-conf -n setup

# Default SQL Server TCP/Port
EXPOSE 1433

VOLUME /var/opt/mssql

# Run SQL Server process
CMD sqlservr
