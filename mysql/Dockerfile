FROM mysql:5

# ROOT PASSWORD
# to secure your installation, you should avoid MYSQL_ROOT_PASSWORD and 
# instead set MYSQL_RANDOM_ROOT_PASSWORD and MYSQL_ONETIME_PASSWORD to yes


ENV MYSQL_RANDOM_ROOT_PASSWORD=yes
ENV MYSQL_ONETIME_PASSWORD=no
ENV MYSQL_USER=itip
ENV MYSQL_PASSWORD=#itip2017

# NEW USER AND DATABASE
# you can specify the name of a database to be created during initialization.
# if you specify also an username and password, the mysql user will be created 
# with full control over that database.

ENV MYSQL_DATABASE=itip
#ENV MYSQL_USER=sample-username
#ENV MYSQL_PASSWORD=sample-password

# SERVER DEFAULT CHARSET AND COLLATION

COPY schema/itip.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
