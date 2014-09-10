title: php-note
date: 2014-09-04 13:43:45
tags:
---

打印调试信息
error_log("userinfo", 3, "php_sql_err.log");

	$where['truename'] = array('like', '%'.trim($_POST['truename']).'%');
	$count     = $card_create_db->where($where)->count();
	$Page      = new Page($count, 15);
	$show      = $Page->show();
	$list      = $card_create_db->where($where)->limit($Page->firstRow . ',' . $Page->listRows)->select();

	$userinfo_db = M('Userinfo');
	$userinfo_where['wecha_id'] = array('in', $wecha_ids);
	$users                      = $userinfo_db->where($userinfo_where)->select();