#### INSTALAÇÃO DE SERVIDOR OTIMIZADO PARA WordPress + WooCommerce


#### PASSO 1
``` sh
sudo -i
cd /
apt-get update && apt-get upgrade && apt-get dist-upgrade
```


#### PASSO 2

- wget -qO ee rt.cx/ee && sudo bash ee


#### PASSO 3

- nano /etc/ee/ee.conf

##### [mysql]

Ask for MySQL db name while site creation <br>
db-name = **True**

Ask for MySQL user name while site creation <br>
db-user =  **True**

##### [wordpress]

Ask for WordPress prefix while site creation <br>
prefix = **True**

User name for WordPress sites <br>
user = **useradmin**

Password for WordPress sites <br>
password = **senhaadmin**

EMail for WordPress sites <br>
email = **emailadmin**


#### PASSO 4

- ee site create MINHALOJA.com.br --wpfc


#### PASSO 5

- nano /var/www/MINHALOJA.com.br/wp-config.php

  ``` php
  define( 'WP_MEMORY_LIMIT', '128M' );
  define ( 'AUTOMATIC_UPDATER_DISABLED', true );
  ```

#### PASSO 6

- nano /etc/nginx/common/wpfc-woocommerce.conf

``` php
# WPFC-WOOCOMMERCE NGINX CONFIGURATION

set $skip_cache 0;

# POST requests and URL with a query string should always go to php
if ($request_method = POST) {
     set $skip_cache 1;
}

if ($query_string != "") {
     set $skip_cache 1;
}

# Don't cache URL containing the following segments
 if ($request_uri ~* "(/carrinho.*|/minha-conta.*|/finalizar-compra.*|/addons.*|/wp-admin/|/xmlrpc.php|wp-.*.php|/feed/|index.php|sitemap(_index)?.xml|[a-z0-9_-]+-sitemap([0-9]+)?.xml)") {
     set $skip_cache 1;
}

# Don't use the cache for logged in users or recent commenter
if ($http_cookie ~* "comment_author|wordpress_[a-f0-9]+|wp-postpass|wordpress_no_cache|wordpress_logged_in") {
     set $skip_cache 1;
}

# Use cached or actual file if they exists, Otherwise pass request to WordPress
location / {
     try_files $uri $uri/ /index.php?$args;
}

location ~ \.php$ {
     set $rt_session "";

     if ($http_cookie ~* "wp_woocommerce_session_[^=]*=([^%]+)%7C") {
     set $rt_session wp_woocommerce_session_$1;
     }

     if ($skip_cache = 0 ) {
          more_clear_headers "Set-Cookie*";
          set $rt_session "";
     }

     fastcgi_cache_key "$scheme$request_method$host$request_uri$rt_session";

     try_files $uri =404;
     include fastcgi_params;

     fastcgi_pass php;

     fastcgi_cache_bypass $skip_cache;
     fastcgi_no_cache $skip_cache;

     fastcgi_cache WORDPRESS;
     fastcgi_cache_valid 60m;
}

location ~ /purge(/.*) {
     fastcgi_cache_purge WORDPRESS "$scheme$request_method$host$1";
}
```


#### PASSO 7

- ee site edit MINHALOJA.com.br

  ``` php
  # include common/wpfc.conf; 
  include common/wpfc-woocommerce.conf;
  ```

- chown -R www-data:www-data /var/www/MINHALOJA.com.br/htdocs


#### BÔNUS (PHPMyAdmin)

- ee secure --auth

- ee stack install --phpmyadmin

- nano /root/.my.cnf

``` html
http://www.MINHALOJA.com.br/pma
```

[Link da Vídeo-Aula] (http://youtu.be/m7mGl683Ioc)

# SUCESSO !

## Dúvidas: edisoncosta@lojaplus.com.br
