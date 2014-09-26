title: oracle-useage
date: 2014-09-04 11:40:08
tags:
---
## windows
sqlplus 连接
sqlplus username/password@database;
查询
select * from username.table t where t.id=1;

表名前要加用户名

查询结果保存到文本文件

	spool abc.txt;
	select * from wap_subscribe;
	spool off;

保存的只是输出到屏幕的内容


设置屏幕输出大小 解决显示不全问题

	set long 40000;
