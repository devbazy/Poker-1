{config_load file="main.conf"}
<!doctype html>
<html lang="en">
<head>
{include file="header.tpl"}
{if $smarty.config.DEBUG == 1}
<script src="{$public}/js/libs/less.min.js"></script>
{/if}
</head>
<body>
<!-- IE6 -->
<!--[if lte IE 6]>
<div class="ie6">您使用的浏览器版本过低,为了保证您的安全以及对本系统的使用体验,建议您升级浏览器.不知道去哪里升级?<a href="http://chrome.360.cn/" target="_blank">点击这里</a></div>
<![endif]-->
<div class="container">
  <div class="banner">
    <div class="banner-img">
      <img src="{$public}/img/banner.jpg">
    </div>
    <div class="navs">
      <div class="date left">{$header_date}</div>
      <div class="nav right">
        <ul>
          <li><a href="http://hq.hitwh.edu.cn/">后勤服务中心首页</a></li>
          <li><a href="{$domain}/app/index.php" class="home">报修系统首页</a></li>
          <li><a href="{$domain}/app/update.php">在线报修</a></li>
          <li><a href="#" class="quit_system">退出系统</a></li>
        </ul>
      </div>
    </div>
    <div class="note">
      <div class="weather_report">
        <TABLE cellSpacing=0 cellPadding=0 width=1024 align=center border=0> 
            <TR>
              <TD> 
                <DIV id="demo" style="OVERFLOW: HIDDEN; WIDTH: 1024px;"> 
                  <TABLE cellSpacing=0 cellPadding=0 align=left bgcolor=#CCC border=0 cellspace="0"> 
                      <TR> 
                        <TD id="demo1" vAlign=top><table width="1024" bgcolor=#CCC border="0" cellpadding="0" cellspacing="0"> 
                      <tr> 
                        <td width="1024" bgcolor=#CCC><div align="center" class="msg" style="background-color:#CCC;"><img src="{$public}/img/d.gif" style="width:19px;height:18px;">后勤服务中心竭诚为您服务，欢迎使用在线报修系统！</div></td> 

                      </tr> 
                  </table></TD> 
                  <TD id="demo2" vAlign=top> </TD></TR></TABLE></DIV> 
    </TD></TR></TABLE></TD></TR></TABLE> 
    </div></div>
  </div>
{literal}
<SCRIPT> 
$(function(){
  var speed3=10//速度数值越大速度越慢 
  var t=false; 
  var id="aa"; 
  document.getElementById("demo2").innerHTML=document.getElementById("demo1").innerHTML 
  function Marquee(){ 
  if(document.getElementById("demo2").offsetWidth-document.getElementById("demo").scrollLeft<=0) 
  document.getElementById("demo").scrollLeft-=document.getElementById("demo1").offsetWidth 
  else{ 
  document.getElementById("demo").scrollLeft++ 
  } 
  t=false; 
  } 
  function RMarquee(){  
  if(document.getElementById("demo").scrollLeft<=0) 
    document.getElementById("demo").scrollLeft+=document.getElementById("demo2").offsetWidth 
    else{ 
    document.getElementById("demo").scrollLeft-- 
    } 
    t=true; 

  } 
  function clickdiv(){ 
  clearInterval(MyMar) 
  Marquee(); 
  } 
  function Rclickdiv(){ 
  clearInterval(MyMar) 
  RMarquee(); 
  } 
  var MyMar=setInterval(Marquee,speed3) 
  document.getElementById("demo").onmouseover=function() {clearInterval(MyMar)} 
  document.getElementById("demo").onmouseout=function() {if(t){MyMar=setInterval(RMarquee,speed3)}else{MyMar=setInterval(Marquee,speed3)}} 

  // render the header
  //if($.browser.webkit)
  userAgent = navigator.userAgent.toLowerCase();
  if(/webkit/.test(userAgent)){
    $('#demo').css('margin-top', '-12px');
  }
});
</SCRIPT> 
{/literal}
