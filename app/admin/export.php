<?php
define('APP_ADMIN_ROOT', dirname(__FILE__));
include(APP_ADMIN_ROOT . '/middleware.php');

$role = cache_role();
if(auth_check() == false){
    header('Location: login.php');
}

if($_POST && $_POST['department']){
    $department = escape($_POST['department']);
    $from = escape($_POST['from']);
    $to = escape($_POST['to']);
    $shires = shires_to_export($department, $from, $to);
    if($shires){

        include(SMARTY_LIB_ROOT . '/PHPExcel.php');
        include(SMARTY_LIB_ROOT . '/PHPExcel/IOFactory.php');
        $objPHPExcel = new PHPExcel();
        $objPHPExcel->getActiveSheet()->getDefaultColumnDimension()->setWidth(30);
        $objPHPExcel->getActiveSheet()->setTitle('报修单');

        $titlename = array("报修人","报修时间","报修类别","报修地点","报修详情","维修部门接收时间", "维修预计时间", "接收负责人签字","维修完毕时间","维修完成情况","维修回访日期及情况", "备注");
        for ($i=0; $i < count($titlename); $i++){ 
            $objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($i,1)->getFont()->setBold(true);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow($i,1,$titlename[$i]);
        }   

        $row_id = 2;
        foreach($shires as $shire){
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(0,  $row_id, $shire['reporter']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(1,  $row_id, $shire['report_time']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(2,  $row_id, $shire['broken_item_class']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(3,  $row_id, $shire['place']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(4,  $row_id, $shire['reason']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(5,  $row_id, $shire['assign_feedback_time']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(6,  $row_id, $shire['request_days']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(7,  $row_id, '');
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(8,  $row_id, $shire['repair_time']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(9, $row_id, $shire['decode_state']);
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(10, $row_id, '');
            $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(11, $row_id, $shire['assign_extra_data']);

            $row_id += 1;
        }

        $objPHPExcel->setActiveSheetIndex(0);
        $excelName = '报修单_'.date("YmdHis").'.xls';
         
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        header("Content-Type: application/force-download");
        header("Content-Type: application/octet-stream");
        header("Content-Type: application/download");
        header("Content-Disposition: attachment; filename=".urlencode($excelName));
        header("Content-Transfer-Encoding: binary");
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header("Pragma: no-cache");
        $objWriter->save('php://output');
        return;
    }else{
        $smarty->assign('server_msg', 'NoData');
    }   
}

$smarty->assign('role_id', $role['role_id']);
$smarty->assign('role_type', $role['role_type']);

$smarty->display('admin/export.tpl');
?>
