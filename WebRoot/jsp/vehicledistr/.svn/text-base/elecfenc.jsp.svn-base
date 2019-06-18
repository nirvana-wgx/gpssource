<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'elecfenc.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div align="center"> 
 
<table border="0" cellpadding="0" cellspacing="0" width="100%"> 
    <tbody><tr> 
        <td id="tdLeft" width="270"> 
            <table class="tbmine" border="0" cellpadding="0" cellspacing="0" width="100%"> 
                <tbody><tr> 
                    <td id="tdMenu1" align="center" height="30" valign="bottom" width="50%"><span id="tm1" onclick="setlist(1)" class="mine">我的区域</span></td> 
                    <td id="tdMenu2" align="center" height="30" valign="bottom" width="50%"><span id="tm2" onclick="setlist(2)" class="mine_ck">我的设备</span></td> 
                </tr> 
            </tbody></table> 
            <div style="height: 524px;" id="left_list"> 
                <div id="dv_Object" class="find"> 
                    <table border="0" cellpadding="0" cellspacing="0" width="100%"> 
                        <tbody><tr> 
                            <td align="center" width="80"> 
                                <select id="sltQueryBy" onchange="clearKey()"> 
                                    <option value="1" selected="selected">设备名称</option> 
                                    <option value="2">所属用户</option> 
                                    <option value="3">IMEI/ID</option> 
                                    <option value="4">SIM卡号</option> 
                                </select> 
                            </td> 
                            <td width="138"> 
                                <div> 
                                    <div> 
                                        <input id="txtKey" name="txtKey" onkeyup="searchObjects(this.value)" onclick="searchObjects(this.value)" type="text"> 
                                    </div> 
                                    <div id="layList" class="list_like"></div><input id="hid_ObjectID" name="hid_ObjectID" type="hidden"> 
                                </div> 
                            </td> 
                            <td align="center"><input value="查询" class="btn" onclick="search()" type="button"></td> 
                        </tr> 
                    </tbody></table> 
                </div> 
                <div id="dv_Weilan" class="find" style="display:none;"> 
                    <input id="txtKey1" name="txtKey1" class="txt" style="width:210px;" type="text"> 
                    <input value="查询" class="btn" onclick="search()" type="button"> 
                </div> 
                <div style="padding-top:7px;"> 
                    <table class="head_tit" border="0" cellpadding="0" cellspacing="0"> 
                        <tbody><tr> 
                            <td class="first" align="center" width="40"><input id="cbxAnti" onclick="setAnti(this,'')" type="checkbox"></td> 
                            <td align="center"><span id="spnName">设备名称</span></td> 
                            <td id="td_type" style="display:none;" align="center" width="50"><span id="spnName">类型</span></td> 
                            <td style="width: 70px;" id="td_op" align="center" width="50"><span id="spnState">电子围栏</span></td> 
                        </tr> 
                    </tbody></table> 
                </div> 
                <div> 
                    <table id="ff" border="0" cellpadding="0" cellspacing="0"><tbody><tr id="tr_49042" style="background-color: rgb(240, 237, 237); cursor: pointer;" onmouseover='over1("tr_49042")' onmouseout='out1("tr_49042","#f0eded")'><td align="center" height="25" width="40"><input id="cbxObject49042" name="cbxObject" value="49042" type="checkbox"></td><td onclick='setObjectLocate(49042,"#f0eded")' align="left">&nbsp;丁</td><td align="center" width="70">已设置</td></tr><tr id="tr_35290" style="background-color: rgb(255, 255, 255); cursor: pointer;" onmouseover='over1("tr_35290")' onmouseout='out1("tr_35290","#FFFFFF")'><td align="center" height="25" width="40"><input id="cbxObject35290" name="cbxObject" value="35290" type="checkbox"></td><td onclick='setObjectLocate(35290,"#FFFFFF")' align="left">&nbsp;小杨</td><td align="center" width="70">已设置</td></tr><tr id="tr_35291" style="background-color: rgb(240, 237, 237); cursor: pointer;" onmouseover='over1("tr_35291")' onmouseout='out1("tr_35291","#f0eded")'><td align="center" height="25" width="40"><input id="cbxObject35291" name="cbxObject" value="35291" type="checkbox"></td><td onclick='setObjectLocate(35291,"#f0eded")' align="left">&nbsp;352000000002576</td><td align="center" width="70">未设置</td></tr><tr id="tr_55946" style="background-color: rgb(255, 255, 255); cursor: pointer;" onmouseover='over1("tr_55946")' onmouseout='out1("tr_55946","#FFFFFF")'><td align="center" height="25" width="40"><input id="cbxObject55946" name="cbxObject" value="55946" type="checkbox"></td><td onclick='setObjectLocate(55946,"#FFFFFF")' align="left">&nbsp;T1S-32190</td><td align="center" width="70">未设置</td></tr><tr id="tr_35292" style="background-color: rgb(240, 237, 237); cursor: pointer;" onmouseover='over1("tr_35292")' onmouseout='out1("tr_35292","#f0eded")'><td align="center" height="25" width="40"><input id="cbxObject35292" name="cbxObject" value="35292" type="checkbox"></td><td onclick='setObjectLocate(35292,"#f0eded")' align="left">&nbsp;WXB138</td><td align="center" width="70">未设置</td></tr><tr id="tr_35431" style="background-color: rgb(255, 255, 255); cursor: pointer;" onmouseover='over1("tr_35431")' onmouseout='out1("tr_35431","#FFFFFF")'><td align="center" height="25" width="40"><input id="cbxObject35431" name="cbxObject" value="35431" type="checkbox"></td><td onclick='setObjectLocate(35431,"#FFFFFF")' align="left">&nbsp;旅游大巴</td><td align="center" width="70">未设置</td></tr><tr id="tr_35433" style="background-color: rgb(240, 237, 237); cursor: pointer;" onmouseover='over1("tr_35433")' onmouseout='out1("tr_35433","#f0eded")'><td align="center" height="25" width="40"><input id="cbxObject35433" name="cbxObject" value="35433" type="checkbox"></td><td onclick='setObjectLocate(35433,"#f0eded")' align="left">&nbsp;文</td><td align="center" width="70">未设置</td></tr><tr id="tr_35432" style="background-color:#FFFFFF;cursor:pointer;" onmouseover='over1("tr_35432")' onmouseout='out1("tr_35432","#FFFFFF")'><td align="center" height="25" width="40"><input id="cbxObject35432" name="cbxObject" value="35432" type="checkbox"></td><td onclick='setObjectLocate(35432,"#FFFFFF")' align="left">&nbsp;杨冪</td><td align="center" width="70">未设置</td></tr><tr id="tr_35288" style="background-color:#f0eded;cursor:pointer;" onmouseover='over1("tr_35288")' onmouseout='out1("tr_35288","#f0eded")'><td align="center" height="25" width="40"><input id="cbxObject35288" name="cbxObject" value="35288" type="checkbox"></td><td onclick='setObjectLocate(35288,"#f0eded")' align="left">&nbsp;李栋00</td><td align="center" width="70">未设置</td></tr></tbody></table> 
                </div> 
                <div class="pag"> 
                    <a href="javascript:setPage(1);" class="mp">首页</a><span class="mmu"></span><a href="javascript:setPage(2);" class="mp">上一页</a><span class="mmu"></span>(<span id="lblCurrect">1</span>/<span id="lblCount">1</span>)<span class="mmu"></span><a href="javascript:setPage(3);" class="mp">下一页</a><span class="mmu"></span><a href="javascript:setPage(4);" class="mp">尾页</a> 
                </div> 
            </div> 
        </td> 
        <td width="8"> 
            <table id="tdPart" style="background-color: rgb(218, 234, 220); height: 554px;" border="0" cellpadding="0" cellspacing="0" width="100%"> 
                <tbody><tr> 
                    <td align="center" height="100%" valign="middle" width="100%"><img id="imgDisplay" src="MainArea_data/hidePart.gif" alt="隐藏栏目" onclick="setModelStatus()" style="cursor:pointer;"></td> 
                </tr> 
            </tbody></table> 
        </td> 
        <td id="tbMain"> 
            <iframe style="width: 1026px; height: 554px;" id="ifrMap" src="MainArea_data/MapGoogle.htm" frameborder="0" height="100%" scrolling="no" width="100%"></iframe> 
        </td> 
    </tr> 
</tbody></table> 
    
<div style="display: none;" id="divWaitLoadingData" class="div_Waitloading"> 
    <table width="100%"> 
        <tbody><tr> 
            <td align="center" height="45" width="45"><img src="MapForm_data/progress_loading.gif" border="0" height="32" width="32"></td> 
            <td align="left"><span>正在努力为您加载,马上就好...</span></td> 
        </tr> 
    </tbody></table> 
</div> 
    
</div> 
  </body>
</html>
