sudo apt install samba
编辑 /etc/samba/smb.conf 配置
默认配置了打印机共享, 通常不需要, 可注释掉这部分内容。

#[printers]
#   comment = All Printers
#   browseable = no
#   path = /var/spool/samba
#   printable = yes
#   guest ok = no
#   read only = yes
#   create mask = 0700
#
## Windows clients look for this share name as a source of downloadable
## printer drivers
#[print$]
#   comment = Printer Drivers
#   path = /var/lib/samba/printers
#   browseable = yes
#   read only = yes
#   guest ok = no

添加自定义共享配置

	[dongrun]                                                      
		 path = /home/evatlsong/Project/dongrun                 
		 browsable = yes                                      
		 writeable = yes                                    
		 read only = no   

     sudo smbpasswd -a evatlsong
     sudo systemctl restart smbd
