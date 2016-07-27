---
title: apache2-web-server
date: 2015-08-26 22:53:55
tags: [apache, httpd]
---
ubuntu 15.04
apache version 2.4.10 
/etc/init.d/apache2
systemctl start apache2

ubuntu 16.04
第一步，首先是要打开apache的相关功能。

    sudo a2enmod rewrite #打开 url 重写 
    sudo a2enmod proxy 
    sudo a2enmod proxy_http 
    sudo a2enmod proxy_balancer

第二步，设置网站的配置文件，在 /etc/apache2/sites-available/ 目录下 新建文件 localhost.conf， 写入如下内容

    ServerName localhost
    ProxyPreserveHost On
    ProxyRequests Off
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    ProxyPass / http://localhost:8082/
    ProxyPassReverse / http://localhost:8082/

第三步，在/etc/apache2/sites-enabled/目录下把刚才建的文件做个软链接过来

    sudo ln -s ../sites-available/localhost.conf 

第四步，执行、启用这个站点

    sudo a2ensite localhost.conf
    sudo service apache2 reload

或者直接重启apache服务
sudo service apache2 restart
