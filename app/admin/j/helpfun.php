<?php
function update_notice($role_id, $shire_id, $type){
    $type_array = array('后勤' => array('有新单！','维修分配被接收。','维修分配被拒绝！','已经修好了。') ,
        '维修工' => array('有新单！','同意维修','订单被驳回！') );
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
    if($shire_id){
        $sql = "INSERT INTO notice(id , role_id, shire_id, event) VALUES('','$role_id', '$shire_id', '$event');";
        $db = new DB;
        $db->connect();
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