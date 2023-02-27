FROM kong:2.8.1-ubuntu
LABEL description="Kong 2.8.1-ubuntu + some other plugins"

USER root

RUN apt update
RUN apt install gcc libpcre3 libpcre3-dev -y
RUN apt install libmysqlclient-dev -y

WORKDIR /app

COPY ["kong-plugin-jwt-claims-to-headers-1.0.0-1.rockspec", "./"]
COPY ["casbin-1.16.1-1.rockspec", "./"]
COPY ["casbin-adapter-1.0.0-1.rockspec", "./"]
COPY ["kong-authz-0.0.1-1.rockspec", "./"]
COPY ["kong-plugin-http-log-with-body-0.1.1-2.rockspec", "./"]

RUN luarocks install luasql-mysql MYSQL_INCDIR=/usr/include/mysql
RUN luarocks install ./kong-plugin-jwt-claims-to-headers-1.0.0-1.rockspec
RUN luarocks install ./casbin-1.16.1-1.rockspec
RUN luarocks install ./casbin-adapter-1.0.0-1.rockspec
RUN luarocks install ./kong-authz-0.0.1-1.rockspec
RUN luarocks install ./kong-plugin-http-log-with-body-0.1.1-2.rockspec

RUN rm *.rockspec

USER kong
