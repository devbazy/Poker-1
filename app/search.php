<?php
include('core.php');

if($_GET){
    $search = escape($_GET['search']);
    $search_class = escape($_GET['search_class']);
    if($search_class == "bianhao") {
    	preg_match('/#2013(\d+)$/', $search, $matches);
    	if($matches){
    		$shires = find_shires($matches[1]);
    		$smarty->assign('query_result', True);
    		$smarty->assign('shires', $shires);
    	}else{
    		$smarty->assign('server_msg', '搜索字符串不合法!');
    	}
    }elseif($search_class == "fenlei") {
    	$shires = find_shires_class($search);
    	$smarty->assign('query_result', True);
    	$smarty->assign('shires', $shires);
    }elseif ($search_class == "wupin") {
    	$shires = find_shires_wupin($search);
    	$smarty->assign('query_result', True);
    	$smarty->assign('shires', $shires);
    }elseif ($search_class == "time") {
    	$shires = find_shires_time($search);
    	$smarty->assign('query_result', True);
    	$smarty->assign('shires', $shires);
    }
}

$smarty->display('search.tpl');
?>
