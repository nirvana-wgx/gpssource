<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
	<head>

		<title>报表图</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/plugs/My97DatePicker/WdatePicker.js"></script>
	  <style type="text/css">
	  *{
	  maring:0px;
	  padding:0px;
	  border:0px;
	  }
	  div{
	  	width:100%;
	  }
	   #div_search{
		   width:100%;
		   height:50px;
	   } 
	   #div_char{
	      text-align:center;
		   width:100%;
		   height:400px;
		   overflow-x:visible;
	   } 
	   table {
	width: 100%;
}
table td {
	border-right: 1px solid #CCCCFF;
	border-bottom: 1px solid #CCCCFF;
	border-top: 1px solid #CCCCFF;
	border-left: 1px solid #CCCCFF;
	background: #fff;
	font-size: 12px;
	padding: 1px 1px 1px 1px;
	color: #5C5C5C;
	font-weight: normal;
	text-align: center;
}
	  td.left {
	text-align: right;
}

td.right {
	text-align: left;
} 
	   
	   
	  </style>
	</head>
	<body>
		<div>
			<div id="div_search">
					<form name="form1" method="post" 
					    action="<%=path%>/jsp/statisanaly/${ servletName }.page?deviceid=${ deviceid }&vehicleid=${ vehicleid }" 
					       target="imageFrame">
						<table style="border-collapse:collapse;border-spacing:0;width:100%">
								<tr>
									<td style="text-align:right;width:80px;">
									 开始日期: 
									</td>
									<td style="text-align:left;">
										<input class="Wdate" type="text" id="startdate"
											name="startdate" value="${ startdate }"
											<c:if test="${ servletName == 'DailyWorkTime' || servletName == 'DailyWorkMile' }">
											   onFocus="WdatePicker({isShowClear:false,readOnly:true})" 
											</c:if>
											<c:if test="${ servletName == 'MonthWorkTime' || servletName == 'MonthWorkMile' }">
                                    onfocus="WdatePicker({dateFmt:'yyyy-MM',readOnly:true})" 
                                 </c:if>
										/>
									</td>
									<td style="text-align:right;width:80px;">
										 结束日期: 
									</td>
									<td style="text-align:left;">
										<input class="Wdate" type="text" id="enddate" name="enddate"
											name="enddate" value="${ enddate }"
											<c:if test="${ servletName == 'DailyWorkTime' || servletName == 'DailyWorkMile' }">
											    onFocus="WdatePicker({isShowClear:false,readOnly:true})"
											</c:if>
											<c:if test="${ servletName == 'MonthWorkTime' || servletName == 'MonthWorkMile' }">
                                    onfocus="WdatePicker({dateFmt:'yyyy-MM',readOnly:true})" 
                                 </c:if>
									    />
									</td>
									<td>
										<a href="javascript:document.forms['form1'].submit();" onclick="" id="btn_add"> <span
											class="toolbar_btn"> <span
												class="toolbar_btn_ico toolbar_btn_search">查询</span> </span> </a>
									</td>
								</tr>
						</table>
					</form>
			</div>
			<div id="div_char">
				<img src="${ chartfilename }" />
			</div>
		</div>

		<script type="text/javascript">
function validate()
{
   if(document.getElementById("startdate").value=="")
   {
    alert("请输入开始日期！");  
    return false;
   }
   if(document.getElementById("enddate").value=="")
   {
    alert("请输入结束日期！");  
    return false;
   }
   return true;
}
function querryInfo(){
   var startdate=document.getElementById("startdate").value;
   var enddate=document.getElementById("enddate").value;
   document.form1.action="";
   document.form1.submit();
}
</script>

	</body>
</html>