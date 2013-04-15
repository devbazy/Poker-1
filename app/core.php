<?php
define('APP_ROOT', dirname(__FILE__));
define('SMARTY_APP_ROOT', dirname(APP_ROOT));
define('SMARTY_LIB_ROOT', SMARTY_APP_ROOT . '/libs');

require(SMARTY_LIB_ROOT . '/smarty.php');
require(SMARTY_LIB_ROOT . '/db.php');
require(APP_ROOT . '/utils/helper.php');

$smarty = new MySmarty;
$url_domain = get_url_domain();
$smarty->assign('domain', $url_domain);
$smarty->assign('public', $url_domain . '/static');
$smarty->assign('title', '哈工大威海后勤服务中心网上报修系统');
$weekday = translate_to_weekday(date('N'));
$header_date = date('Y年m月d日 星期' . $weekday);
$smarty->assign('header_date', $header_date);
?>
