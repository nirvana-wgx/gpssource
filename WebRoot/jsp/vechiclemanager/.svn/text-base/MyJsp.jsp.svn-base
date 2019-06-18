 
 
 
 
 
 
 <%@ page language="java"   pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 
<title>楚宸电子科技</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link type="text/css" rel="stylesheet" href="../css/base.css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript" src="../js/tables.js"></script>
		<script type="text/javascript">			
function changeFun(id){
	switch(id){
		case "o1":	
			document.getElementById("d2").innerHTML = '<input type="checkbox" name="vehicle" value="Bike" /> I have a bike <br /><input type="checkbox" name="vehicle" value="Car" /> I have a car';
			break;
		case "o2":	
			document.getElementById("d2").innerHTML = '<input type="text" value="click" />';
			break;
	}
}
</script>
<script type="text/javascript">			
function notifyResult(){
	
}
</script>
</head>
<body onload="notifyResult()">
		
 
 
 
 
<script type="text/javascript"> 
//加入收藏
function AddToFavorite() {
if (document.all) {
window.external.addFavorite(document.URL, document.title);
} else if (window.sidebar) {
window.sidebar.addPanel(document.title, document.URL, 楚宸电子科技);
}
}
//设为首页
function setHomepage() {
if (document.all) {
document.body.style.behavior = 'url(#default#homepage)';
document.body.setHomePage(document.URL);
} else if (window.sidebar) {
if (window.netscape) {
try {
netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
} catch (e) {//火狐浏览器
alert("该操作被浏览器拒绝，如果想启用该功能，请在地址栏内输入 about:config, 然后将项 signed.applets.codebase_principal_support 值该为true");
}
}
var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
prefs.setCharPref('browser.startup.homepage', document.URL);
}
}
 
</script>
<div class="headout">
<div class="headin">
    <div id="top" class="wrapper">
        <ul class="topleft">
            <li><span id="day">      
			<script>       
			document.getElementById('day').innerHTML=new Date().toLocaleString();       
			setInterval("document.getElementById('day').innerHTML=new Date().toLocaleString();",1000);       
			</script>      
			</span>  
			</li>
        </ul>
        <ul class="topright">
            <li><a href="" onclick="setHomepage();return false;">设为首页</a></li>
            <li><a href="" onclick="AddToFavorite();return false;">加为收藏</a></li>
            <li class="bgnone"><a href="#" target="_self">帮助</a></li>             
            <li class="bgnone"><a href="/jsp/quit.jsp" target="_self">退出</a></li>             
        </ul>
        <div class="clear"></div>
    </div>
      <div class="user_logo" style="clear:both; width:980px; margin-left:auto; margin-right:auto;height:183px; background:url(../images/logo.gif) no-repeat;" >
    </div>
    <div id="nav" class="wrapper">
        <ul>
            <li class="on"><a href="/dv.do?optype=selectAll" target="_self">车辆管理</a></li> 
            <li><a href="/jsp/accountadd.jsp" target="_self">账户管理</a></li>
            <!-- <li><a href="/jsp/statis_analy.jsp" target="_self">统计分析</a></li>-->
            <!-- <li><a href="#" target="_self">地图定位</a></li> -->
            <li><a href="#" target="_self">公告栏目</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
    </div>
