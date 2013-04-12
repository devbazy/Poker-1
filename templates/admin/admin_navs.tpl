{config_load file="main.conf"}
    <div class="admin_navs">
      <ul class="nav nav-list">
        {if $role_id==1}
          <li class="nav-header">报修管理</li>
          <li><a href="index.php">管理首页</a></li>
          <li><a href="admin.php">报修分配</a></li>
          <li><a href="admin.php?assign_feedback=1">下级反馈</a></li>
          <li><a href="show.php">报修汇总</a></li>
          <li><a href="export.php">导出报表</a></li>
       
          <li class="nav-header">用户管理</li>
          <li><a href="manage_role.php">身份管理</a></li>
          <li><a href="account.php">添加用户</a></li>
          <li><a href="update.php">修改用户信息</a></li>
        {else}
          <li class="nav-header">报修管理</li>
          <li><a href="index.php">管理首页</a></li>
          <li><a href="admin.php">报修新单</a></li>
          <li><a href="admin.php?admin_feedback=1">后勤反馈</a></li>
          <li><a href="admin.php?repair_feedback=1">在修管理</a></li>
          <li><a href="show.php">报修汇总</a></li>
          <li><a href="export.php">导出报表</a></li>
       
          <li class="nav-header">用户管理</li>
          <li><a href="update.php">修改用户信息</a></li>
        {/if}
        <li class="divider"></li>
        <li><a href="logout.php">退出</a></li>
      </ul>
    </div>
