FROM debian:bullseye

RUN apt -y update && apt install -y nginx && apt upgrade  -y openssl

COPY ./requirements/nginx/tools/nginx_start.sh /usr/local/bin/nginx_start.sh

RUN chmod +x /usr/local/bin/nginx_start.sh

ENTRYPOINT [ "nginx_start.sh" ]
