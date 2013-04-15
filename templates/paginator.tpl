{config_load file="main.conf"}
{if $total>1}
  <div class="paginator">
    <div class="paging_detail">
      [<span class="paging_page">{$page}</span>/<span class="paging_total">{$total}</span>]每页<span class="paging_limit">20</span>条 共<span class="paging_total_counts">{$total_counts}</span>条记录
    </div>
    <div class="paging_op">
      {if $page>1}
        <a class="first" href="#">首页</a>
        <a class="prev" href="#">上一页</a>
      {/if}
      <a class="next" href="#">下一页</a>
      <a class="last" href="#">尾页</a>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <span>跳转到</span>
      <input name="page" type="text" style="width:20px" id="_page">
      <span>页</span>
      <a href="跳转" class="btn-jump"><strong>跳转</strong></a>
    </div>
  </div>

{literal}
<script>
$(function(){
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

    var paginator = $('.paginator');
    var paging_op = $('.paging_op');
    var paging_page = parseInt(paginator.find('.paging_page').text().trim());
    var paging_total = parseInt(paginator.find('.paging_total').text().trim());

    $('a.btn-jump').on('click',function(e){
        e.preventDefault();
        var _page = $('#_page').val().trim();
        if ( (_page > paging_total) || (_page <= 0) ) {
          alert("请输入正确的页码！");
        }
        else{
          var http_args = decode_http_args();
          http_args['p'] = _page;
          window.location = window.location.pathname + '?' + encode_http_args(http_args);
        }
    });
    paging_op.on('click', '.first', function(e){
      e.preventDefault();
      var http_args = decode_http_args();
      http_args['p'] = 1;
      window.location = window.location.pathname + '?' + encode_http_args(http_args);
    });
    paging_op.on('click', '.last', function(e){
      e.preventDefault();
      var http_args = decode_http_args();
      http_args['p'] = paging_total;
      window.location = window.location.pathname + '?' + encode_http_args(http_args);
    });
    paging_op.on('click', '.prev', function(e){
      e.preventDefault();
      if(paging_page == 1){
        alert("已到第一页!");
        return false;
      }
      var page = paging_page-1;
      var http_args = decode_http_args();
      http_args['p'] = page;
      window.location = window.location.pathname + '?' + encode_http_args(http_args);
    });
    paging_op.on('click', '.next', function(e){
      e.preventDefault();
      if(paging_page == paging_total){
        alert("已到最后一页!");
        return false;
      }
      var page = paging_page+1;
      var http_args = decode_http_args();
      http_args['p'] = page;
      window.location = window.location.pathname + '?' + encode_http_args(http_args);
    });
});
</script>
{/literal}
{/if}
