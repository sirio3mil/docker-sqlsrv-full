# mssql-server-rhel
# Maintainers: Travis Wright (twright-msft on GitHub)
# GitRepo: https://github.com/twright-msft/mssql-server-rhel

# Base OS layer: latest CentOS 8
FROM centos:8

# Install latest mssql-server package
RUN dnf config-manager --add-repo https://packages.microsoft.com/config/rhel/8/insiders-fast.repo
RUN dnf config-manager --add-repo https://packages.microsoft.com/config/rhel/8/prod.repo
ENV ACCEPT_EULA=Y 
RUN dnf install -y mssql-server mssql-server-fts mssql-tools unixODBC-devel

ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin
RUN mkdir -p /var/opt/mssql/data && \
    chmod -R g=u /var/opt/mssql /etc/passwd
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true 

# Default SQL Server TCP/Port
EXPOSE 1433

VOLUME /var/opt/mssql/data

# Run SQL Server process
CMD sqlservr
