<?php
function update_notice($role_id, $shire_id, $type){
    $type_array = array('后勤' => array('后勤人员你好！有新的报修来了！','后勤人员你好！您分配的维修任务被被接收了。','后勤人员你好！您分配的维修任务被拒绝！','后勤人员你好！已经修好了。') ,
        '维修工' => array('维修人员你好！后勤分配来了新单了！','维修人员你好！后勤同意维修','维修人员你好！您的订单被驳回！') );
    if ($role_id == 1) {
        if ($type == 'new') {
            $event = $type_array['后勤'][0];
        }
        elseif ($type == 'permit') {
            $event = $type_array['后勤'][1];
        }
        elseif ($type == 'reject') {
            $event = $type_array['后勤'][2];
        }
    }
    else{
        if ($type == 'assign') {
            $event = $type_array['维修工'][0];
        }
        elseif ($type == 'permit') {
            $event = $type_array['维修工'][1];
        }
        elseif ($type == 'reject') {
            $event = $type_array['维修工'][2];
        }
    }
    $sql = "SELECT * FROM shire WHERE shire_id=$shire_id";
    $db = new DB;
    $db->connect();
    $db->query($sql);
    if($db->next_record()) {
        $message="报修人是：".$db->f('reporter')."；报修人联系电话是：".$db->f('contact_num')."；报修地点在：".$db->f('place')."；报修原因是：".$db->f('reason')."；报修分类为：".$db->f('broken_item_class')."；报修物品：".$db->f('broken_item')."。请登入系统查看详情！";
    }
    $event=$event.$message;
    if($shire_id){
        $sql = "INSERT INTO notice(id , role_id, shire_id, event) VALUES('','$role_id', '$shire_id', '$event');";
        $db->query($sql);
    }
}
function find_role_id($shire_id){
    if ($shire_id) {
        $db = new DB;
        $db->connect();
        $db->query("SELECT role_id as c FROM shire WHERE shire_id=$shire_id");
        $db->next_record();
        return $db->f('c');
    }
}
?>