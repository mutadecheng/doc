#------------------------------------------------
# 主题
Ignite  
	Layout		: Left sidebar
	#Background	: #1e73be

#------------------------------------------------
# 额外CSS:
body{
  font-family: Courier New;
}


#------------------------------------------------
# markdown插件
WP Githuber MD

# 关闭wordpress智慧型引号功能
> https://www.laozuo.org/655.html
安装插件Quotmarks Replacer并启用


‘’  替换为 '
“”  替换为 "



#------------------------------------------------
# wordpress 打开卡在1.gravatar.com
> https://www.cnblogs.com/sdx0629/p/5327755.html

#修改主题文件夹中的文件functions.php,在任意位置加入如下代码:

function get_ssl_avatar($avatar) {
   $avatar = preg_replace('/.*/avatar/(.*)?s=([d]+)&.*/','<img class="avatar avatar-$2" src="https://secure.gravatar.com/avatar/$1?s=$2" alt="" width="$2" height="$2" />',$avatar);
   return $avatar;
}
add_filter('get_avatar', 'get_ssl_avatar');

#------------------------------------------------
# 禁止请求fonts.googleapis
> 安装如下插件并启用
Disable/Remove Google Fonts


#------------------------------------------------
# html5 audio player
> 安装如下插件并启用
Html5 Audio Player


#------------------------------------------------
# 修改wordpress文件上传的大小限制
> https://www.xuewangzhan.net/wpbbs/12228.html
> 修改(或创建)html/.htaccess 文件添加如下内容
php_value upload_max_filesize 64M
php_value post_max_size 64M
php_value max_execution_time 300
php_value max_input_time 300
