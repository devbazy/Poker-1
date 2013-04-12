<?php

function get_url_domain(){
    $request_url = $_SERVER['REQUEST_URI'];
    $index = strpos($request_url, '/app/');
    return substr($request_url, 0, $index);
}

function escape($data){
    return mysql_real_escape_string(trim($data));
}

function translate_to_weekday($n){
    switch($n){
        case 1: return "一";
        case 2: return "二";
        case 3: return "三";
        case 4: return "四";
        case 5: return "五";
        case 6: return "六";
        case 7: return "日";
    }
}

function decode_shire_state($state=0){
    switch($state){
        case -1: return "拒绝维修";
        case  0: return "新单";
        case  1: return "维修中";
        case  2: return "维修完毕";
    }
}

function check_reporter($report_id, $reporter){
    $db = new DB;
    $db->connect();
    $db->query("SELECT wizard_id FROM wizard WHERE wizard_id='$report_id' AND wizard_name='$reporter'");
    $db->next_record();
    return $db->f('wizard_id')?True:False;
}

function shires_to_export($department, $from, $to){
    $date = date('Y/m/d');
    $sql = "SELECT * FROM shire,role WHERE shire.role_id=role.role_id "
         . "AND department='$department' AND ((report_time BETWEEN '$from' AND '$to') "
         . "OR (repair_time BETWEEN '$from' AND '$to')) ORDER BY shire_id;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'), 
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}

function admin_get_shires_count_with_assign_feedback($assign_feedback, $broken_class=NULL){
    if($assign_feedback){
        $sql = "SELECT COUNT(*) as c FROM shire WHERE state=0 AND role_id<>0 "
             . "AND assign_feedback NOT IN (-2,0) AND admin_permit=0";
    }else{
        $sql = "SELECT COUNT(*) as c FROM shire WHERE state=0 AND role_id=0 "
             . "AND admin_permit=0 ";
    }
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class';";
    }
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function admin_get_shires_with_assign_feedback($assign_feedback, $page, $broken_class=NULL){
    $limit = 20;
    $start = ($page-1)*$limit;
    if($assign_feedback){
        $sql = "SELECT * FROM shire WHERE state=0 AND role_id<>0 "
            . "AND assign_feedback NOT IN (-2,0) AND admin_permit=0 ";
    }else{
        $sql = "SELECT * FROM shire WHERE state=0 AND role_id=0 "
             . "AND admin_permit=0 ";
    }
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class' ";
    }
    $sql = $sql . "ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}

