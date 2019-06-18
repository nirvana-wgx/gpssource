<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML>
<html>
   <head>
    
      <title>车辆保养信息</title>
    
	  <meta http-equiv="pragma" content="no-cache">
	  <meta http-equiv="cache-control" content="no-cache">
	  <!--
	  <link rel="stylesheet" type="text/css" href="styles.css">
	  -->
      <link href="<%=path%>/css/toolbars.css" rel="stylesheet" type="text/css" />
      <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
      <script type="text/javascript" src="<%=path%>/plugs/My97DatePicker/WdatePicker.js"></script>
      <script type="text/javascript" src="<%=path%>/scripts/jquery-1.7.1.min.js"></script>
   
      <style type="text/css">
         body { 
            background: #E6EAE9;
         }
         #div_list{
            height:auto;
         }
      </style>

   </head>
   <body>
      <div>
         
         <form id="serform" action="<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1"  method="post">
            <input id="deviceid" name="deviceid" type="hidden" value="${ deviceid }"/>
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
<!--                   <td style="text-align:right;">车辆编号</td> -->
<!--                   <td> -->
<!--                      <input id="vehicleid" name="vehicleid" type="text" value="${ vehicleid }" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''"/> -->
<!--                   </td> -->
                  <td style="text-align:right;">保养配件</td>
                  <td>
                     
                     <input id="fitting" name="fitting" type="text" value="${ fitting }" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''"/>
                  </td>
                  <td style="text-align:right;">保养日期</td>
                  <td>
                     <input class="Wdate" type="text" id="maintenancedate" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''" name="maintenancedate" value="${ maintenancedate }" onFocus="WdatePicker({isShowClear:false,readOnly:false})"/>
                  </td>
<!--                   <td style="text-align:right;">是否超时</td> -->
<!--                   <td> -->
<!--                      <select id="isovertime" name="isovertime" onmouseover="this.style.border='1px solid green'" onmouseout="this.style.border=''"> -->
<!--                         <option value="" -->
<!-- 	                           <c:if test="${ isovertime == '' || isovertime == null }"> -->
<!-- 	                              selected -->
<!-- 	                           </c:if> -->
<!--                            >不限 -->
<!--                         </option> -->
<!--                         <option value="0" -->
<!--                               <c:if test="${ isovertime == '0' }"> -->
<!--                                  selected -->
<!--                               </c:if> -->
<!--                             >否 -->
<!--                          </option> -->
<!--                         <option value="1" -->
<!--                               <c:if test="${ isovertime == '1' }"> -->
<!--                                  selected -->
<!--                               </c:if> -->
<!--                            >是 -->
<!--                         </option> -->
<!--                      </select> -->
<!--                   </td> -->
                  <td>
                     <a href="javascript:document.forms['serform'].submit();" onclick="" id="btn_add"> <span
                        class="toolbar_btn"><span
                           class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
                     <a href="javascript:reset();" onclick="reset();" id="btn_add"><span
                        class="toolbar_btn"><span
                           class="toolbar_btn_ico toolbar_btn_clear">重置</span>
                     </span></a>
                  </td>
               </tr>
            </table>
      
            <table style="border-collapse:collapse;border-spacing:0;">
               <tr>
                  <td class="left" colspan="99" style="height:20px;border-bottom:0px;">
                     <a href="javascript:exportExcel();">导出</a>&nbsp;&nbsp;&nbsp;&nbsp;
                  </td>
               </tr>
               <tr>
                  <td colspan="99" style="border-bottom:0px;">
                     <div id="div_list">
                        <table id="tab_list" style="border-collapse:collapse;border-spacing:0;">
                           <tr>
                              <th scope="col" abbr="序号" style="border-left:0px;">序号</th>
                              <th scope="col" abbr="机号">机号</th>
                              <th scope="col" abbr="保养配件">保养配件</th>
                              <th scope="col" abbr="预警时间">预警日期</th>
                              <th scope="col" abbr="保养时间">保养日期</th>
                              <th scope="col" abbr="保养动作">保养动作</th>
                              <th scope="col" abbr="保养完成日期">保养完成日期</th>
