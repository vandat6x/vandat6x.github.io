# nginx + php-fpm cho openshift
Hướng dẫn cài đặt
1. PHP5.6
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/php56.sh
chmod +x php56.sh
./php56.sh

2. PHP 7
cd /tmp
wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/php7.sh
chmod +x php7.sh
./php7.sh

update php
1. vào http://php.net/downloads.php xem phiên bản php mới nhất mà bạn cần update 
2. wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/php-update.sh
3. vim php-update.sh hoặc edit = các trình editor
4. sửa PHP_VERSION='7.0.5' thành phiên bản php mới hơn vd PHP_VERSION='7.0.6'
6. chmod +x php-update.sh
7. ./php-update.sh


update nginx
1. vào http://nginx.org/ xem phiên bản mới nhất trên trang chủ
2. wget --no-check-certificate https://raw.githubusercontent.com/vandat6x/nginx-php-fpm-openshift/master/nginx-update.sh
3. làm tương tự như update php

<h2> sau khi cài xong có 1 file có tên là tz.php file đó dùng để test các thông số </h2>