function admin_get_all_shires_count($broken_class=NULL){
    $sql = "SELECT COUNT(*) as c FROM shire ";
    if($broken_class){
        $sql = $sql . "WHERE broken_item_class='$broken_class';";
    }
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function admin_get_all_shires($page=1, $broken_class=NULL){
    $limit = 20;
    $start = ($page-1)*$limit;
    $sql = "SELECT * FROM shire LEFT JOIN role ON role.role_id=shire.role_id ";
    if($broken_class){
        $sql = $sql . "WHERE broken_item_class='$broken_class' ";
    }
    $sql = $sql . "ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'role_type' =>  $db->f('role_type'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}

function user_get_all_shires_count($role_id, $broken_class=NULL){
    $sql = "SELECT COUNT(*) as c FROM shire WHERE role_id=$role_id ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class';";
    }
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function user_get_all_shires($role_id, $page, $broken_class=NULL){
    $limit = 20;
    $start = ($page-1)*$limit;
    $sql = "SELECT * FROM shire, role WHERE role.role_id=shire.role_id AND shire.role_id=$role_id ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class' ";
    }
    $sql = $sql . "ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'role_type' =>  $db->f('role_type'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}

function user_get_shires_count_with_admin_feedback($role_id, $broken_class=NULL){
    $sql = "SELECT COUNT(*) as c FROM shire WHERE state IN (1,-1) AND "
         . "role_id=$role_id AND assign_feedback NOT IN (0,-1) ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class';";
    }
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function user_get_shires_with_admin_feedback($role_id, $page, $broken_class){
    $limit = 20;
    $start = ($page-1)*$limit;
    $sql = "SELECT * FROM shire WHERE state IN (1,-1) AND role_id=$role_id AND assign_feedback NOT IN (0,-1) ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class' ";
    }
    $sql = $sql . "ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}

function user_get_shires_count_with_repair_feedback($role_id, $broken_class=NULL){
    $sql = "SELECT COUNT(*) as c FROM shire WHERE state=1 AND "
         . "role_id=$role_id AND admin_permit=1 ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class';";
    }
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function user_get_shires_with_repair_feedback($role_id, $page, $broken_class){
    $limit = 20;
    $start = ($page-1)*$limit;
    $sql = "SELECT * FROM shire WHERE state=1 AND role_id=$role_id AND admin_permit=1 ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class' ";
    }
    $sql = $sql . "ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}

function user_get_shires_count($role_id, $broken_class=NULL){
    $sql = "SELECT COUNT(*) as c FROM shire WHERE state=0 AND "
         . "role_id=$role_id AND assign_feedback IN (-2, 0) ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class';";
    }
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function user_get_shires($role_id, $page, $broken_class){
    $limit = 20;
    $start = ($page-1)*$limit;
    $sql = "SELECT * FROM shire WHERE state=0 AND role_id=$role_id AND assign_feedback IN (-2, 0) ";
    if($broken_class){
        $sql = $sql . "AND broken_item_class='$broken_class' ";
    }
    $sql = $sql . "ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item_class' =>  $db->f('broken_item_class'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'role_id'   =>  $db->f('role_id'),
            'extra_data'    =>  $db->f('extra_data'),
            'assign_time'   =>  $db->f('assign_time'),
            'assign_feedback'   =>  $db->f('assign_feedback'),
            'assign_extra_data'   =>  $db->f('assign_extra_data'),
            'reject_reason' =>  $db->f('reject_reason'),
            'assign_feedback_time'  =>  $db->f('assign_feedback_time'),
            'request_days'  =>  $db->f('request_days'),
            'admin_permit'  =>  $db->f('admin_permit'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
            'auth_check'    =>  $db->f('auth_check'),
            'ip'    =>  $db->f('ip'),
        ));
    }
    return $shires;
}


function get_shire_count_not_refused(){
    $sql = "SELECT COUNT(*) as c FROM shire WHERE state<>-1 AND "
         . "admin_permit=1;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('c');
}

function get_shires_not_refused($page=1, $limit=20){
    $start = ($page-1)*$limit;
    $sql = "SELECT shire_id, reporter, report_id, report_time, contact_num, department, place, reason, detail, " 
         . "broken_item, filename, state, state_context, repair_time, feedback FROM shire ";
    $sql = $sql . "WHERE state<>-1 AND admin_permit=1 ORDER BY shire_id DESC LIMIT $start, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
        ));
    }
    return $shires;
}

function update_shire($reporter, $report_id, $report_time, $contact_num, $department, $place,
        $broken_item_class, $broken_item, $reason, $wish_time,$detail, $filename, $state, $state_context, 
        $repair_time, $feedback, $auth_check, $ip){
    if($reporter){
        $sql = "INSERT INTO shire(reporter, report_id, report_time, contact_num, department, "
             . " place, broken_item_class, broken_item, reason, wish_time, detail, filename, state, state_context, "
             . " repair_time, feedback, auth_check, ip) VALUES('$reporter', '$report_id', '$report_time',"
             . " '$contact_num', '$department', '$place', '$broken_item_class', '$broken_item', '$reason', '$wish_time',"
             . "'$detail', '$filename', $state, '$state_context', '$repair_time', '$feedback', $auth_check, '$ip');";

        $db = new DB;
        $db->connect();
        $db->query($sql);
        $db->query("SELECT max(shire_id) as c FROM shire WHERE report_id=$report_id");
        $db->next_record();
        return $db->f('c'); 
    } 
}

