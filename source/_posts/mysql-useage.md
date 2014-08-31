title: mysql-useage
date: 2014-08-27 16:27:07
tags:
---

## 安装
### 免安装版
下载 MySQL Community Edition 此为社区版 （MySQL Enterprise Edition 为商业授权版）

#### Securing the Initial MySQL Accounts [reference](http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html)

For Windows, do this:

	shell> mysql -u root
	mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpwd');
	mysql> SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('newpwd');
	mysql> SET PASSWORD FOR 'root'@'::1' = PASSWORD('newpwd');
	mysql> SET PASSWORD FOR 'root'@'%' = PASSWORD('newpwd');
The last statement is unnecessary if the mysql.user table has no root account with a host value of %.

For Unix, do this:

	shell> mysql -u root
	mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpwd');
	mysql> SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('newpwd');
	mysql> SET PASSWORD FOR 'root'@'::1' = PASSWORD('newpwd');
	mysql> SET PASSWORD FOR 'root'@'host_name' = PASSWORD('newpwd');

### After connecting to the server as root, you can add new accounts. The following statements use GRANT to set up four new accounts:

	mysql> CREATE USER 'monty'@'localhost' IDENTIFIED BY 'some_pass';
	mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty'@'localhost'
	    ->     WITH GRANT OPTION;
	mysql> CREATE USER 'monty'@'%' IDENTIFIED BY 'some_pass';
	mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty'@'%'
	    ->     WITH GRANT OPTION;
	mysql> CREATE USER 'admin'@'localhost';
	mysql> GRANT RELOAD,PROCESS ON *.* TO 'admin'@'localhost';
	mysql> CREATE USER 'dummy'@'localhost';
The accounts created by these statements have the following properties:

*Two of the accounts have a user name of monty and a password of some_pass. Both accounts are superuser accounts with full privileges to do anything. The 'monty'@'localhost' account can be used only when connecting from the local host. The 'monty'@'%' account uses the '%' wildcard for the host part, so it can be used to connect from any host.

*It is necessary to have both accounts for monty to be able to connect from anywhere as monty. Without the localhost account, the anonymous-user account for localhost that is created by mysql_install_db would take precedence when monty connects from the local host. As a result, monty would be treated as an anonymous user. The reason for this is that the anonymous-user account has a more specific Host column value than the 'monty'@'%' account and thus comes earlier in the user table sort order. (user table sorting is discussed in Section 6.2.4, “Access Control, Stage 1: Connection Verification”.)

The 'admin'@'localhost' account has no password. This account can be used only by admin to connect from the local host. It is granted the RELOAD and PROCESS administrative privileges. These privileges enable the admin user to execute the mysqladmin reload, mysqladmin refresh, and mysqladmin flush-xxx commands, as well as mysqladmin processlist . No privileges are granted for accessing any databases. You could add such privileges later by issuing other GRANT statements.

The 'dummy'@'localhost' account has no password. This account can be used only to connect from the local host. No privileges are granted. It is assumed that you will grant specific privileges to the account later.

### create database
	create database goods default character set utf8 collate utf8_general_ci;
### import sql file
	mysql -u root -p goods < goods_version1.2.sql;
加上-h参数指定主机时 sql文件要用全限定名称

## 配置
my.ini

	[mysql]
	default-character-set=utf8
	# character-set-client=utf8
	# character-set-connection=utf8
	[mysqld]
	character-set-server=utf8

	port = 3306
	server_id = mysqld