<!--                               <th scope="col" abbr="是否超时">是否超时</th> -->
                              <th scope="col" abbr="操作" style="border-right:0px;">操作</th>
                           </tr>
                           
                           <c:if test="${fn:length(maintenancelist)==0}">
                              <tr><td align='center' colspan='10' style="border-left:0px;border-right:0px;"><font color='red'>无记录</font></td></tr>
                           </c:if>
                           
                           <c:forEach items="${maintenancelist}" var="maintenance" varStatus="status">
                              <tr>
                                 <th scope="row" abbr="序号" style="border-left:0px;">
                                    ${(page_no - 1) * page_num + status.index + 1}
                                 </th>
                                 <td>
                                    ${ maintenance.vehicleid }
                                 </td>
                                 <td>
                                    ${ maintenance.fitting }
                                 </td>
                                 <td>
                                    <fmt:formatDate value="${ maintenance.expiretime }" pattern="yyyy年MM月dd日"/>
                                 </td>
                                 <td>
                                    <fmt:formatDate value="${ maintenance.maintenancetime }" pattern="yyyy年MM月dd日"/>
                                 </td>
                                 <td>
                                    ${ maintenance.action }
                                 </td>
                                 <td>
                                    <fmt:formatDate value="${ maintenance.finishtime }" pattern="yyyy年MM月dd日"/>
                                 </td>
<!--                                  <td <c:if test="${status.index%2 == 1}">class="alt"</c:if>> -->
<!--                                     <c:if test="${ maintenance.isovertime == 0}">否</c:if> -->
<!--                                     <c:if test="${ maintenance.isovertime == 1}">是</c:if> -->
<!--                                  </td> -->
                                 <td style="border-right:0px;">
                                    <c:choose>
                                       <c:when test="${ maintenance.action == '完成保养' }">
                                          已完成
                                       </c:when>
	                                    <c:otherwise>
	                                       <a id="${ maintenance.maid }" href="javascript:finish(${ maintenance.maid });" style="color:#0080FF" onmouseover="this.style.color='#ff3000'" onmouseout="this.style.color='#0080FF';">完成保养</a>
	                                    </c:otherwise>
	                                 </c:choose>
                                 </td>
                              </tr>
                           </c:forEach>
                        </table>
                     </div>
            
                  </td>
               </tr>
            
               <tr>
                  <td colspan="99" class="jpaginate">
                     <a href="javascript:gotofirst();"><img src="<%=path%>/images/sprevious.png" /></a>
                     <a href="javascript:gotoback();"><img src="<%=path%>/images/previous.png" /></a>
                     <span>第<input id="go_page_no" type="text" value="${ page_no }" />页/${ tot_page }页</span>
                     <a href="javascript:gotonext();"><img src="<%=path%>/images/next.png" /></a>
                     <a href="javascript:gotolast();"><img src="<%=path%>/images/snext.png" /></a> 
                     <span>每页<input id="page_num" type="text" value="${ page_num }" />条</span>
                     <a href="javascript:gotopage();"><img src="<%=path%>/images/Refresh.gif"/></a>
                     <input id="tot_page" type="hidden" value="${ tot_page }"/>
                     <input id="page_no" type="hidden" value="${ page_no }"/>
                  </td>
               </tr>
            </table>
         </form>
      </div>
   </body>
   
