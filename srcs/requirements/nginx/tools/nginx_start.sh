#!/usr/bin/env bash
# source .env # we load the .env file

# mkdir $CERT_DIR # should we add this in the env?
mkdir -p $CERT_DIR

openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
		-keyout $CERT_KEY \
		-out $CERT \
		-subj /CN=$HOST_NAME

echo "server { 
      listen 443 ssl http2; 
      server_name localhost; 
      root  $WP_ROUTE; 
      index index.php index.html index.htm index.nginx-debian.html; 
      ssl_protocols TLSv1.2 TLSv1.3; 
      ssl_certificate $CERT; 
      ssl_certificate_key $CERT_KEY;" > $NGINX_CONF;

echo '
            location / {
                  try_files $uri $uri/ /index.php?$args = 404;
            }
            location ~ \.php$ {
                  include snippets/fastcgi-php.conf;
                  fastcgi_pass wordpress:9000;
            }
      }' >>$NGINX_CONF;

nginx -g "daemon off;"