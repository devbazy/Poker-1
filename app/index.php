<?php
include('core.php');
$page = $_GET['p'];
$page = $page == NULL?1:$page;
$total_counts = get_shire_count_not_refused();
$total = ceil($total_counts/20);
$shires = get_shires_not_refused($page);

$smarty->assign('page', $page);
$smarty->assign('total', $total);
$smarty->assign('total_counts', $total_counts);
$smarty->assign('shires', $shires);
$smarty->display('index.tpl');

?>
