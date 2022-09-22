# HomeAssistant hacs
> https://www.baidu.com/link?url=TFHGUAafl9G5OpN3F46KT-3Xat1uxuP3YjVrrHRNgLSGKbCpQSOtaTm19g1fV5Iw&wd=&eqid=f21369110005eeb900000005623eb9bd

#------------------------------------------------------------------
# 安装hacs
# 1.下载hacs1.6
> https://github.com/hacs/integration/releases/1.19.2
> https://github.com/hacs/integration/releases/download/1.19.2/hacs.zip

#解压
cd /root/docker/HomeAssistant
mkdir -p config/custom_components
mkdir -p config/www
unzip hacs.1.19.2.zip -d config/custom_components/hacs
chmod -R 777 config/custom_components/hacs
chmod -R 777 config/www

# 2.重启home assistant


# 3.安装hacs商店
> https://hacs.xyz/docs/configuration/basic
> 在此步之前先登录github https://github.com/
配置 -> 设备与服务 -> 集成 -> 添加集成 -> 搜索 hacs -> 按提示授予github权限


#----------------------------------
#手动下载资源
> 若通过hacs下载不成功，可在预览页面打开 github存储库，下载仓库文件，然后解压到对应目录
> /config/themes/ios-dark-mode/ios-dark-mode.yaml

cd /root/docker/HomeAssistant/config/themes
unzip lovelace-ios-dark-mode-theme-master.zip
mv lovelace-ios-dark-mode-theme-master ios-dark-mode
rm -f lovelace-ios-dark-mode-theme-master.zip



#------------------------------------------------------------------
# 换主题
HACS -> 前端 -> 浏览并下载存储库 -> 取消勾选 Lovelace -> 选中主题 安装

#安装主题后 添加配置
> config/configuration.yaml
frontend:
  themes: !include_dir_merge_named themes

#重启ha,点击左下角的头像进行主题更换




#------------------------------------------------------------------
# 卡片的安装使用
> https://www.bilibili.com/read/cv11827779







