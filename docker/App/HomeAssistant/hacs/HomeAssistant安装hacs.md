# HomeAssistant hacs
> https://www.baidu.com/link?url=TFHGUAafl9G5OpN3F46KT-3Xat1uxuP3YjVrrHRNgLSGKbCpQSOtaTm19g1fV5Iw&wd=&eqid=f21369110005eeb900000005623eb9bd

#------------------------------------------------------------------
# ��װhacs
# 1.����hacs1.6
> https://github.com/hacs/integration/releases/1.19.2
> https://github.com/hacs/integration/releases/download/1.19.2/hacs.zip

#��ѹ
cd /root/docker/HomeAssistant
mkdir -p config/custom_components
mkdir -p config/www
unzip hacs.1.19.2.zip -d config/custom_components/hacs
chmod -R 777 config/custom_components/hacs
chmod -R 777 config/www

# 2.����home assistant


# 3.��װhacs�̵�
> https://hacs.xyz/docs/configuration/basic
> �ڴ˲�֮ǰ�ȵ�¼github https://github.com/
���� -> �豸����� -> ���� -> ��Ӽ��� -> ���� hacs -> ����ʾ����githubȨ��


#----------------------------------
#�ֶ�������Դ
> ��ͨ��hacs���ز��ɹ�������Ԥ��ҳ��� github�洢�⣬���زֿ��ļ���Ȼ���ѹ����ӦĿ¼
> /config/themes/ios-dark-mode/ios-dark-mode.yaml

cd /root/docker/HomeAssistant/config/themes
unzip lovelace-ios-dark-mode-theme-master.zip
mv lovelace-ios-dark-mode-theme-master ios-dark-mode
rm -f lovelace-ios-dark-mode-theme-master.zip



#------------------------------------------------------------------
# ������
HACS -> ǰ�� -> ��������ش洢�� -> ȡ����ѡ Lovelace -> ѡ������ ��װ

#��װ����� �������
> config/configuration.yaml
frontend:
  themes: !include_dir_merge_named themes

#����ha,������½ǵ�ͷ������������




#------------------------------------------------------------------
# ��Ƭ�İ�װʹ��
> https://www.bilibili.com/read/cv11827779







