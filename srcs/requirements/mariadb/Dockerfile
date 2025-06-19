FROM debian:bullseye

USER root

RUN apt -y update && apt install -y mariadb-server mariadb-client

COPY ./tools/db_start.sh /usr/local/bin/db_start.sh

RUN chmod +x /usr/local/bin/db_start.sh

ENTRYPOINT [ "db_start.sh" ]