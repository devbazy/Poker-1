{config_load file="main.conf"}
{include file="navs.tpl"}
  <div class="content">
    {include file="admin/admin_navs.tpl"}
    <div class="admin_content">
      <div class="server_msg">
        {$server_msg}
      </div>
      <form method="POST" class="form-horizontal">
        <div class="control-group">
          <label class="control-label" for="consumer">身份类型</label>
          <div class="controls">
            <select id="role_type" name="role_type">
              {foreach from=$roles item=role}
                <option value='{$role.role_id}'>{$role.role_type}</option>
              {foreachelse}
                <option value='-1'>没有任何类型</option>
              {/foreach}
            </select>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="consumer">用户名</label>
          <div class="controls">
            <input type="text" id="consumer" name="consumer">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password">密码</label>
          <div class="controls">
            <input type="password" id="password" name="password" placeholder="请输入密码!">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="re_password">确认密码</label>
          <div class="controls">
            <input type="password" id="re_password" name="re_password" placeholder="请确认密码!">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="telephone">电话号码</label>
          <div class="controls">
            <input type="password" id="telephone" name="telephone" placeholder="请输入电话号码！">
          </div>
        </div>
        <div class="control-group">
          <div class="controls">
            <button type="submit" class="btn">添加</button>
            <button type="reset" class="btn">重置</button>
          </div>
        </div>
      </form>

    </div>
    <div class="fix">&nbsp;</div>
  </div>
{literal}
<script>
$(function(){
  $('form').on('submit', function(e){
    var password = $('#password').val().trim();
    var re_password = $('#re_password').val().trim();

    if(password != re_password){
      alert("确认密码错误.请重新确认!");
      $('input[type=password]').attr('value', '');
      return false;
    }
  });
});
</script>
{/literal}
{include file="footer.tpl"}
