#!/bin/bash
unset TMOUT
# Begin update

echo "===================================================="
echo "=  NGINX 1.9 update                                ="
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
cp ${OPENSHIFT_DATA_DIR}conf/nginx.conf ${OPENSHIFT_DATA_DIR}conf/nginx.conf.bak
read -p "Nhap phien ban nginx (v.d 1.9.13) : " NGINX_VERSION
cd $OPENSHIFT_TMP_DIR
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar xzf nginx-${NGINX_VERSION}.tar.gz
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
#wget http://exim.mirror.fr/pcre/pcre-8.38.tar.gz
tar xzf pcre-8.38.tar.gz
git clone https://github.com/FRiCKLE/ngx_cache_purge.git
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module.git
cd ${OPENSHIFT_TMP_DIR}nginx-${NGINX_VERSION}
./configure --prefix=$OPENSHIFT_DATA_DIR --add-module=${OPENSHIFT_TMP_DIR}ngx_http_substitutions_filter_module --add-module=${OPENSHIFT_TMP_DIR}ngx_cache_purge --with-pcre=${OPENSHIFT_TMP_DIR}pcre-8.38 --with-pcre-jit --with-threads --with-http_realip_module --with-http_sub_module --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_geoip_module --with-http_secure_link_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module
make -j4 && make install
cp ${OPENSHIFT_DATA_DIR}conf/nginx.conf.bak ${OPENSHIFT_DATA_DIR}conf/nginx.conf
cd /tmp
rm -rf *
${OPENSHIFT_DATA_DIR}sbin/nginx -s reload
killall php-fpm
killall nginx
${OPENSHIFT_DATA_DIR}sbin/nginx
${OPENSHIFT_DATA_DIR}sbin/php-fpm

