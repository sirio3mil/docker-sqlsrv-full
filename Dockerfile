# mssql-server-rhel
# Maintainers: Travis Wright (twright-msft on GitHub)
# GitRepo: https://github.com/twright-msft/mssql-server-rhel

# Base OS layer: latest CentOS 8
FROM centos:8

ENV ACCEPT_EULA=Y 
RUN dnf -y install dnf-plugins-core && \
    dnf config-manager --add-repo https://packages.microsoft.com/config/rhel/8/mssql-server-2019.repo && \
    dnf config-manager --add-repo https://packages.microsoft.com/config/rhel/8/prod.repo && \
    dnf -y install mssql-server mssql-server-fts mssql-tools unixODBC-devel && \
    dnf clean all && \
    rm -rf /var/cache/yum

ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin
RUN mkdir -p /var/opt/mssql/data && \
    chmod -R g=u /var/opt/mssql /etc/passwd && \
    /opt/mssql/bin/mssql-conf set sqlagent.enabled true 

# Default SQL Server TCP/Port
EXPOSE 1433

VOLUME /var/opt/mssql/data

# Run SQL Server process
CMD sqlservr