<script type="text/javascript">
	function gotofirst() {
	   var deviceid = document.getElementById("deviceid").value;
	   var fitting = document.getElementById("fitting").value;
// 	   var isovertime = document.getElementById("isovertime").value;
	   var maintenancedate = document.getElementById("maintenancedate").value;
	   var page_no = 1;
	   var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=" + "&page_no=" + page_no + "&page_num=" + page_num;
	}
	
	function gotoback() {
	   var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
//       var isovertime = document.getElementById("isovertime").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
	   var page_no = Number(document.getElementById("page_no").value) - 1;
	   if(page_no <= 0) {
	      page_no = 1;
	   }
	   var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=" + "&page_no=" + page_no + "&page_num=" + page_num;
	}
	
	function gotonext() {
	   var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
//       var isovertime = document.getElementById("isovertime").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
	   var page_no = Number(document.getElementById("page_no").value) + 1;
	   var tot_page = Number(document.getElementById("tot_page").value);
	   if(page_no > tot_page) {
	      page_no = tot_page;
	   }
	   var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=" + "&page_no=" + page_no + "&page_num=" + page_num;
	}
	
	function gotolast() {
	   var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
//       var isovertime = document.getElementById("isovertime").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
	   var page_no = document.getElementById("tot_page").value;
	   var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=" + "&page_no=" + page_no + "&page_num=" + page_num;
	}
	
	function gotopage() {
	   var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
//       var isovertime = document.getElementById("isovertime").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
	   var page_no = Number(document.getElementById("go_page_no").value);
	   var tot_page = Number(document.getElementById("tot_page").value);
	   if(page_no > tot_page) {
	      page_no = tot_page;
	   } else if(page_no <= 0) {
	      page_no = 1;
	   }
	   var page_num = document.getElementById("page_num").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfo.page?type=1" + "&deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=" + "&page_no=" + page_no + "&page_num=" + page_num;
	}
	
	function reset() {
      document.getElementById("fitting").value = "";
      document.getElementById("maintenancedate").value = "";
	}
	
	function finish(obj) {
		var msgw,msgh,bordercolor;
		msgw=300;//提示窗口的宽度
		msgh=132;//提示窗口的高度
		titleheight=15 //提示窗口标题高度
		bordercolor="#CCCCFF";//提示窗口的边框颜色
		titlecolor="#CCCCFF";//提示窗口的标题颜色
		
		var sWidth,sHeight;
		sWidth=window.screen.width; //得出当前屏幕的宽
		sHeight=screen.height;//得到当前屏幕的高
		
		var bgObj=document.createElement("div");//创建一个div对象
		bgObj.setAttribute('id','bgDiv');//可以用bgObj.id="bgDiv"的方法，是为div指定属性值
		bgObj.style.position="absolute";//把bgDiv这个div绝对定位
		bgObj.style.top="0";//顶部为0
		bgObj.style.background="#777";//背景颜色
		bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75)";//ie浏览器透明度设置
		bgObj.style.opacity="0.6";//透明度(火狐浏览器中)
		bgObj.style.left="0";//左边为0
		bgObj.style.width=sWidth + "px";//宽(上面得到的屏幕宽度)
		bgObj.style.height=sHeight + "px";//高(上面得到的屏幕高度)
		bgObj.style.zIndex = "100";//层的z轴位置
		document.body.appendChild(bgObj);
		
		var msgObj=document.createElement("div")//创建一个div对象
		msgObj.setAttribute("id","msgDiv");//可以用bgObj.id="msgDiv"的方法，是为div指定属性值
		msgObj.setAttribute("align","center");//为div的align赋值
		msgObj.style.background="white";//背景颜色为白色
		msgObj.style.border="1px solid " + bordercolor;//边框属性，颜色在上面已经赋值
		msgObj.style.position = "absolute";//绝对定位
		msgObj.style.left = "35%";//从左侧开始位置
		msgObj.style.top = "30%";//从上部开始位置
		msgObj.style.font="12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";//字体属性
		msgObj.style.width = msgw + "px";//提示框的宽(上面定义过)
		msgObj.style.height =msgh + "px";//提示框的高(上面定义过)
		msgObj.style.textAlign = "center";//文本位置属性，居中。
		msgObj.style.lineHeight ="25px";//行间距
		msgObj.style.zIndex = "101";//层的z轴位置
		
		var title=document.createElement("h4");//创建一个h4对象
		title.setAttribute("id","msgTitle");//为h4对象填加标题
		title.setAttribute("align","center");//文字对齐方式
		title.style.margin="0";//浮动
		title.style.padding="3px";//浮动
		title.style.background=titlecolor;//背景颜色
		title.style.filter="progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
		title.style.opacity="0.75";//透明
		//title.style.border="1px solid " + bordercolor;//边框
		title.style.height="25px";//高度
		title.style.font="12px Verdana, Geneva, Arial, Helvetica, sans-serif";//字体属性
		title.style.color="white";//文字颜色
		title.innerHTML="请输入备注";//显示的文字
		document.body.appendChild(msgObj);//在body中画出提示框层
		document.getElementById("msgDiv").appendChild(title);//在提示框中增加标题
		
		//输入框层
		var inputdiv = document.createElement("div");
		inputdiv.style.position = "absolute";
		inputdiv.setAttribute("id", "contdiv");
		inputdiv.style.width = "98%";
		inputdiv.style.height = "40px";
		inputdiv.style.border = "0px";
		inputdiv.style.backgroundColor = "white";
		inputdiv.style.zIndex = "1001";//数字越大，div在前面
		document.getElementById("msgDiv").appendChild(inputdiv);
		
		//文本框
		var contput = document.createElement("input");
		contput.setAttribute("id", "message");
		contput.type = "text";
		contput.style.marginTop = "20px";
		contput.style.width = "150px";
		contput.style.position = "relative";
		document.getElementById("contdiv").appendChild(contput);
		
		//确定层
		var buttondiv = document.createElement("div");
		buttondiv.style.position = "absolute";
		buttondiv.setAttribute("id", "btndiv");
		buttondiv.style.marginTop = "60px";
		buttondiv.style.width = "98%";
		buttondiv.style.height = "40px";
		buttondiv.style.border = "0px";
		buttondiv.style.backgroundColor = "white";
		buttondiv.style.zIndex = "1001";//数字越大，div在前面
		document.getElementById("msgDiv").appendChild(buttondiv);
		
		//确定
		var btnok = document.createElement("input");
		btnok.id = "ok";
		btnok.type = "button";
		btnok.value = "确 定";
		btnok.style.position = "relative";
		btnok.onclick = function () {
		   var remark = document.getElementById("message").value;
	      if(remark == "" || remark == null){
	          alert("请输入备注");
	          return;
	      }
	      var str = "maid=" + obj + "&remark=" + remark;
	      $.ajax({
	         url:"FinishMaintenace.page",
	         type:"POST",
	         dataType:"json",
	         data:str,
	         success:function(data){
	           if(data.message=="0"){
	              alert("保养失败!");
	           }else{
	              alert("保养完成!");
	              gotofirst();
	           }
	         }
	      
	      });
		};
		document.getElementById("btndiv").appendChild(btnok);
		
		var btncl = document.createElement("input");
		btncl.id = "cancle";
		btncl.type = "button";
		btncl.value = "取 消";
		btncl.style.position = "relative";
		btncl.style.marginLeft = "83px";
		btncl.onclick = function () {
		   document.body.removeChild(msgObj);//移除弹出框
		   document.body.removeChild(bgObj);//移除用户锁屏的div层
		};
		document.getElementById("btndiv").appendChild(btncl);
   }
   
   function exportExcel() {
	   var deviceid = document.getElementById("deviceid").value;
      var fitting = document.getElementById("fitting").value;
//       var isovertime = document.getElementById("isovertime").value;
      var maintenancedate = document.getElementById("maintenancedate").value;
      window.location.href = "<%=path%>/jsp/vechiclemanager/singlevehicle/MaintenaceInfDownload.page?" + "deviceid=" + deviceid + "&fitting=" + fitting + "&maintenancedate=" + maintenancedate + "&isovertime=";
	}

</script>
</html>
