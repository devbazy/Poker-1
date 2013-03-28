<?php
define('APP_ADMIN_ROOT', dirname(__FILE__));
include(APP_ADMIN_ROOT . '/middleware.php');

if(auth_check() == false){
    header('Location: login.php');
}

if($_POST){
    $consumer = $_SESSION['consumer'];
    $consumer_in_form = escape($_POST['consumer']);
    $origin_password = escape($_POST['origin_password']);
    $password = escape($_POST['password']);
    $re_password = escape($_POST['re_password']);
    $telephone = escape($_POST['telephone']);

    if($consumer != $consumer_in_form or $password!=$re_password){
        $smarty->assign('server_msg', 'Error');
    }else{
        $flag = update_consumer_password($consumer, $origin_password, $password, $telephone);
        if($flag){
            $smarty->assign('server_msg', '修改成功!');
        }else{
            $smarty->assign('server_msg', '原始密码错误!');
        }
    }
}

$role = cache_role();
$smarty->assign('role_id', $role['role_id']);
$smarty->assign('role_type', $role['role_type']);

$smarty->assign('consumer', $_SESSION['consumer']);
$smarty->display('admin/update.tpl');
?>
