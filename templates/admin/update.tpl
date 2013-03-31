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
          <label class="control-label" for="consumer">用户名</label>
          <div class="controls">
            <input type="text" id="consumer" name="consumer" value="{$consumer}" readonly>
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="origin_password">原始密码</label>
          <div class="controls"> <input type="password" id="origin_password" name="origin_password" placeholder="请输入原始密码!"> </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="password">新密码</label>
          <div class="controls">
            <input type="password" id="password" name="password" placeholder="请输入新密码!">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="re_password">确认密码</label>
          <div class="controls">
            <input type="password" id="re_password" name="re_password" placeholder="请确认密码!">
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="re_password">修改电话号码</label>
          <div class="controls">
            <input type="text" id="telephone" name="telephone" placeholder="请输入新的电话号码！">
          </div>
        </div>
        <div class="control-group">
          <div class="controls">
            <button type="submit" class="btn">修改</button>
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
    var origin_password = $('#origin_password').val().trim();
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
