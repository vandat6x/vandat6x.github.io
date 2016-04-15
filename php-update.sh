#!/bin/bash
unset TMOUT

read -p "Enter The PHP Update Version (e.g. 7.0.5) : " PHP_VERSION
PHP_VERSION='7.0.5'
cd /tmp
rm -rf *
wget -O libmcrypt-2.5.8.tar.gz https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/libmcrypt-2.5.8.tar.gz
tar xzf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j && make install
cd libltdl
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local --enable-ltdl-install
make -j && make install
cd ../..
wget -O mhash-0.9.9.9.tar.gz https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/mhash-0.9.9.9.tar.gz
tar zxvf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j && make install
cd ..
wget  --no-check-certificate -O re2c-0.13.7.5.tar.gz https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/re2c-0.13.7.5.tar.gz
tar xzf re2c-0.13.7.5.tar.gz
cd re2c-0.13.7.5
./configure --prefix=${OPENSHIFT_DATA_DIR}usr/local
make -j4 && make install
cd ..
wget -O mcrypt-2.6.8.tar.gz https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/mcrypt-2.6.8.tar.gz
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
cd /tmp
rm -rf *
gear stop
killall nginx
killall php-fpm
gear start

