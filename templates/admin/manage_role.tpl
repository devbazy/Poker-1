{config_load file="main.conf"}
{include file="navs.tpl"}
  <div class="content">
    {include file="admin/admin_navs.tpl"}
    <div class="admin_content">
      <div class="server_msg">
        {$server_msg}
      </div>
      <table class="table">
        <thead>
        <tr>
          <td style="text-align:right;">现有身份类型:</td>
          <td width=140px>
            <select id="role_type">
              {foreach from=$roles item=role}
                <option value='{$role.role_id}'>{$role.role_type}</option>
              {foreachelse}
                <option value='-1'>没有任何类型</option>
              {/foreach}
            </select>
          </td>
          <td><button class="btn btn-danger btn-del">删除</button></td>
        </tr>
        <tr>
          <td style="text-align:right;">添加身份类型:</td>
          <td width=140px>
            <input type="text" id="add_role_type" name="add_role_type" style="width: 208px"/>
          </td>
          <td><button class="btn btn-success btn-add">添加</button></td>
        </tr>

        </thead>
      </table>
    </div>
    <div class="fix">&nbsp;</div>
  </div>
{literal}
<script>
$(function(){
    $('button.btn-add').on('click', function(e){
      e.preventDefault();
      var role_type = $('#add_role_type').val().trim();
      $.post('j/role.php', {type:'add', role_type:role_type}, function(d){
        if(d.r == 0){
          alert(d.msg);
          return false;
        }else{
          alert('添加成功!');
          window.location = window.location;   
        }
      });
    });
    $('button.btn-del').on('click', function(e){
      e.preventDefault();
      var role_id = $('#role_type').val();
      $.post('j/role.php', {type:'del', role_id:role_id}, function(d){
        if(d.r == 0){
          alert(d.msg);
          return false;
        }else{
          alert('删除成功!');
          window.location = window.location;
        }
      });
    });
});
</script>
{/literal}
{include file="footer.tpl"}