<div id="cont" class="wrapper">
	<div class="box_aa">
    	<div class="top_a">
        	<div class="button_a">当前位置：</div>
            <ul class="address_a">
            	<li><a href="/dv.do?optype=selectAll" target="_self">首页</a></li>
                <li><a href="/dv.do?optype=selectAll" target="_self">车辆管理</a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="cont_a">
        	<div class="left_a">
            	<dl class="menu_a">
                	<dt>车辆管理</dt>
                    <dd><a href="/dv.do?optype=selectAll" target="_self">车辆一览</a></dd>
                    <dd><a href="/jsp/dvadd.jsp" target="_self">新增车辆</a></dd>
                    <dd><a href="/dv.do?optype=selectAllOper" target="_self">修改/删除</a></dd>
                    
                    <dd><a href="/historyAll.do" target="_self">历史信息</a></dd>
                    
                </dl>
            </div>
            
            
            <div class="right_a">
            	<div class="search sgrey">
                	<s class="r1"></s><s class="r2"></s>
                    <div class="content">
                     <h5><i>命令下发</i></h5>
                    <form id="form_commend" name="form1" method="post" action="/command.do?type=send">
                    
                     <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                      <tr>
                        <td><b>机号：</b><input type="text" readonly="readonly" value="XCMG102108BBR2133" id="vid" name="vid"/></td>
                        <td><b>设备号：</b><input type="text" readonly="readonly" value="BM40900001" id="did" name="did"/></td>
                        <td><b>SIM卡号：</b><input type="text" readonly="readonly" value="15106704970" id="sim" name="sim"/></td>
                      </tr>
                    </table>
                    
                     
                    
                    
                     <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                      <tr>
                        <td><input type="radio" checked="checked" value="GE0001" id="command" name="command"/><b>信息立即回传命令</b></td>
                      </tr>
                    </table>
                   
                   
                   <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                    <caption>锁车命令</caption>
                      <tr>
                <td><input type="radio" value="LK0001" id="command" name="command"/>解锁</td>   
                
                <td><input type="radio" value="LK3011" id="command" name="command"/>第一路立即锁车</td>   
                
                <td><input type="radio" value="LK3013" id="command" name="command"/>第一路判断锁车</td>   
                
                <td><input type="radio" value="LK3021" id="command" name="command"/>第二路立即锁车</td>   
                </tr><tr>
                <td><input type="radio" value="LK3023" id="command" name="command"/>第二路判断锁车</td>   
                
                <td><input type="radio" value="LK3031" id="command" name="command"/>第三路立即锁车</td>   
                
                <td><input type="radio" value="LK3033" id="command" name="command"/>第三路判断锁车</td>   
                
                <td><input type="radio" value="LK3041" id="command" name="command"/>第四路立即锁车</td>   
                </tr><tr>
                <td><input type="radio" value="LK3043" id="command" name="command"/>第四路判断锁车</td>   
                
                <td><input type="radio" value="LK30A1" id="command" name="command"/>所有路立即锁车</td>   
                
                <td><input type="radio" value="LK30A3" id="command" name="command"/>所有路判断锁车</td>   
                                    
                    </table>
                    
                    <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                    <caption>自锁车命令</caption>
                     <tr>
                <td><input type="radio" value="LK5001" id="command" name="command"/>所有类型自锁车&nbsp;
                      <select id="stateLK5001" name="stateLK5001">
                    <option value="00">禁止</option>
                    <option value="01">开启</option></select>
                        </td>
                
                <td><input type="radio" value="LK5005" id="command" name="command"/>总线通信异常&nbsp;
                      <select id="stateLK5005" name="stateLK5005">
                    <option value="00">禁止</option>
                    <option value="01">开启</option></select>
                        </td>
                
                <td><input type="radio" value="LK5011" id="command" name="command"/>GPS天线异常&nbsp;
                      <select id="stateLK5011" name="stateLK5011">
                    <option value="00">禁止</option>
                    <option value="01">开启</option></select>
                        </td>
                </tr><tr>
                <td><input type="radio" value="LK5015" id="command" name="command"/>开壳&nbsp;
                      <select id="stateLK5015" name="stateLK5015">
                    <option value="00">禁止</option>
                    <option value="01">开启</option></select>
                        </td>
                
                <td><input type="radio" value="LK5021" id="command" name="command"/>长时间不入网&nbsp;
                      <select id="stateLK5021" name="stateLK5021">
                    <option value="00">禁止</option>
                    <option value="01">开启</option></select>
                        </td>
                                    
                    </table>
                    
                    <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                    <caption>设备设置</caption>
                     
                      <tr>
                        <td><input type="radio" value="GE3007" id="command" name="command"/> 定时回传时间间隔设置&nbsp;&nbsp;&nbsp;&nbsp;
                        小时：<input type="text" value=" " name="hourGE3007"/>
                    分钟：<input type="text" value=" " name="minuteGE3007"/>
                    秒：<input type="text" value=" " name="secondGE3007"/></td>
                      </tr>
                      
                      <tr>
                        <td><input type="radio" value="GE3011" id="command" name="command"/> 工作小时设置&nbsp;&nbsp;&nbsp;&nbsp;
                        小时：<input type="text" value=" " name="hourGE3011"/>
                    分钟：<input type="text" value=" " name="minuteGE3011"/>
                    秒：<input type="text" value=" " name="secondGE3011"/></td>
                      </tr>
                      
                    </table>
                    
                    
                   
					<table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                    <caption>其他设置</caption>
					
					
                      <tr>
                        <td><input type="radio" value="GE3001" id="command" name="command"/>ID设置
                         <input type="text" size="15" maxlength="10" id="numGE3001" name="numGE3001"/></td>
                      </tr>
					  
					  
                      <tr>
                        <td><input type="radio" value="GE3005" id="command" name="command"/> 回传方式设置 回传方式：
                        <select id="returntype" name="returntype">
                        <option value="01">UDP方式</option>
                        <option value="02">TCP方式</option>
                        <option value="03">短信方式</option>
                        <option value="04">禁止任何方式</option>
                        </select> 
                        连接方式：
                       <select id="conntype" name="conntype">
                    <option value="00">域名连接方式</option>
                    <option value="01">IP连接方式</option></select></td>
                      </tr>
					  
					 
                      <tr>
                        <td>IP地址：
                        <input type="text" size="5" maxlength="3" id="ipaddress1" name="ipaddress1"/> 
                    <input type="text" size="5" maxlength="3" id="ipaddress2" name="ipaddress2"/> 
                    <input type="text" size="5" maxlength="3" id="ipaddress3" name="ipaddress3"/> 
                    <input type="text" size="5" maxlength="3" id="ipaddress4" name="ipaddress4"/> </td>
                      </tr>
                      <tr>
                        <td>域名地址：
                        <input size="30" type="text" id="domainaddress" name="domainaddress"/> 端口号：
