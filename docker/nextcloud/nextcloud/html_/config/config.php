<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 => 
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
  'instanceid' => 'ocy8fq2etnuu',
  'passwordsalt' => 'S5XvgsS43HHUE/HM/1JJLzMAWT4JCk',
  'secret' => '5ZL8W5rtE1HJYYwiZKSzWhAupraR0l92GabInz2hnoW1RGEp',
  'trusted_domains' => 
  array (
    0 => 'pan.sers.cloud:6106',
  ),
  'trusted_proxies' => 
  array (
    0 => '10.0.2.2',
    1 => '172.17.0.7',
  ),
  'overwritehost' => 'pan.sers.cloud:6106',
  'overwriteprotocol' => 'https',
  //'overwritecondaddr' => '^(172|10)\.[0-9]+\.[0-9]+\.[0-9]+$', 
  'allow_local_remote_servers' => true,
  'datadirectory' => '/var/www/html/data',
  'check_data_directory_permissions' => false,
  'dbtype' => 'mysql',
  'version' => '20.0.5.2',
  'overwrite.cli.url' => 'http://localhost:6190',
  'dbname' => 'nextcloud',
  'dbhost' => 'mysql:3306',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'mysql.utf8mb4' => true,
  'dbuser' => 'oc_lith',
  'dbpassword' => 'VmncckKRa/YOt+fOSLML8kwnEgA6YN',
  'installed' => true,
  'app_install_overwrite' => 
  array (
    0 => 'mindmap_app',
    1 => 'workin2gether',
    2 => 'files_clipboard',
    3 => 'defaultgroup',
  ),
  'mail_from_address' => 'sersms_sender',
  'mail_smtpmode' => 'smtp',
  'mail_sendmailmode' => 'smtp',
  'mail_domain' => '163.com',
  'mail_smtphost' => 'smtp.163.com',
  'mail_smtpauthtype' => 'LOGIN',
  'mail_smtpauth' => 1,
  'mail_smtpname' => 'sersms_sender',
  'mail_smtppassword' => 'asfasgwe123g',
  'maintenance' => false,
);
