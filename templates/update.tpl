{config_load file="main.conf"}
{include file="navs.tpl"}
  {if $server_error}
    {literal}
    <script>
    $(function(){ alert("错误!."); });
    </script>
    {/literal}
  {/if}
  {if $check_msg}
    {literal}
    <script>
    $(function(){ alert("报修使用的工号/学号与姓名不一致,将由管理员进行审核."); });
    </script>
    {/literal}
  {/if}
  {if $server_msg}
    {literal}
    <script>
    $(function(){
      if(confirm("报修成功。是否继续申报？") == false){
        window.location = 'index.php';
      } 
    });
    </script>
    {/literal}
  {/if}
  <div class="content">
    <table width=1024 border=0 align="center" cellpadding=0 cellspacing=0 class="table-border content-bg">
      <tr><td>
        <table width=1024 height=30 border=0 align="center" cellpadding=5 cellspacing=1>
          <tr><td align="center"><b class="title">报 修 登 记</b></td></tr>
        </table>
        <table width=1024 border=0 align="center" cellpadding=0 cellspacing=1>
          <tr><td height=30 align="center" class="table-msg">说明：请您认真填写每一项!带*必须填写!</td></tr>
        </table>
        <form method="POST">
          <table width=1024 border=0 align="center" cellpadding=0 cellspacing=1>
            <tr>
              <td width=175 height=30 align="right" class="m">用户姓名:</td>
              <td height=30><input type="text" id="reporter" name="reporter" size=10 maxlength=10><span class="table-msg">*</span></td>
            </tr>
            <tr>
              <td width=175 height=30 align="right" class="m">用户工号:</td>
              <td height=30><input type="text" id="report_id" name="report_id" size=10 maxlength=10><span class="table-msg">*(学生报修的话请填写自己的学号)</span></td>
            </tr>

            <tr>
              <td width=175 height=30 align="right" class="m">联系方式:</td>
              <td height=30 width=496><input type="text" id="contact_num" name="contact_num" size=10><span class="table-msg">*(请确保信息正确，方便后勤人员联系！)</span></td>
            </tr>
            <tr>
              <td width=175 height=30 align="right" class="m">报修部门:</td>
              <td height=30 width=860 colspan=3>
                <select id="department" style="width: 302px;">
                  <option value="" selected>请选择</option>
                  <option value="xybgs">学院办公室</option>
                  <option value="ghbgs">党群工作部</option>
                  <option value="jjsf">纪检审法办公室</option>
                  <option value="xsgzc">学生工作处</option>
                  <option value="jwc">教务处</option>
                  <option value="yjsc">研究生处</option>
                  <option value="rlzy">人力资源处</option>
                  <option value="kjfzc">科技发展处</option>
                  <option value="ghcwc">规划财务处</option>
                  <option value="zcglc">资产管理处</option>
                  <option value="zwbwc">总务保卫处</option>
                  <option value="tsg">图书馆</option>
                  <option value="jxjy">继续教育学院</option>
                  <option value="hq1">后勤服务公寓服务中心</option>
                  <option value="hq2">后勤服务餐饮服务中心</option>
                  <option value="hq3">后勤服务中心校园物业中心</option>
                  <option value="hq4">后勤服务商务服务中心</option>
                  <option value="hq5">后勤服务综合管理办公室</option>
                  <option value="hq6">后勤服务中心动力中心</option>
                  <option value="cbxy">船舶与海洋工程学院</option>
                  <option value="hykx">海洋科学与技术学院</option>
                  <option value="clkx">材料科学与工程学院</option>
                  <option value="jsj">计算机科学与技术学院</option>
                  <option value="tmgc">土木工程系</option>
                  <option value="tyjxb">体育教学部</option>
                  <option value="qcgc">汽车工程学院</option>
                  <option value="xxydq">信息与电气工程学院</option>
                  <option value="jjgl">经济管理学院</option>
                  <option value="lxy">理学院</option>
                  <option value="yywx">语言文学学院</option>
                  <option value="sxzz">思想政治伦理教学部</option>
                  <option value="scwy">上诚物业</option>
                  <option value="ghwy">广华物业</option>
                </select>
                <span class="table-msg">*</span>
                <!--
                <input type="text" id="department_ext" name="department_ext" size=21 maxlength=50><span class="table-msg">(请选择部门，无可选项者请在后面补充!)</span>
                -->
              </td>
            </tr>
            <tr>
              <td width=175 height=30 align="right" class="m">报修项目分类:</td>
              <td height=30 width=356 colspan=3>
                <select id="broken_item_class">
                  <option value="" selected="selected">请选择</option>
                  <option value="fs">防水</option>
                  <option value="fwwx">房屋维修</option>
                  <option value="xydl">校园道路维修与改造</option>
                  <option value="gpswx">给排水维修及改造</option>
                  <option value="dqwx">电气维修及改造</option>
                  <option value="mcwx">门窗维修及改造</option>
                  <option value="zyc">桌、椅、床等维修及改造</option>
                  <option value="qt">其他</option>
                </select>
                <select id="broken_item" name="broken_item">
                  <option value="" selected>请选择</option>
                </select><span class="table-msg">*</span>
              </td>
            </tr>
            <tr>
              <td height=30 width=175 align="right" class="m">故障地点:</td>
              <td height=30 width=796><input type="text" id="place" name="place" size=50><span class="table-msg">*</span></td>
            </tr>
            <tr>
              <td height=30 width=175 align="right" class="m">报修原因:</td>
              <td height=30 width=796>
                <input type="text" id="reason" name="reason" size=50><span class="table-msg">*(故障简单叙述,不超过50字)</span>
              </td>
            </tr>
            <tr>
              <td height=30 width=175 align="right" class="m">期待完成时间:</td>
              <td height=30 width=175>
                <input type="text" id="wish_time" name="wish_time">
              </td>
            </tr>
            <tr>
              <td height=30 width=175 align="right" class="m">上传故障图片:</td>
              <td height=30>
                <input type="file" id="upload_pics" name="upload_pics" data-url="upload.php" multiple>
                <!--
                <span class="btn btn-success fileinput-button">
                  <i class="icon-plus icon-white"></i>
                  <span>Add Files...</span>
                  <input type="file" id="upload_pics" name="upload_pics" data-url="upload.php" multiple>
                </span>
              -->
              </td>
            </tr>
            <tr class="upload_info">
              <td height=30 width=175 align="right" class="m">&nbsp;</td>
              <td height=30>
                <span>没有图片</span>
              </td>
            </tr>
            <tr>
              <td width=175 align="right" class="m">故障详细描述:</td>
              <td width=496><textarea id="detail" name="detail"></textarea>
            </tr>
            <tr>
              <td height=30 colspan=2 align="center" class="btn-groups">
                <div>
                  <button type="submit" class="btn btn-success">报修</button>
                  <button type="button" class="btn goto_home">返回</button>
                </div>
              </td>
            </tr>
          </table>
        </form>
      </td></tr>
    </table>
  </div>
  <script src="{$public}/js/libs/ui/minified/jquery.ui.widget.min.js"></script>
  <script src="{$public}/js/libs/jquery.iframe-transport.js"></script>
  <script src="{$public}/js/libs/jquery.fileupload.js"></script>
{literal}
  <script>
  $(function(){
    $.datepicker.setDefaults($.datepicker.regional["zh-CN"]);
    $('#wish_time').datepicker({dateFormat: 'yy/mm/dd'});
    var const_broken_item = {
      'fs': {
        'fwfs': '房屋防水',
        'qtfs': '墙体防水',
        'snfs': '室内防水',
        'bkyj': '不可预见项目'
      },
      'fwwx': {
        'xw': '室内维修',
        'b4': '室外维修'
      },
      'xydl': {
        'jbxm': '基本项目'
      },
      'gpswx': {
        'gps1': '给排水维修及改造'
      },
      'dqwx': {
        'dqwx1': '电器维修及改造'
      },
      'mcwx': {
        'mcwx1': '门窗维修及改造'
      },
      'zyc': {
        'zyc1': '桌、椅、床等维修及改造'
      },
      'qt': {
        'qt1':  '其他'
      }
    };

    var binding_item = function(item){
      var const_item = eval('const_' + item);
      var item_class = $('#' + item + '_class');
      var item_obj = $('#' + item);
      item_class.on('change', function(e){
        var cnt_selected_class = item_class.val();
        if(cnt_selected_class){
          item_obj.find('option').remove();     

          var length = function(o){
            var count = 0;
            for(var i in o){
              if(o.hasOwnProperty(i)){
                count++;
              }
            }
            return count;
          };
          if(length(const_item[cnt_selected_class]) != 1){
            item_obj.append('<option value="" selected>请选择</option>');
          }
          for(var k in const_item[cnt_selected_class]){
            v = const_item[cnt_selected_class][k];
            item_obj.append("<option value='" + k + "'>" + v + "</option>");
          }
          console.log(item_obj);
        }
      });
    };
    ["broken_item"].forEach(function(v){binding_item(v)});

    var item_decode = function(o){
      return o.find('option:selected').text().trim();
    };
    var valid = function(){
      var reporter = $('#reporter').val().trim();
      var report_id = $('#report_id').val().trim();
      var contact_num = $('#contact_num').val().trim();
      var department = $('#department');
      var broken_item_class = $('#broken_item_class');
      var broken_item = $('#broken_item');
      var place = $('#place').val().trim();
      var reason = $('#reason').val().trim();
      var wish_time = $('#wish_time').val().trim();

      department = item_decode(department);
      if(department == '请选择'){ department = null; }
      broken_item_class = item_decode(broken_item_class);
      broken_item = item_decode(broken_item);
      if(broken_item == '请选择'){
        broken_item = null;
      }
  
      if(reporter && report_id && contact_num && department && broken_item && place && reason){
        var hidden_data = [
          "<input type='hidden' name='department_decode' value='" + department + "'>",
          "<input type='hidden' name='broken_item_class_decode' value='" + broken_item_class + "'>",
          "<input type='hidden' name='broken_item_decode' value='" + broken_item + "'>"
        ];
        hidden_data.forEach(function(v){
          $('form').append(v);
        });
      }else{
        alert("请确保必填项均已填写!");
        return false;
      }
    }; 
    var upload_file_object = $('#upload_pics');
    upload_file_object.fileupload();
    upload_file_object.fileupload({
      url: 'upload.php',
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
      add: function(e, data){
        var jqXHR = data.submit()
                  . success(function(data){
             $('form').append('<input type="hidden" name="filename" value="' + data.name + '">');
             $('.upload_info').find('span').text('已上传图片 ' + data.origin_name);
             alert("上传成功!");
          });
      }
    });
    $('form').on('submit', function(e){
      var is_valid = valid();
      return is_valid;
    });
  });
  </script>
{/literal}
{include file="footer.tpl"}