<input type="text" size="5" maxlength="5" id="port" name="port"/></td>
                      </tr>
                      
					  
                       <tr>
                        <td><input type="radio" value="GE3015" id="command"  name="command"/>实时时间设置：
						<input type="text" size="20" id="popupDatepickera" name="receivetime" class="hasDatepick"/>
						 <select name="hourGE3015">
                
                 <option value="0">0</option>
                
                 <option value="1">1</option>
                
                 <option value="2">2</option>
                
                 <option value="3">3</option>
                
                 <option value="4">4</option>
                
                 <option value="5">5</option>
                
                 <option value="6">6</option>
                
                 <option value="7">7</option>
                
                 <option value="8">8</option>
                
                 <option value="9">9</option>
                
                 <option value="10">10</option>
                
                 <option value="11">11</option>
                
                 <option value="12">12</option>
                
                 <option value="13">13</option>
                
                 <option value="14">14</option>
                
                 <option value="15">15</option>
                
                 <option value="16">16</option>
                
                 <option value="17">17</option>
                
                 <option value="18">18</option>
                
                 <option value="19">19</option>
                
                 <option value="20">20</option>
                
                 <option value="21">21</option>
                
                 <option value="22">22</option>
                
                 <option value="23">23</option>
                
                 
                </select> 小时
                 <select name="minuteGE3015">
                 
                 <option value="0">0</option>
                
                 <option value="1">1</option>
                
                 <option value="2">2</option>
                
                 <option value="3">3</option>
                
                 <option value="4">4</option>
                
                 <option value="5">5</option>
                
                 <option value="6">6</option>
                
                 <option value="7">7</option>
                
                 <option value="8">8</option>
                
                 <option value="9">9</option>
                
                 <option value="10">10</option>
                
                 <option value="11">11</option>
                
                 <option value="12">12</option>
                
                 <option value="13">13</option>
                
                 <option value="14">14</option>
                
                 <option value="15">15</option>
                
                 <option value="16">16</option>
                
                 <option value="17">17</option>
                
                 <option value="18">18</option>
                
                 <option value="19">19</option>
                
                 <option value="20" selected="selected">20</option>
                
                 <option value="21">21</option>
                
                 <option value="22">22</option>
                
                 <option value="23">23</option>
                
                 <option value="24">24</option>
                
                 <option value="25">25</option>
                
                 <option value="26">26</option>
                
                 <option value="27">27</option>
                
                 <option value="28">28</option>
                
                 <option value="29">29</option>
                
                 <option value="30">30</option>
                
                 <option value="31">31</option>
                
                 <option value="32">32</option>
                
                 <option value="33">33</option>
                
                 <option value="34">34</option>
                
                 <option value="35">35</option>
                
                 <option value="36">36</option>
                
                 <option value="37">37</option>
                
                 <option value="38">38</option>
                
                 <option value="39">39</option>
                
                 <option value="40">40</option>
                
                 <option value="41">41</option>
                
                 <option value="42">42</option>
                
                 <option value="43">43</option>
                
                 <option value="44">44</option>
                
                 <option value="45">45</option>
                
                 <option value="46">46</option>
                
                 <option value="47">47</option>
                
                 <option value="48">48</option>
                
                 <option value="49">49</option>
                
                 <option value="50">50</option>
                
                 <option value="51">51</option>
                
                 <option value="52">52</option>
                
                 <option value="53">53</option>
                
                 <option value="54">54</option>
                
                 <option value="55">55</option>
                
                 <option value="56">56</option>
                
                 <option value="57">57</option>
                
                 <option value="58">58</option>
                
                 <option value="59">59</option>
                
                </select> 分
                 <select name="secondGE3015">
                   
                 <option value="0">0</option>
                
                 <option value="1">1</option>
                
                 <option value="2">2</option>
                
                 <option value="3">3</option>
                
                 <option value="4">4</option>
                
                 <option value="5">5</option>
                
                 <option value="6">6</option>
                
                 <option value="7">7</option>
                
                 <option value="8">8</option>
                
                 <option value="9">9</option>
                
                 <option value="10">10</option>
                
                 <option value="11">11</option>
                
                 <option value="12">12</option>
                
                 <option value="13">13</option>
                
                 <option value="14">14</option>
                
                 <option value="15">15</option>
                
                 <option value="16">16</option>
                
                 <option value="17">17</option>
                
                 <option value="18">18</option>
                
                 <option value="19">19</option>
                
                 <option value="20">20</option>
                
                 <option value="21">21</option>
                
                 <option value="22">22</option>
                
                 <option value="23">23</option>
                
                 <option value="24">24</option>
                
                 <option value="25">25</option>
                
                 <option value="26">26</option>
                
                 <option value="27">27</option>
                
                 <option value="28">28</option>
                
                 <option value="29">29</option>
                
                 <option value="30">30</option>
                
                 <option value="31">31</option>
                
                 <option value="32">32</option>
                
                 <option value="33">33</option>
                
                 <option value="34">34</option>
                
                 <option value="35">35</option>
                
                 <option value="36">36</option>
                
                 <option value="37">37</option>
                
                 <option value="38">38</option>
                
                 <option value="39">39</option>
                
                 <option value="40">40</option>
                
                 <option value="41">41</option>
                
                 <option value="42">42</option>
                
                 <option value="43">43</option>
                
                 <option value="44">44</option>
                
                 <option value="45">45</option>
                
                 <option value="46">46</option>
                
                 <option value="47">47</option>
                
                 <option value="48">48</option>
                
                 <option value="49">49</option>
                
                 <option value="50">50</option>
                
                 <option value="51">51</option>
                
                 <option value="52">52</option>
                
                 <option value="53">53</option>
                
                 <option value="54">54</option>
                
                 <option value="55">55</option>
                
                 <option value="56">56</option>
                
                 <option value="57">57</option>
                
                 <option value="58">58</option>
                
                 <option value="59">59</option>
                
                </select> 秒          
                </td>
                      </tr>
					  
					  
                       <tr>
                        <td><input type="radio" value="GE3017" id="command"  name="command"/>休眠时间设置：
                <select name="hourGEGE3017">
                
                 <option value="0">0</option>
                
                 <option value="1">1</option>
                
                 <option value="2">2</option>
                
                 <option value="3">3</option>
                
                 <option value="4">4</option>
                
                 <option value="5">5</option>
                
                 <option value="6">6</option>
                
                 <option value="7">7</option>
                
                 <option value="8">8</option>
                
                 <option value="9">9</option>
                
                 <option value="10">10</option>
                
                 <option value="11">11</option>
                
                 <option value="12">12</option>
                
                 <option value="13">13</option>
                
                 <option value="14">14</option>
                
                 <option value="15">15</option>
                
                 <option value="16">16</option>
                
                 <option value="17">17</option>
                
                 <option value="18">18</option>
                
                 <option value="19">19</option>
                
                 <option value="20">20</option>
                
                 <option value="21">21</option>
                
                 <option value="22">22</option>
                
                 <option value="23">23</option>
                
                 
                </select> 小时
                 <select name="minuteGE3017">
                 
                 <option value="0">0</option>
                
                 <option value="1">1</option>
                
                 <option value="2">2</option>
                
                 <option value="3">3</option>
                
                 <option value="4">4</option>
                
                 <option value="5">5</option>
                
                 <option value="6">6</option>
                
                 <option value="7">7</option>
                
                 <option value="8">8</option>
                
                 <option value="9">9</option>
                
                 <option value="10">10</option>
                
                 <option value="11">11</option>
                
                 <option value="12">12</option>
                
                 <option value="13">13</option>
                
                 <option value="14">14</option>
                
                 <option value="15">15</option>
                
                 <option value="16">16</option>
                
                 <option value="17">17</option>
                
                 <option value="18">18</option>
                
                 <option value="19">19</option>
                
                 <option value="20" selected="selected">20</option>
                
                 <option value="21">21</option>
                
                 <option value="22">22</option>
                
                 <option value="23">23</option>
                
                 <option value="24">24</option>
                
                 <option value="25">25</option>
                
                 <option value="26">26</option>
                
                 <option value="27">27</option>
                
                 <option value="28">28</option>
                
                 <option value="29">29</option>
                
                 <option value="30">30</option>
                
                 <option value="31">31</option>
                
                 <option value="32">32</option>
                
                 <option value="33">33</option>
                
                 <option value="34">34</option>
                
                 <option value="35">35</option>
                
                 <option value="36">36</option>
                
                 <option value="37">37</option>
                
                 <option value="38">38</option>
                
                 <option value="39">39</option>
                
                 <option value="40">40</option>
                
                 <option value="41">41</option>
                
                 <option value="42">42</option>
                
                 <option value="43">43</option>
                
                 <option value="44">44</option>
                
                 <option value="45">45</option>
                
                 <option value="46">46</option>
                
                 <option value="47">47</option>
                
                 <option value="48">48</option>
                
                 <option value="49">49</option>
                
                 <option value="50">50</option>
                
                 <option value="51">51</option>
                
                 <option value="52">52</option>
                
                 <option value="53">53</option>
                
                 <option value="54">54</option>
                
                 <option value="55">55</option>
                
                 <option value="56">56</option>
                
                 <option value="57">57</option>
                
                 <option value="58">58</option>
                
                 <option value="59">59</option>
                
                </select> 分
                </td>
                      </tr>
					  
					  
                       <tr>
             <td><input type="radio" value="GE3021" id="command"  name="command"/>不入网自锁车时间间隔设置：
             <input  type="text" size="5" maxlength="2" name="numGE3021"/> 天</td>
                      </tr>
					  
					  
                      <tr>
                        <td><input type="radio" value="GE3013" id="command"  name="command"/>监控状态设置：
                        
                        <select id="stateGE3013" name="stateGE3013">
                    <option value="00">监控</option>
                    <option value="01">不监控</option></select>
                        
                        </td>
                      </tr>
					  
                    </table>
					
					
					
					 <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                      <tr>
                        <td><input type="radio" value="GE0003" id="command" name="command"/><b>系统重启</b></td>
                      </tr>
                    </table>
                    
                    
                    <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                      <tr>
                        <td><input type="radio" value="GE0020" id="command" name="command"/><b>系统重启次数回传</b></td>
                      </tr>
                    </table>
					
					
                    <table width="780" border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                      <tr>
                        <td><input type="radio" value="GE0021" id="command" name="command"/><b>日统计信息回传</b></td>
                      </tr>
                    </table>
					
					
					 <ul class="control_e" style="margin-left:330px;">
                     	<li class="ok_e"><a href="javascript:document.forms['form1'].submit();" target="_self">发送</a></li>
                    </ul>
                    </form>
                    </div>
                    <s class="r2"></s><s class="r1"></s>
                </div>
                <div class="clear"></div>
                
                
 
            </div>
            <div class="clear"></div>
        </div>
        <div class="bottom_a">&nbsp;</div>
    </div>
</div>
 
 
<div class="footer">
 
<p class="copyright">Copyright © 2004-2010 waitandhope.gicp.net <!--  <span>有限公司版权所有</span>--></p>
</div>
<script type="text/javascript"> 
	showtable("data_list_sty1",1);
</script>
 
</body>
</html>
<script type=text/javascript> 
		function validate()
		{
			return true;
		}		
</script>
