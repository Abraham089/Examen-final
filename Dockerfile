FROM mysql:8

COPY ./config/mycnf.cnf /etc/mysql/conf.d/mycnf.cnf

RUN chmod 644 /etc/mysql/conf.d/mycnf.cnf