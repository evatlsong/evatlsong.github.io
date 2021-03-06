---
title: apache-php-tomcat-integration
date: 2014-08-29 10:02:51
tags: [apache,tomat,php,tomcat]
---

测试时可以修改hosts

	127.0.0.1 www.goutrip.com
	127.0.0.1 goutrip.com

## <a name="TOC">Table of Contents</a>

*   [Windows](#windows)
    *   [版本](#version)
    *   [安装apache](#install-apache)
    *   [安装tomcat](#install-tomcat)
    *   [安装php](#install-php)
    *   [安装mysql](#install-mysql)
    *   [整合apache tomcat](#integrate-apache-tomcat)
        *   [apache配置](#config-apache)
        *   [tomcat配置](#config-tomcat)
    *   [整合apache php](#integrate-apache-php)
    *   [整合php mysql](#integrate-php-mysql)
* [Linux]()


## <a id="windows">Windows</a>

### <a id="version">版本</a>

	httpd-2.2.25-win32-x86-openssl-0.9.8y.msi
	apache-tomcat-7.0.55-windows-x64.zip
	php-5.2.13-Win32.zip
	mysql-5.5.39-winx64.zip

### <a id="install-apache">安装apache</a>

httpd.conf

	<Directory />
	    Options FollowSymLinks
	    AllowOverride None
	#    Order deny,allow
	#    Deny from all
	</Directory>


### <a id="install-tomcat">安装tomcat</a>
### <a id="install-php">安装php</a>
解压到目录 设置 path 环境变量

	D:\php5

加载模块报错：

有时启动Apache的时候会提示“找不到指定模块”的错误，是因为没有指定这些模块文件的位置，定位关键字“extension_dir”，修改Windows下为你的PHP模块的目录。

	extession_dir = "D:\PHP\ext"

或者添加 path 环境变量

	D:\php\ext

### <a id="install-mysql">安装mysql</a>
解压到目录
添加到path环境变量

	E:\Program\mysql-5.5.39-winx64\bin

启动服务

	mysqld --console

关闭服务

	mysqladmin -u root -p shutdown

连接到数据库

	mysql -u root -p



进行初始配置 详见mysql-usage.md

### <a id="integrate-apache-tomcat">整合apache tomcat</a>

有三种方法

1. mod_jk.so
2. ajp代理

以下采用ajp代理方式
#### <a id="config-apache">apache配置</a>
httpd.conf

	LoadModule proxy_module modules/mod_proxy.so
	LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
	LoadModule proxy_balancer_module modules/mod_proxy_balancer.so

	# Virtual hosts
	Include conf/extra/httpd-vhosts.conf

	#
	# DirectoryIndex: sets the file that Apache will serve if a directory
	# is requested.
	#
	<IfModule dir_module>
	    DirectoryIndex index.html index.jsp index.php
	</IfModule>

extra/httpd-vhosts.conf

	<VirtualHost *:80>
		ServerName www.goutrip.com
		ServerAlias goutrip.com
		ProxyPreserveHost on
		ProxyRequests Off
		<proxy balancer://goutrip>
			BalancerMember ajp://localhost:8009 loadfactor=1 route=jvm1
			BalancerMember ajp://localhost:8010 loadfactor=1 route=jvm2
			BalancerMember ajp://localhost:8012 loadfactor=1 route=jvm3
		</proxy>
		ProxyPass / balancer://goutrip/ lbmethod=byrequests stickysession=JSESSIONID nofailover=on
		ProxyPassReverse / balancer://goutrip/
		ErrorLog "logs/goutrip.com-error.log"
		CustomLog "logs/goutrip.com-access.log" common
	</VirtualHost>

	<VirtualHost *:80>
		DocumentRoot "D:/website/g.goutrip.com"
		ServerName www.g.goutrip.com
		ServerAlias g.goutrip.com
		ErrorLog "logs/g.goutrip.com-error.log"
		CustomLog "logs/g.goutrip.com-access.log" common
	</VirtualHost>

以上也配置了负载均衡

#### <a id="config-tomcat">tomcat配置</a>

server.xml

	<Engine name="Standalone" defaultHost="localhost" jvmRoute="jvm1">

修改端口

	<Server port="8005" shutdown="SHUTDOWN">
	<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />

### <a id="integrate-apache-php">整合apache php</a>
apache httpd.conf

	LoadModule php5_module "D:/php5/php5apache2_2.dll"
	phpinidir "D:/php5"

	<IfModule mime_module>
	AddType application/x-httpd-php .php .html  #也可分多行写
	</IfModule>

	#
	# DirectoryIndex: sets the file that Apache will serve if a directory
	# is requested.
	#
	<IfModule dir_module>
	    DirectoryIndex index.html index.jsp index.php
	</IfModule>

修改后重启apache

### <a id="integrate-php-mysql">整合php mysql</a>
php.ini

	extension=php_mysql.dll


修改后重启apache
