<?php
define('ADMIN_AJAX_ROOT', dirname(__FILE__));
define('APP_ADMIN_ROOT', dirname(ADMIN_AJAX_ROOT));
define('APP_ROOT', dirname(APP_ADMIN_ROOT));
define('SMARTY_APP_ROOT', dirname(APP_ROOT));
define('SMARTY_LIB_ROOT', SMARTY_APP_ROOT . '/libs');
include(ADMIN_AJAX_ROOT . '/helper.php');
include(APP_ADMIN_ROOT . '/middleware.php');

if(auth_check() == false){
    return jsonize(Array(
        'r'     => 0,
        'msg'   => 'auth required!',
    ));
}

$shire_id = escape($_POST['shire_id']);
$type = escape($_POST['type']);

if($type == 'repair'){
    do_user_repair($shire_id);
}elseif($type == 'feedback'){
    $feedback = escape($_POST['feedback']);
    do_user_repair_feedback($shire_id, $feedback);
}elseif ($type == 'feed') {
	$feedback = escape($_POST['feedback']);
	do_user_repair_feed($shire_id, $feedback);
}

return jsonize(Array(
    'r'     =>  1,
    'msg'   =>  'succed!',
));
?>
