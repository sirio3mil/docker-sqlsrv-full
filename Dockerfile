FROM centos

RUN curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo

RUN yum install -y mssql-server mssql-server-fts

RUN /opt/mssql/bin/mssql-conf -n setup

CMD /opt/mssql/bin/sqlservr
