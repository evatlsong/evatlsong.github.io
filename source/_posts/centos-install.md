title: centos-install
date: 2014-09-10 12:30:19
tags:
---
# 问题
##安装问题
服务器安装最新版本centos7版本，进入光驱系统安装界面，出现一个问题：

1. 服务器直接连接宽屏显示器，会出现屏幕是倾斜状态；
2. 通过远控卡访问服务器安装操作系统，会出现屏幕超出显示范围

解决方法：

选择 `Troubleshooting` -> `Install Centos 7 in basic graphics mode`

## centos 下怎样从root切换到普通用户
su 普通用户名

# ssh设置
## 设置ssh
	ssh-keygen ## 生成默认名字的公钥私钥对
	ssh-keygen -f ~/.ssh/<filename> ## 生成指定名字的公钥私钥对
	ssh-copy-id -i .ssh/<filename>.pub <user>@<server> ## 拷贝公钥到<user>用户 ~/.ssh/authorized_keys 文件中

	ssh <user>@<server> ## 直接访问
	
## 别名访问
	~/.ssh/config
	host bj
	  user git
	  hostname bj.ossxp.com
	  port 22
	  identityfile ~/.ssh/<filename>

## 遇到问题
公钥没有拷贝到相关用户的家目录 报错为 `Server refused our key`
`chmod 600 ~/.ssh/authorized_keys` 去掉其他用户的权限
`puttygen.exe` 保存到文件中的公钥 有换行 不能直接用

# vnc设置

## 一、安装 VNC
　　首先检查一下本机是否安装了 VNC，默认情况下，CentOS 7.0 是没有安装的。
　　检查是否安装，输入：

	[root@localhost ~]# rpm -q vnc vnc-server
　　得到：

	package vnc is not installed

	package vnc-server is not installed

　　提示没有安装，那么就开始安装，输入：

	[root@localhost ~]# yum install vnc vnc-server
　　注：如果是 Ubuntu 则输入：

	[root@localhost ~]# apt-get install vnc vnc-server
　　在一串指令提示后，会让你确认一些选项，输入两次 "Y" 并确认，稍作等待，提示 "Complete!" 即完成安装。
## 二、设置 VNC 密码
　　启动 VNC，输入：

	[root@localhost ~]# vncserver
　　此时会提示你输入密码，因为是第一次配置。重复输入两次即可。
## 三、配置桌面类型 (可略过)
　　设置一下远程桌面使用那个类型的桌面，分辨率多少等等。输入：

	[root@localhost ~]# vi ~/.vnc/xstartup
　　得到：
	#!/bin/sh
	
	vncconfig -iconic &
	unset SESSION_MANAGER
	unset DBUS_SESSION_BUS_ADDRESS
	OS=`uname -s`
	if
	[ $OS = 
	'Linux'
	]; then
	  
	case
	"$WINDOWMANAGER"
	in
	    
	*gnome*)
	      
	if
	[ -e /etc/SuSE-release ]; then
	        
	PATH=$PATH:/opt/gnome/bin
	        
	export PATH
	      
	fi
	      
	;;
	  
	esac
	fi
	if
	[ -x /etc/X11/xinit/xinitrc ]; then
	  
	exec /etc/X11/xinit/xinitrc
	fi
	if
	[ -f /etc/X11/xinit/xinitrc ]; then
	  
	exec sh /etc/X11/xinit/xinitrc
	fi
	[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
	xsetroot -solid grey
	xterm -geometry 80x24+10+10 -ls -title 
	"$VNCDESKTOP Desktop"
	&
	twm &
　　一般情况下，我们使用的 Linux 桌面都是 "Gnome" 桌面，故配置成这个桌面比较习惯。
　　按 "i" 键进入编辑状态，主要修改最后两行。改为：

	# xterm -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
	# twm &
	gnome-session &
　　一看便知，将配置文件的最后两行注释掉，并且加入了一行代码，表明使用的是 "Gnome" 桌面。
## 四、配置登录帐号、桌面分辨率、连接方式 (可略过)
　　输入：

	[root@localhost ~]# vi /etc/sysconfig/vncservers
　　出现如下提示：

	# The VNCSERVERS variable is a list of display:user pairs.
	#
	# Uncomment the lines below to start a VNC server on display :2
	# as my 'myusername' (adjust this to your own).  You will also
	# need to set a VNC password; run 'man vncpasswd' to see how
	# to do that.
	#
	# DO NOT RUN THIS SERVICE if your local area network is
	# untrusted!  For a secure way of using VNC, see this URL:
	# http://kbase.redhat.com/faq/docs/DOC-7028
	# Use "-nolisten tcp" to prevent X connections to your VNC server via TCP.
	# Use "-localhost" to prevent remote VNC clients connecting except when
	# doing so through a secure tunnel.  See the "-via" option in the
	# `man vncviewer' manual page.
	
	# VNCSERVERS="2:myusername"
	# VNCSERVERARGS[2]="-geometry 800x600 -nolisten tcp -localhost"
　　重点编辑最后两行，将这两行注释去掉，得到：

	VNCSERVERS="1:root"
	VNCSERVERARGS[1]="-geometry 1024x768"
　　这里是只有一个帐号登录，设置分辨率为1024*768，如果你有多个帐号，则按照下面格式配置。

	VNCSERVERS="1:user1 2:user2 3:user3"
	VNCSERVERARGS[1]="-geometry 1024×768"
	VNCSERVERARGS[2]="-geometry 1024×768"
	VNCSERVERARGS[3]="-geometry 800×600 -depth 24 -nolisten tcp -nohttpd -localhost"
　　解释一下这个文件：

	VNCSERVERS 这一行是配置在系统启动时启动几个 VNC server，上面的例子里运行了三个 VNC server，其中 user1 在 display :1，user2 在 display :2，user3 在 display :3。
	
	VNCSERVERARGS 这三行，分别为 VNC server 1, 2, 3 配置启动参数，上面的例子里对 user1 和 user2 使用屏幕分辨率 1024×768，对 user3 使用 800×600,24 色，不支持 tcp，不支持 http 连接，只能在本地测试访问。

　　注释：在启动 VNCserver 时，你也可以为 server 指定一个 display 参数。你可以把 display 理解为一个桌面，每个用户都可以有自己的桌面。VNC 客户端在连接时，可以指定连接到哪个桌面上。在系统中，display 号不能重复，也就是说，如果有用户已经建立了名为 ":1" 的 display，另外一个用户就不能再使用 ":1" 了，他可以使用 ":2"。

　　指定 display 号码的启动 VNC server 的命令是:

	vncserver:1
## 五、配置防火墙，允许 VNC 连接
　　VNC server 监听的端口从 5900 开始，display:1 的监听 5901，display:2 监听 5902，以此类推。CentOS 的防火墙缺省是不允许连接这些端口的，所以需要使用下面的步骤打开防火墙（需要 root 权限)：
　　输入编辑：

	[root@localhost ~]# vi /etc/sysconfig/iptables
