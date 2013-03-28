<?php
include('core.php');
include('admin/j/helpfun.php');

if($_POST){
    $reporter = escape($_POST['reporter']);
    $report_id = escape($_POST['report_id']);
    $report_time = date('Y-m-d');
    $contact_num = escape($_POST['contact_num']);
    $department = escape($_POST['department_decode']);
    $place = escape($_POST['place']);
    $broken_item_class = escape($_POST['broken_item_class_decode']);
    $broken_item = escape($_POST['broken_item_decode']);
    $reason = escape($_POST['reason']);
    $wish_time = escape($_POST['wish_time']);
    $detail = escape($_POST['detail']);
    $filename = escape($_POST['filename']);
    $ip = $_SERVER['REMOTE_ADDR'];

    $auth_check = check_reporter($report_id, $reporter);
    if(!$auth_check){
        $smarty->assign('check_msg', '提交的工号/学生号与姓名不符.将由工作人员进行审核.');
    }
    $check = $check == True?1:0;
    
    if(!($reporter && $report_id && $reason)){
        $smarty->assign('server_error', 'error');
    }else{
        $shire_id = update_shire($reporter,$report_id,$report_time,$contact_num,$department,$place, $broken_item_class, $broken_item,$reason,$wish_time,$detail, $filename, 0,'','','', $check, $ip);   
        echo "$shire_id";
        update_notice(1, $shire_id,"new");
        $smarty->assign('server_msg', '申报成功!');
    }   
}

$smarty->display('update.tpl');
?>
