<?php
define('APP_ADMIN_ROOT', dirname(__FILE__));
include(APP_ADMIN_ROOT . '/middleware.php');

if(auth_check() == false){
    header('Location: login.php');
}

if($_POST){
    $role_id = escape($_POST['role_type']);
    $consumer = escape($_POST['consumer']);
    $password = escape($_POST['password']);
    $re_password = escape($_POST['re_password']);
    $telephone = escape($_POST['telephone']);

    if($password != $re_password){
        $smarty->assign('server_msg', '两次密码不一致!');
    }else{
        $flag = add_new_consumer($consumer, $password, $role_id, $telephone);
        if($flag){
            $smarty->assign('server_msg', '添加成功!');
        }else{
            $smarty->assign('server_msg', '用户已存在!');
        }
    }
}

$role = cache_role();
$smarty->assign('role_id', $role['role_id']);
$smarty->assign('role_type', $role['role_type']);


$all_role_types = get_all_role_types();
$smarty->assign('roles', $all_role_types);
$smarty->display('admin/account.tpl');
?>
