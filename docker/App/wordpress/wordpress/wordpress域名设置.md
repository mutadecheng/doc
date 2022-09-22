
#----------------------------------------------
# nginx给wordpress反向代理
> https://blog.csdn.net/dante_003/article/details/54930925
> 若多级nginx转发，需在最后一级nginx配置中指定host 如 proxy_set_header Host clean.ms.lith.cloud:80

#1.配置nginx

listen 8;
server_name doc.sers.cloud sers.cloud;

location / { 

	#传递客户端ip	 
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header X-Real-Port $remote_port;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header Host $host:$server_port;

	proxy_pass http://localhost:2100;

	client_max_body_size 50000m;
	client_body_buffer_size 1024k;
}




#----------------------------------------------
# mysql修改域名
docker exec -it wordpress-mysql bash

mysql -u root -p123456

use wordpress;
update `wp_options` set option_value='http://doc.sers.cloud:6100' where option_name='siteurl' or  option_name='home';
-- update `wp_users` set user_url='http://doc.sers.cloud:6100';
exit
exit



#----------------------------------------------
# 不限制域名
> http://www.thefox.cn/wordpress-uses-multiple-domains.shtml

#(x.1)修改 /var/www/html/wp-config.php ，在define('WP_DEBUG', false); 后面添加下面内容
define('WP_SITEURL', ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' ? 'https://' :'http://') . $_SERVER['HTTP_HOST']   );
define('WP_HOME', ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' ? 'https://' :'http://') . $_SERVER['HTTP_HOST']   );


#(x.2)修改静态文件地址
> 在wordpress上传的图片插入文章里面，地址是固定的，还需要修改静态文件地址
define('WP_CONTENT_URL', '/wp-content');



