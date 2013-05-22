<?php
define('ADMIN_AJAX_ROOT', dirname(__FILE__));
define('APP_ADMIN_ROOT', dirname(ADMIN_AJAX_ROOT));
define('APP_ROOT', dirname(APP_ADMIN_ROOT));
define('SMARTY_APP_ROOT', dirname(APP_ROOT));
define('SMARTY_LIB_ROOT', SMARTY_APP_ROOT . '/libs');
include(APP_ADMIN_ROOT . '/middleware.php');
include(ADMIN_AJAX_ROOT . '/helper.php');
include(ADMIN_AJAX_ROOT . '/helpfun.php');

if(auth_check() == false){
    return jsonize(Array(
        'r'     => 0,
        'msg'   => 'auth required!',
    ));
}
$role_id = 2;
$type = "freeze";
$shire_id = escape($_POST['shire_id']);
$state_context = escape($_POST['state_context']);

do_user_repair_freeze($shire_id, $state_context);
update_notice($role_id, $shire_id, $type);
return jsonize(Array(
    'r'     =>  1,
    'msg'   =>  'succed!',
));
?>
