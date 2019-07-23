# mssql-server-rhel
# Maintainers: Travis Wright (twright-msft on GitHub)
# GitRepo: https://github.com/twright-msft/mssql-server-rhel

# Base OS layer: latest CentOS 7
FROM centos:7

# Install latest mssql-server package
RUN curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-preview.repo && \
    curl -o /etc/yum.repos.d/mssql-tools.repo https://packages.microsoft.com/config/rhel/7/prod.repo && \
    ACCEPT_EULA=Y yum install -y mssql-server mssql-server-fts mssql-tools unixODBC-devel && \
    yum clean all

ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin
RUN mkdir -p /var/opt/mssql/data && \
    chmod -R g=u /var/opt/mssql /etc/passwd

# Default SQL Server TCP/Port
EXPOSE 1433

VOLUME /var/opt/mssql/data

# Run SQL Server process
CMD sqlservr
