FROM centos:latest
ENV container docker
MAINTAINER "Reynier de la Rosa" <reynier.delarosa@outlook.es>

RUN yum -y update
RUN yum -y install epel-release \
                   curl
RUN curl https://packages.microsoft.com/config/rhel/7/mssql-server.repo > /etc/yum.repos.d/mssql-server.repo
RUN yum install -y mssql-server \
                   mssql-server-fts \ 
		   mssql-server-agent
RUN yum clean all 
 
EXPOSE 1433

ADD container-files/script/* /tmp/script/

RUN chmod 755 /tmp/script/bootstrap.sh

# put customized config and code files to /data

CMD ["/tmp/script/bootstrap.sh"]