　　得到：

	# Firewall configuration written by system-config-firewall
	# Manual customization of this file is not recommended.
	*filter
	:INPUT ACCEPT [0:0]
	:FORWARD ACCEPT [0:0]
	:OUTPUT ACCEPT [0:0]
	-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	-A INPUT -p icmp -j ACCEPT
	-A INPUT -i lo -j ACCEPT
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
	-A INPUT -j REJECT --reject-with icmp-host-prohibited
	-A FORWARD -j REJECT --reject-with icmp-host-prohibited
	COMMIT
　　上面我们只添加了一个 root 帐号和桌面 1，所以这里按照上面的规则，添加一个 "5901" 端口号即可。

	# Firewall configuration written by system-config-firewall
	# Manual customization of this file is not recommended.
	*filter
	:INPUT ACCEPT [0:0]
	:FORWARD ACCEPT [0:0]
	:OUTPUT ACCEPT [0:0]
	-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	-A INPUT -p icmp -j ACCEPT
	-A INPUT -i lo -j ACCEPT
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 5901 -j ACCEPT
	-A INPUT -j REJECT --reject-with icmp-host-prohibited
	-A FORWARD -j REJECT --reject-with icmp-host-prohibited
	COMMIT
　　即添加了上述代码的第 11 行。
## 六、重启防火墙
　　配置就算完毕了，需要重启一下防火墙才能使最后那个端口号的配置正常。

	[root@localhost ~]# /sbin/service iptables restart
	iptables：清除防火墙规则：[确定]
	iptables：将链设置为政策 ACCEPT：filter [确定]
	iptables：正在卸载模块：[确定]
	iptables：应用防火墙规则：[确定]
　　现在重启防火墙完毕后，你就可以使用 VNC 客户端连接了，连接时候必须注意主机 IP 地址后面必须加桌面号，例如这样连接：

	192.168.1.2:1	

　　跟输入端口号是一样的，但是这里是桌面号，记住。
## 七、设置 VNC 自动启动
　　虽然上面配置是可以使用了，但是你一旦重启服务器后，VNC 的服务又会停止，得手动来启，不方便，虽说服务器不能老是启动，但是重启的时候还是有的，为了方便，你需要将 VNC 服务设置为自动自动。
　　方法很多，你可以在图形化的界面下打开服务窗口，然后将 VNC 服务设为自动。既然这里都是在用终端下的命令行形式，就继续沿用这个方式吧。

	[root@localhost ~]# chkconfig vncserver on


#tomcat
pscp -r -v tomcat.tar.gz root@192.168.1.217:/usr/local
tar -xzf /usr/local/tomcat.tar.gz

svnadmin dump Repositories\goutrip > svndata\goutrip.dump
svnadmin load svndata/goutrip < goutrip.dump

ps -aux|grep svnserve
kill -9 id
svnserve -d -r /home/goutrip/svndata
最后不要加正斜杠

可能用 systemctl enable svnservice.service 开启了服务 重启后svn又无法启动
解决办法 killall svnserve

