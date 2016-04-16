


<html>
<head>
 
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".flip").click(function() {
			$(".panel").slideToggle("slow");
		});
	});
</script>
 <script type="text/javascript">
	$(document).ready(function() {
		$(".flip1").click(function() {
			$(".panel1").slideToggle("slow");
		});
	});
</script>
 
<style type="text/css">
div.panel,div.panel1
{
width:100%;
display:none;
}


p.flip,p.flip1
{
display: inline-block;
	cursor:pointer;
text-align:center;
}
div.bd {width: 35em;margin: 0 auto;font-family: Tahoma, Verdana, Arial, sans-serif;}
</style>
</head>
 
<body>
<div class="bd">
<h1>NGINX 1.9 + PHP 7.0 Cho Openshift ！</h1>
<p > Chào bạn. Cảm ơn các ban đã sự dụng bash shell cài đặt tự động  Nginx 1.9.X + PHP 7.0  của tôi</p> 
<br />Tập tin cấu hình của nginx  app-root/data/conf，tập tin cấu hình  PHP 7  app-root/data/etc, upload code lên  app-root/runtime/repo/www，<br />
Nginx update: cd /tmp && wget http://vandat6x.github.io/nginx-update.sh <br /> 
edit code qua vim hoặc các trình edit khác  sửa  NGINX_VERSION='1.9.13'  thành version mới nhất trên  trang chủ nginx. PHP 7.0 update: cd /tmp && http://vandat6x.github.io/php-update.sh <br >
<p>cd /tmp<br />wget --no-check-certificate http://vandat6x.github.io/php7.sh <br />chmod +x php7.sh && ./php7.sh<br/> Wordpress update: cd /tmp && http://vandat6x.github.io/wp-update.sh </p>
<a href="http://vuvdat.net/">My website</a> | contact me:<a href="mailto:help@vuvdat.net"></a>help@vuvdat.net  | <p class="flip1">server monitor</p> | <p class="flip" >phpinfo</p>
</div>
 
	 

		<br>
	<div class="panel">
<?php
phpinfo();
?>		
	</div>
</div>
		<br>
	<div class="panel1" >
	
	<iframe width="100%" height="2123px"  frameborder="0" src="tz.php"></iframe>
</div>
</body>
</html>
	</div>

 
	<br>
	<br>
	
	</div>
</body>
</html>