function change_shire_state($shire_id, $state, $state_context, $feedback){
    $db = new DB;
    $db->connect();
    $db->query("SELECT shire_id FROM shire WHERE shire_id=$shire_id");
    $db->next_record();
    if($db->f('shire_id')){
        $repair_time = date('Y/m/d');
        $db->query("UPDATE shire SET state=$state,state_context='$state_context',"
                  ."repair_time='$repair_time',feedback='$feedback' "
                  ."WHERE shire_id=$shire_id;");
    }else{
        return false;
    }
}

function do_user_feedback($shire_id, $feedback, $request_days, $assign_extra_data){
    $sql = "UPDATE shire SET assign_feedback=$feedback, request_days=$request_days, "
         . "assign_extra_data='$assign_extra_data' WHERE shire_id=$shire_id;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
}

function do_admin_reject($shire_id, $reject_reason){
    $sql = "UPDATE shire SET state=0, assign_feedback=-2, reject_reason='$reject_reason' "
         . "WHERE shire_id=$shire_id;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
}

function do_admin_permit($shire_id){
    $assign_feedback_time = date('Y/m/d');
    $sql = "UPDATE shire SET state=1, admin_permit=1, assign_feedback_time='$assign_feedback_time' "
         . "WHERE shire_id=$shire_id";
    $db = new DB;
    $db->connect();
    $db->query($sql);
}

function do_user_repair($shire_id){
    $sql = "UPDATE shire SET state=1 WHERE shire_id=$shire_id;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
}

function do_user_repair_feedback($shire_id, $feedback){
    $repair_time = date('Y/m/d');
    $sql = "UPDATE shire SET state=2, repair_time='$repair_time', feedback='$feedback' "
         . "WHERE shire_id=$shire_id;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
}

function get_shire_by_id($shire_id){
    $sql = "SELECT shire_id, reporter, report_id, report_time, contact_num, department, place, reason, detail, " 
         . "broken_item, filename, state, state_context, role_type, repair_time, feedback FROM shire,role ";
    $sql = $sql . "WHERE shire.role_id=role.role_id AND shire_id=$shire_id;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return Array(
       'shire_id'  =>  $db->f('shire_id'),
       'reporter'  =>  $db->f('reporter'),
       'report_id' =>  $db->f('report_id'),
       'report_time'   =>  $db->f('report_time'),
       'contact_num'   =>  $db->f('contact_num'),
       'department'    =>  $db->f('department'),
       'place' =>  $db->f('place'),
       'reason'    =>  $db->f('reason'),
       'wish_time' =>  $db->f('wish_time'),
       'detail'    =>  $db->f('detail'),
       'broken_item'   =>  $db->f('broken_item'),
       'filename'      =>  $db->f('filename'),
       'state' =>  $db->f('state'),
       'role_type'  =>  $db->f('role_type'),
       'decode_state'  =>  decode_shire_state($db->f('state')),
       'state_context' =>  $db->f('state_context'),
       'repair_time'   =>  $db->f('repair_time'),
       'feedback'  =>  $db->f('feedback'),
    );
}

function assign_shire_to_role($shire_id, $role_id, $extra_data){
    $assign_time = date('Y/m/d');
    $db = new DB;
    $db->connect();
    $db->query("UPDATE shire SET role_id=$role_id, extra_data='$extra_data', assign_time='$assign_time',assign_feedback=0 WHERE shire_id=$shire_id;");
    return true;
}

function consumer_check($consumer, $password){
    $sql = "SELECT consumer, password, role_id FROM barrack WHERE "
         . "consumer='$consumer' AND password='" . md5($password) . "';";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $db->next_record();
    return $db->f('role_id');
}

function translate_role_id($role_id){
    $db = new DB;
    $db->connect();
    $db->query("SELECT role_type FROM role WHERE role_id=$role_id");
    $db->next_record();
    return $db->f('role_type');
}

