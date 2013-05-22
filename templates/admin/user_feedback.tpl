{config_load file="main.conf"}
{include file="navs.tpl"}
  <div class="content">
    {include file="admin/admin_navs.tpl"}
    <div class="admin_content">
      <div class="filter">
        <span>按分类查找</span>
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
        <button class="btn btn-filter">筛选</button>
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
                              <td width="16%" height=30 class="table-body" align="center">
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
                                  报修原因: {$shire.reason|escape}<br>
                                  详细原因: {$shire.detail|escape}<br>
                                  报修人员期待完成日期：{$shire.wish_time|escape}<br>
                                  <font color="red">后勤管理员分配时间: {$shire.assign_time}</font><br>
                                  {if $shire.extra_data}
                                  <font color="red">后勤管理员分配备注:{$shire.extra_data|escape}</font><br>
                                  {/if}
                                  <font color="red">维修申请时间: {$shire.request_days}</font><br>
                                  <font color="red">后勤管理员通过报修审批时间: {$shire.assign_feedback_time}</font><br>
                                </p>
                              </td>
                              <td colspan=4 class="table-body">
                                  <table width="100%" border=0>
                                    <tr>
                                      <td>
                                        <textarea placeholder="输入反馈内容，提交后状态为已修缮完毕!"></textarea>
                                      </td>
                                      <td>
                                        <button class="btn btn-success btn-admin" data-id="{$shire.shire_id}">确定</button>

                                      </td>
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
        var hidden_line = btn.closest('.hidden');
        var data_line = hidden_line.prev();
        var feedback = btn.closest('td').prev().find('textarea').val().trim();
        var shire_id = btn.attr('data-id');
        $.post('j/user_feedback.php', {type:'feedback', shire_id:shire_id, feedback: feedback},
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
