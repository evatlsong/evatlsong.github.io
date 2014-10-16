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

imp userid=ltwuliu/LTWULIU@huictrip file=D:\databackup\huitrip20140813.dmp full=y
exp userid=sunztravelweb/huictrip@goutrip file=E:\data\goutrip20140805.dmp 


When making some backup tasks (import or Export) on oracle 10g, 11g (for example), you can get a message error:
ORA-20446: The owner of the job is not registered ORA-06512: at “SYSMAN.MGMT_JOBS”…

Solution
Open CMD
C:\>Set oracle_sid= SID_OF_THE_DATABASE
C:\>sqlplus
username: SYSMAN
password: ****
SQL>execute MGMT_USER.MAKE_EM_USER(‘USERNAME’);

USERNAME – the user that you use to connect to enterprise managert
don’t copy/past the command, sometimes they are some hidden characters



11G中有个新特性，当表无数据时，不分配segment，以节省空间
　　解决方法：
　　1、insert一行，再rollback就产生segment了。
　　该方法是在在空表中插入数据，再删除，则产生segment。导出时则可导出空表。
　　2、设置deferred_segment_creation 参数
show parameter deferred_segment_creation

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
deferred_segment_creation            boolean     TRUE
SQL> alter system set deferred_segment_creation=false;

系统已更改。

SQL> show parameter deferred_segment_creation

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
deferred_segment_creation            boolean     FALSE
 
 3、用以下这句查找空表并分配空间
　　select 'alter table '||table_name||' allocate extent;' from user_tables where num_rows=0;
　　把SQL查询的结果导出，然后执行导出的语句，强行为表分配空间修改segment值，然后再导出即可导出空表了。




drop user sunztravelweb cascade;

CREATE TEMPORARY TABLESPACE USER_TEMP
TEMPFILE 'D:\app\Administrator\product\11.1.0\db_1\oradata\USER_TEMP.dbf'
SIZE 32M
AUTOEXTEND ON
NEXT 32M MAXSIZE 2048M
EXTENT MANAGEMENT LOCAL;



CREATE TABLESPACE USER_DATA
LOGGING
DATAFILE 'D:\app\Administrator\product\11.1.0\db_1\oradata\USER_DATA.DBF'
SIZE 32M
AUTOEXTEND ON
NEXT 32M MAXSIZE 2048M
EXTENT MANAGEMENT LOCAL;



CREATE USER sunztravelweb IDENTIFIED BY huictrip
DEFAULT TABLESPACE USER_DATA
TEMPORARY TABLESPACE USER_TEMP;


grant connect,resource,dba to sunztravelweb;




imp userid=sunztravelweb/huictrip@localhost/goutrip file=E:\data\goutrip20140708.dmp full=y