function get_role_types(){
    $db = new DB;
    $db->connect();
    $db->query("SELECT role_id, role_type FROM role WHERE role_type<>'管理员';");
    $role_types = Array();
    while($db->next_record()){
        array_push($role_types, Array(
            'role_id'   =>  $db->f('role_id'),
            'role_type' =>  $db->f('role_type')
        ));
    }
    return $role_types;
}

function get_all_role_types(){
    $db = new DB;
    $db->connect();
    $db->query("SELECT role_id, role_type FROM role;");
    $all_role_types = Array();
    while($db->next_record()){
        array_push($all_role_types, Array(
            'role_id'   =>  $db->f('role_id'),
            'role_type' =>  $db->f('role_type')
        ));
    }
    return $all_role_types;
}

function add_role_type($role_type){
    $db = new DB;
    $db->connect();
    $db->query("SELECT role_id FROM role WHERE role_type='$role_type';");
    $db->next_record();
    if($db->f('role_id')){
        return 0;
    }
    $db->query("INSERT INTO role(role_type) VALUES('$role_type');");
    return 1;
}

function del_role_type($role_id){
    $db = new DB;
    $db->connect();
    $db->query("SELECT consumer FROM barrack WHERE role_id=$role_id;");
    $db->next_record();
    if($db->f('consumer')){
        return 0;
    }
    $db->query("DELETE FROM role WHERE role_id=$role_id;");
    return 1;
}

function update_consumer_password($consumer, $origin_password, $password, $telephone){
    $db = new DB;
    $db->connect();
    $db->query("SELECT consumer FROM barrack WHERE consumer='$consumer' AND "
              ."password='" . md5($origin_password) . "';");
    $db->next_record();
    if($db->f('consumer')){
        $db->query("UPDATE barrack SET password='" . md5($password) . "' ,telephone='$telephone'WHERE "
                  ."consumer='$consumer';");
        return true;
    }else{
        return false;
    }
}

function add_new_consumer($consumer, $password, $role_id, $telephone){
    $db = new DB;
    $db->connect();
    $db->query("SELECT consumer FROM barrack WHERE consumer='$consumer';");
    $db->next_record();
    if($db->f('consumer')){
        return false;
    }else{
        $db->query("INSERT INTO barrack(consumer, password, role_id, telephone) VALUES('$consumer', "
                  ."'" . md5($password) . "', $role_id, $telephone);");
        return true;
    }
}

function find_shires($shire_id, $limit=20){
    $sql = "SELECT shire_id, reporter, report_id, report_time, contact_num, department, place, reason, detail, " . "broken_item, filename, state, state_context, repair_time, feedback FROM shire ";
    $sql = $sql . "WHERE state<>-1 AND role_id<>0 AND shire_id=$shire_id ORDER BY shire_id DESC LIMIT 0, $limit;";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    $shires = Array();
    while($db->next_record()){
        array_push($shires, Array(
            'shire_id'  =>  $db->f('shire_id'),
            'reporter'  =>  $db->f('reporter'),
            'report_id' =>  $db->f('report_id'),
            'report_time'   =>  $db->f('report_time'),
            'contact_num'   =>  $db->f('contact_num'),
            'department'    =>  $db->f('department'),
            'place' =>  $db->f('place'),
            'reason'    =>  $db->f('reason'),
            'wish_time' =>  $db->f('wish_time'),
            'detail'    =>  $db->f('detail'),
            'broken_item'   =>  $db->f('broken_item'),
            'filename'      =>  $db->f('filename'),
            'state' =>  $db->f('state'),
            'decode_state'  =>  decode_shire_state($db->f('state')),
            'state_context' =>  $db->f('state_context'),
            'repair_time'   =>  $db->f('repair_time'),
            'feedback'  =>  $db->f('feedback'),
        ));
    }
    return $shires;
}
?>
