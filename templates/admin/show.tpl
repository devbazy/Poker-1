{config_load file="main.conf"}
{include file="navs.tpl"}
  <div class="content">
    {include file="admin/admin_navs.tpl"}
    <div class="admin_content">
      <div class="filter">
        按分类查找
        <select id="broken_item_class">
          <option value="" selected="selected">请选择</option>
          <option value="fs" data-value="防水">防水</option>
          <option value="fwwx" data-value="房屋维修">房屋维修</option>
          <option value="xydl" data-value="校园道路维修与改造">校园道路维修与改造</option>
          <option value="gpswx" data-value="给排水维修及改造">给排水维修及改造</option>
          <option value="dqwx" data-value="电气维修及改造">电气维修及改造</option>
          <option value="mcwx" data-value="门窗维修及改造">门窗维修及改造</option>
          <option value="zyc" data-value="桌、椅、床等维修及改造">桌、椅、床等维修及改造</option>
          <option value="qt" data-value="其他">其他</option>
        </select>
        <button>筛选</button>
      </div>
      <table width="100%" border=1 cellpadding=5 cellspacing=1 bgcolor="#CCCCCC" style="border-collapse: collapse" bordercolorlight="#335EA8" bordercolordark="#335EA8">
        <tbody>
          <tr>
            <td bgcolor="#CCCCCC">
              <div align="center">
                <table width="100%" border=0 align=center cellpadding=0 cellspacing=0>
                  <tbody>
                    <tr>
                      <td>
                        <table width="100%" border=0 align="center" cellpadding=0 cellspacing=1 class="table-border data-table">
                          <tbody>
                            <tr>
                              <td width="10%" height=30 class="table-title" align="center"><strong>报修编号</strong></td>
                              <td width="14%" height=30 class="table-title" align="center"><strong>部门或班级</strong></td>
                              <td width="13%" height=30 class="table-title" align="center"><strong>故障地点</strong></td>
                              <td width="13%" height=30 class="table-title" align="center"><strong>报修原因</strong></td>
                              <td width="10%" height=30 class="table-title" align="center"><strong>报修物品</strong></td>
                              <td width="10%" height=30 class="table-title" align="center"><strong>报修时间</strong></td>
                              <td width="10%" height=30 class="table-title" align="center"><strong>期待完成时间</strong></td>
                              <td width="16%" height=30 class="table-title" align="center"><strong>查看</strong></td>
                            </tr>
                            {foreach from=$shires item=shire}
                            <tr class="data-line">
                              <td width="10%" height=30 class="table-body" align="center">#2013{$shire.shire_id}</td>
                              <td width="14%" height=30 class="table-body" align="center">{$shire.department|escape}</td>
                              <td width="13%" height=30 class="table-body" align="center">{$shire.place|escape}</td>
                              <td width="13%" height=30 class="table-body" align="center">{$shire.reason|escape}</td>
                              <td width="10%" height=30 class="table-body" align="center">{$shire.broken_item|escape}</td>
                              <td width="10%" height=30 class="table-body" align="center">{$shire.report_time}</td>
                              <td width="10%" height=30 class="table-body" align="center">{$shire.wish_time}</td>
                              <td width="6%" height=30 class="table-body" align="center">
                                {if $shire.filename}
                                  <a class="show_pic" href="#" data-url="{$shire.filename}" data-domain="{$domain}">点击查看图片</a></td>
                                {else}
                                  此报修没有相关图片
                                {/if}
                            </tr>
                            <tr class="hidden">
                              <td colspan=4 class="table-body">
                                <p style="text-align:left;">
                                  报修人: {$shire.reporter|escape}<br>
                                  报修人工号: {$shire.report_id|escape}<br>
                                  报修人联系方式: {$shire.contact_num|escape}<br>
                                  报修时间: {$shire.report_time}<br>
                                  期待完成时间：{$shire.wish_time}<br>
                                  报修原因: {$shire.reason|escape}<br>
                                  详细原因: {$shire.detail|escape}<br>
                                  {if $shire.role_id}
                                    <font color="red">后勤管理员分配时间:{$shire.assign_time}</font><br>
                                    <font color="red">此报修事件分配给 {$shire.role_type|escape}</font><br>
                                    {if $shire.extra_data}
                                    <font color="red">后勤管理员分配备注:{$shire.extra_data|escape}</font><br>
                                    {/if}
                                  {/if}
                                  {if $shire.assign_feedback_time}
                                    <font color="red">后勤管理员确认维修请求时间:{$shire.assign_feedback_time}</font><br>
                                  {/if}
                                  {if $shire.request_days}
                                    <font color="red">维修人员请求维修时间:{$shire.request_days}</font><br>
                                  {/if}
                                  {if $shire.repair_time}
                                    <font color="red">维修时间:{$shire.repair_time}</font><br>
                                  {/if}
                                </p>
                              </td>
                              <td colspan=4
                               class="table-body">
                                <table width="100%" border=0>
                                  <tr>
                                    <td>
                                      <font color="red">
                                      {if $shire.state == -1}
                                        后勤管理员拒绝此报修.<br>
                                        反馈:{$shire.feedback|escape}<br>
                                      {elseif $shire.state == 0}
                                        {if $shire.assign_feedback == -1}
                                          后勤管理员分配此报修到{$shire.role_type|escape}进行维修.<br>
                                          {$shire.role_type|escape}拒绝了此维修.<br>
                                        {elseif $shire.assign_feedback == 0}
                                          后勤管理员分配此报修到{$shire.role_type|escape}进行维修.<br>
                                          此报修正等待{$shire.role_type}进行回复.<br>
                                        {elseif $shire.assign_feedback == 1}
                                          后勤管理员分配此报修到{$shire.role_type|escape}进行维修.<br>
                                          后勤人员接受了此报修，预计消耗{$shire.request_days}天数进行维修<br>
                                          {if $shire.assign_extra_data}
                                            维修人员备注:{$shire.assign_extra_data|escape}<br>
                                          {/if}
                                          {$shire.role_type|escape}正在等待后勤管理员的确认.<br>
                                        {/if}
                                      {elseif $shire.state == 1}
                                        此报修处于在修状态，由{$shire.role_type|escape}进行维修.<br>
                                        维修预计消耗:{$shire.request_days}天.<br>
                                        {if $shire.assign_extra_data}
                                          维修人员备注:{$shire.assign_extra_data|escape}<br>
                                        {/if}
                                      {else} 
                                        此报修处于已修缮完毕状态，由{$shire.role_type|escape}进行维修.<br>
                                        维修完成时间:{$shire.repair_time}<br>
                                        {if $shire.assign_extra_data}
                                          维修人员备注:{$shire.assign_extra_data|escape}<br>
                                        {/if}
                                        维修反馈:{$shire.feedback|escape}<br>
                                      {/if}
                                      </font>
                                    </td>
                                  </tr>
                                  <tr>
                                    {if $shire.state != -1}
                                    {if $role_id==1}
                                    <tr>
                                      <td>冻结此报修,理由&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"></td>
                                      <td><button class="btn btn-danger btn-freeze" data-id="{$shire.shire_id}" data-state=-1>冻结</button></td>
                                    </tr>
                                    {/if}
                                    {/if}
                                  </tr>
                                </table>
                              </td>
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
      {include file="paginator.tpl"}
    </div>
    <div class="fix">&nbsp;</div>
  </div>
  <script src="{$public}/js/libs/jquery.bpopup-0.8.0.min.js"></script>
{literal}
<script>
$(function(){
    $('.data-table').find('tr[class=data-line]').on('click', function(e){
        $('tr[class=hidden]').hide();
        $(this).next('.hidden').show();
    });
    $('a.show_pic').on('click', function(e){
        e.preventDefault();
        var domain = $(this).attr('data-domain').trim();
        var picpath = $(this).attr('data-url').trim();
        if(!picpath){
            alert("用户没有上传关于此报修的图片!");
            return false;
        }
        var img = '<img src="' + domain + '/upload/' + picpath + '" style="width:400px;height:300px;" />';
        $(img).bPopup();
        return false;
    });
    $('button.btn-admin').on('click', function(e){
        var btn = $(this);
        var shire_id = btn.attr('data-id');
        var feedback = btn.attr('data-feedback');
        var hidden_line = btn.closest('.hidden');
        var data_line = hidden_line.prev();

        var extra_data = btn.closest('td').prev().find('input').val().trim();
        $.post('j/user.php', {shire_id:shire_id, feedback:feedback, extra_data:extra_data},
            function(d){
                if(d.r){ 
                    alert("成功!");
                    data_line.remove();
                    hidden_line.remove();
                }else{
                    alert(d.msg);
                    return false;
                }
            }
        );
    });
    $('button.btn-freeze').on('click', function(e){
        var btn = $(this);
        var shire_id = btn.attr('data-id');
        var state_context = '';
        var hidden_line = btn.closest('.hidden');
        var data_line = hidden_line.prev();
        state_context = btn.closest('td').prev().find('input').val().trim();
        $.post('j/freeze.php', {shire_id:shire_id, state_context:state_context},
            function(d){
                if(d.r){ 
                    alert("成功!");
                    data_line.remove();
                    hidden_line.remove();
                }else{
                    alert(d.msg);
                    return false;
                }
            }
        );
    });
    var decode_http_args = function(){
        var http_args = {};
        var query_string = window.location.search;
        query_string = query_string.substring(1);

        var pairs = query_string.split('&');
        for(var i=0;i<pairs.length;i++){
            var sign = pairs[i].indexOf('=');
            if(sign == -1){
              return http_args;
            }
            var key = pairs[i].substring(0, sign);
            var value = pairs[i].substring(sign+1);
            http_args[key] = value;
        }
        return http_args;
    };
    var encode_http_args = function(http_args){
        var data_string = [];
        for(var k in http_args){
            data_string.push(k + '=' + http_args[k]);
        }
        return unescape(data_string.join('&'));
    };
    $('.filter').on('click', 'button', function(e){
        var broken_class_select = $('#broken_item_class');
        var broken_class = broken_class_select.find('option:selected').text().trim();
        if(broken_class!='请选择'){
            var http_args = decode_http_args();
            http_args['broken_class'] = broken_class;
            window.location = window.location.pathname + '?' + encode_http_args(http_args);
        }else{
            alert("请选择分类!");
        }   
    });
    (function(){
        // render
        var http_args = decode_http_args();
        broken_class = http_args['broken_class'];
        if(broken_class){
            broken_class = decodeURI(broken_class);
            var broken_class_select = $('#broken_item_class');
            broken_class_select.find('option').attr('selected', false);
            broken_class_select.find('option[data-value=' + broken_class + ']').attr('selected', true);
        }
    })();
});
</script>
{/literal}
{include file="footer.tpl"}
