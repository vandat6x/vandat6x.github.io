#!/bin/bash


# Begin installation

echo "===================================================="
echo "=  NGINX 1.9 + PHP 7.0 + wordpress Cho Openshift ！ ="
echo "=                                                  ="
echo "=                                                  ="
echo "=                                                  ="
echo "=                                                  ="     
echo "=                                                  ="
echo "=                                                  ="
echo "=                                                  ="
echo "=                                                  =" 
echo "=                                                  ="
echo "=                                                  ="
echo "=                  Cài đặt...                      ="
echo "=                                                  ="
echo "===================================================="
read -p " nhan [Enter] de tiep tuc..."

unset TMOUT
read -p "Nhap phien ban nginx (v.d 1.9.13) : " NGINX_VERSION
read -p "Nhap phien ban php (v.d 7.0.5) : " PHP_VERSION
NGINX_VERSION='1.9.14'
PHP_VERSION='7.0.5'
cd $OPENSHIFT_TMP_DIR
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar xzf nginx-${NGINX_VERSION}.tar.gz
#wget http://exim.mirror.fr/pcre/pcre-8.38.tar.gz
wget https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/pcre-8.38.tar.gz
tar xzf pcre-8.38.tar.gz
git clone https://github.com/FRiCKLE/ngx_cache_purge.git
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module.git
cd ${OPENSHIFT_TMP_DIR}nginx-${NGINX_VERSION}
./configure --prefix=$OPENSHIFT_DATA_DIR --with-pcre=${OPENSHIFT_TMP_DIR}pcre-8.38 --with-pcre-jit --with-threads --with-http_realip_module --with-http_sub_module --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_geoip_module --with-http_secure_link_module --without-mail_pop3_module
--without-mail_imap_module --without-mail_smtp_module --add-module=${OPENSHIFT_TMP_DIR}ngx_http_substitutions_filter_module --add-module=${OPENSHIFT_TMP_DIR}ngx_cache_purge
make -j4 && make install
cd /tmp
rm -rf *
wget -O libmcrypt-2.5.8.tar.gz https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/libmcrypt-2.5.8.tar.gz
tar xzf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j && make install
cd libltdl
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local --enable-ltdl-install
make -j && make install
cd ../..
wget -O mhash-0.9.9.9.tar.gz https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/mhash-0.9.9.9.tar.gz
tar zxvf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j && make install
cd ..
wget  --no-check-certificate -O re2c-0.13.7.5.tar.gz https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/re2c-0.13.7.5.tar.gz
tar xzf re2c-0.13.7.5.tar.gz
cd re2c-0.13.7.5
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j && make install
cd ..
wget -O mcrypt-2.6.8.tar.gz https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/mcrypt-2.6.8.tar.gz
tar xzf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8
export LDFLAGS="-L${OPENSHIFT_DATA_DIR}usr/local/lib -L/usr/lib"
export CFLAGS="-I${OPENSHIFT_DATA_DIR}usr/local/include -I/usr/include"
export LD_LIBRARY_PATH="/usr/lib/:${OPENSHIFT_DATA_DIR}usr/local/lib"
export PATH="/bin:/usr/bin:/usr/sbin:${OPENSHIFT_DATA_DIR}usr/local/bin:${OPENSHIFT_DATA_DIR}bin:${OPENSHIFT_DATA_DIR}sbin"
touch malloc.h
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local --with-libmcrypt-prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j && make install
cd ..
wget -O php-${PHP_VERSION}.tar.gz http://us3.php.net/get/php-${PHP_VERSION}.tar.gz/from/this/mirror
tar xzf php-${PHP_VERSION}.tar.gz
cd php-${PHP_VERSION}
./configure --prefix=$OPENSHIFT_DATA_DIR --with-config-file-path=${OPENSHIFT_DATA_DIR}etc --with-layout=GNU --with-mcrypt=${OPENSHIFT_DATA_DIR}usr/local --with-pear --with-pgsql --with-mysqli --with-pdo-mysql --with-pdo-pgsql --enable-pdo --with-pdo-sqlite --with-sqlite3 --with-openssl --with-zlib-dir --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-bz2 --with-libxml-dir --with-curl --with-gd --with-xsl --with-xmlrpc --with-mhash --with-gettext --with-readline --with-kerberos --with-pcre-regex --enable-json --enable-bcmath --enable-cli --enable-calendar --enable-dba --enable-wddx --enable-inline-optimization --enable-simplexml --enable-filter --enable-ftp --enable-tokenizer --enable-dom --enable-exif --enable-mbregex --enable-fpm --enable-mbstring --enable-gd-native-ttf --enable-xml --enable-xmlwriter --enable-xmlreader --enable-pcntl --enable-sockets --enable-zip --enable-soap --enable-shmop --enable-sysvsem --enable-sysvshm --enable-sysvmsg --enable-intl --enable-maintainer-zts --enable-opcache --enable-phar=shared --disable-debug --disable-fileinfo --disable-ipv6 --disable-rpath
make -j4 && make install
cp ${OPENSHIFT_TMP_DIR}php-${PHP_VERSION}/php.ini-development ${OPENSHIFT_DATA_DIR}etc/php.ini
cp ${OPENSHIFT_DATA_DIR}etc/php-fpm.conf.default ${OPENSHIFT_DATA_DIR}etc/php-fpm.conf
cp ${OPENSHIFT_DATA_DIR}etc/php-fpm.d/www.conf.default ${OPENSHIFT_DATA_DIR}etc/php-fpm.d/www.conf
#cài đặt Memcache Redis GeoIP 
cd /tmp
wget https://github.com/websupport-sk/pecl-memcache/archive/NON_BLOCKING_IO_php7.zip
unzip NON_BLOCKING_IO_php7.zip
cd pecl-memcache-NON_BLOCKING_IO_php7
phpize
./configure --with-php-config=${OPENSHIFT_DATA_DIR}/bin/php-config --enable-memcache
make -j && make install
cd /tmp
wget -c https://github.com/phpredis/phpredis/archive/php7.zip
unzip php7.zip
cd phpredis-php7
phpize
./configure --with-php-config=${OPENSHIFT_DATA_DIR}/bin/php-config
make -j && make install
cd /tmp
git clone https://github.com/Zakay/geoip.git
cd geoip
phpize
./configure --with-php-config=${OPENSHIFT_DATA_DIR}/bin/php-config --with-geoip
make -j && make install
wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
gunzip GeoIP.dat.gz
mkdir ${OPENSHIFT_DATA_DIR}geoip
mv GeoIP.dat ${OPENSHIFT_DATA_DIR}geoip/GeoIP.dat
mkdir ${OPENSHIFT_REPO_DIR}www
echo "<?php phpinfo(); ?>" >> ${OPENSHIFT_REPO_DIR}www/info.php
sed -i "s/default_type  application\/octet-stream;/default_type  application\/octet-stream;\n    port_in_redirect off;\n    server_tokens off;/g;s/listen       80;/listen       ${OPENSHIFT_DIY_IP}:8080;/g;s/            root   html;/            root   \/var\/lib\/openshift\/${OPENSHIFT_APP_UUID}\/app-root\/runtime\/repo\/www;/g;s/index  index.html index.htm;/index  index.php index.html index.htm;/g;s/# deny access to .htaccess files, if Apache's document root/location ~ \\\.php\$ {\n            root           \/var\/lib\/openshift\/${OPENSHIFT_APP_UUID}\/app-root\/runtime\/repo\/www;\n            #fastcgi_pass   ${OPENSHIFT_DIY_IP}:9000;\n          fastcgi_pass  unix:\/dev\/shm\/php-fpm.sock;\n            fastcgi_index  index.php;\n            fastcgi_param   SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;\n            fastcgi_param   SCRIPT_NAME        \$fastcgi_script_name;\n            include        fastcgi_params;\n        }\n\n        # deny access to .htaccess files, if Apache's document root/g" ${OPENSHIFT_DATA_DIR}conf/nginx.conf
sed -i "s/nginx\/\$nginx_version;/nginx;/g" ${OPENSHIFT_DATA_DIR}conf/fastcgi.conf
sed -i "s/user = nobody/;user = nobody/g;s/group = nobody/;group = nobody/g;s/listen = 127.0.0.1:9000/;listen = ${OPENSHIFT_DIY_IP}:9000\nlisten = \/dev\/shm\/php-fpm.sock/g;s/pm.max_children = 5/pm.max_children = 20/g;s/pm.start_servers = 2/pm.start_servers = 10/g;s/pm.min_spare_servers = 1/pm.min_spare_servers = 6/g;s/pm.max_spare_servers = 3/pm.max_spare_servers = 20/g" ${OPENSHIFT_DATA_DIR}etc/php-fpm.d/www.conf
sed -i "s/short_open_tag = Off/short_open_tag = On/g;s/upload_max_filesize = 2M/upload_max_filesize = 38M/g;s/max_file_uploads = 20/max_file_uploads = 38/g;s/post_max_size = 8M/post_max_size = 38M/g;s/max_input_time = 60/max_input_time = 300/g;s/default_socket_timeout = 60/default_socket_timeout = 300/g;s/max_execution_time = 30/max_execution_time = 180/g;s/;date.timezone =/date.timezone = Asia\/Taipei/g;s/disable_functions =/disable_functions = passthru,exec,system,chroot,chgrp,shell_exe,putenv/g;s/; End:/; End:\n\nzend_extension=opcache.so\nopcache.enable=1\nopcache.enable_cli=1\nopcache.file_cache=\/tmp\n;加载 Memcache Redis GeoIP 扩展，不需要请去除\nextension=memcache.so\nextension=redis.so\nextension=geoip.so\ngeoip.custom_directory=\${OPENSHIFT_DATA_DIR}geoip\/\n/g" ${OPENSHIFT_DATA_DIR}etc/php.ini
cd /tmp
rm -rf *
cd ${OPENSHIFT_REPO_DIR}.openshift/action_hooks
rm -rf start
wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/start
chmod +x start
cd ${OPENSHIFT_REPO_DIR}.openshift/cron/minutely
rm -rf restart.sh
wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/restart.sh
chmod +x restart.sh
rm -rf delete_log.sh
wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/delete_log.sh
chmod +x delete_log.sh
cd ${OPENSHIFT_REPO_DIR}www
wget https://raw.githubusercontent.com/vandat6x/vandat6x.github.io/master/index.php
wget http://www.yahei.net/tz/tz_e.zip
unzip tz_e.zip
rm -rf tz_e.zip
mv tz_e.php tz.php
sed -i "s/\$_SERVER\['REMOTE_ADDR'\];/\$_SERVER\['HTTP_X_FORWARDED_FOR'\];/g;s/\$_SERVER\[PHP_SELF\]/\$_SERVER\['PHP_SELF'\]/g;s/\$_SERVER\['PHP_SELF'\]/htmlentities(\$_SERVER\[‘PHP_SELF’\])/g;s/eregi(\"phpinfo\",\$disFuns)/preg_match(\"phpinfo\/i\",\$disFuns)/g;s/mcrypt_cbc/mcrypt_encrypt/g;s/mysql_/mysqli_/g" ${OPENSHIFT_REPO_DIR}www/tz.php
read -p " Neu ban muon cai wordpress nhan [Enter] de tiep tuc. Neu muon cai ma nguon khac nhan Ctrl + C de huy bo"
cd ${OPENSHIFT_REPO_DIR}www
wget https://wordpress.org/latest.zip && unzip latest.zip && cp -r wordpress/* ${OPENSHIFT_REPO_DIR}www   && rm -rf wordpress && rm -rf latest.zip

gear stop
gear start

