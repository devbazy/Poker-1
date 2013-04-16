{config_load file="main.conf"}
{include file="navs.tpl"}
  {if $server_msg}
    {literal}
    <script>
    $(function(){
      alert("搜索字符串不合法!");
    });
    </script>
    {/literal}
  {/if}
  <div class="content">
    {if $query_result}
    <table width=1024 border=1 cellpadding=5 cellspacing=1 bgcolor="#CCCCCC" style="border-collapse: collapse" bordercolorlight="#335EA8" bordercolordark="#335EA8">
      <tbody>
        <tr>
          <td bgcolor="#CCCCCC">
            <div align="center">
              <table width="100%" border=0 align=center cellpadding=0 cellspacing=0>
                <tbody>
                  <tr>
                    <td>
                      <table width="100%" border=0 align="center" cellpadding=0 cellspacing=1 class="table-border">
                        <tbody>
                          <tr>
                            <td width="10%" height=30 class="table-title" align="center"><strong>报修编号</strong></td>
                            <td width="14%" height=30 class="table-title" align="center"><strong>部门或班级</strong></td>
                            <td width="13%" height=30 class="table-title" align="center"><strong>故障地点</strong></td>
                            <td width="13%" height=30 class="table-title" align="center"><strong>报修原因</strong></td>
                            <td width="10%" height=30 class="table-title" align="center"><strong>报修物品</strong></td>
                            <td width="10%" height=30 class="table-title" align="center"><strong>报修时间</strong></td>
                            <td width="6%" height=30 class="table-title" align="center"><strong>维修状态</strong></td>
                            <td width="8%" height=30 class="table-title" align="center"><strong>维修时间</strong></td>
                            <td width="16%" height=30 class="table-title" align="center"><strong>安排与反馈</strong></td>
                          </tr>
                          {foreach from=$shires item=shire}
                          <tr>
                            <td width="10%" height=30 class="table-body" align="center"><a href="{$domain}/app/detail.php?id={$shire.shire_id}">#2013{$shire.shire_id}</a></td>
                            <td width="14%" height=30 class="table-body" align="center">{$shire.department|escape}</td>
                            <td width="13%" height=30 class="table-body" align="center">{$shire.place|escape}</td>
                            <td width="13%" height=30 class="table-body" align="center">{$shire.reason|escape}</td>
                            <td width="10%" height=30 class="table-body" align="center">{$shire.broken_item|escape}</td>
                            <td width="10%" height=30 class="table-body" align="center">{$shire.report_time}</td>
                            {if $shire.state == 0}
                              <td width="6%" height=30 class="table-body blue" align="center">{$shire.decode_state}</td>
                              <td width="8%" height=30 class="table-body blue" align="center">{$shire.decode_state}</td>
                            {elseif $shire.state == 2}
                              <td width="6%" height=30 class="table-body red" align="center">{$shire.decode_state}</td>
                              <td width="8%" height=30 class="table-body red" align="center">{$shire.repair_time}</td>
                            {else}
                              <td width="6%" height=30 class="table-body green" align="center">{$shire.decode_state}</td>
                              <td width="8%" height=30 class="table-body" align="center">&nbsp;</td>
                            {/if}
                            {if $shire.state == -1}
                              <td width="16%" height=30 class="table-body" align="center">{$shire.state_context|escape}</td>
                            {elseif $shire.state == 2}
                              <td width="16%" height=30 class="table-body red" align="center">{$shire.feedback|escape}</td>
                            {else}
                              <td width="16%" height=30 class="table-body" align="center">&nbsp;</td>
                            {/if}
                          </tr>
                          {foreachelse}
                            <tr><td colspan=9 class="msg">没有报修数据!</td></tr>
                          {/foreach}
                        </tbody>
                      </table>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
    {else}
    <div class="search_area">
      <form method="GET">
        <select id="search_class" name="search_class">
          <option value="bianhao" selected="selected">按编号查找</option>
          <option value="fenlei" >按分类查找</option>
          <option value="wupin" >按报修物品查找</option>
          <option value="time" >按报修时间查找</option>
        </select>
        <input type="text" id="search" name="search" placeholder="输入要搜索的报修单号或分类" />
        <button type="submit">查找</button>
        <div>
          <span><font color="red"><strong>注意:</strong></font></span>
          <div>
            <span><font color="red">报修编号前应该加'#'，如:#2013170</font></span>
          </div>
          <div>
            <span><font color="red">报修时间格式应为:2013-03-28或20130328</font></span>
          </div>
        </div>
      </form>
    </div>
    {/if}
  </div>
  {include file="footer.tpl"}
