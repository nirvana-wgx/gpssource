<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
 
%>
<!DOCTYPE html>
<html>
	<head>
		<title>指令下发</title>
		<script type="text/javascript"
			src="<%=path %>/scripts/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=path %>/plugs/My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" href="<%=path%>/css/toolbars.css"
			type="text/css" media="all" />
		<style type="text/css">
body {
	font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica,
		sans-serif;
	color: #4f6b72;
	/*background: #E6EAE9;*/
}

caption {
	font: bold 18px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
	color: #000000;
	text-align: left;
	border-right: 0px solid #CCCCFF;
	border-bottom: 1px solid #CCCCFF;
	background: #fff;
	font-size: 12px;
	padding: 6px 6px 6px 12px;
}

#caption_top {
	margin-top: 20px;
	border-top: 1px solid #CCCCFF;
}

table {
	width: 100%;
}

.commandsend_tab td {
	border-right: 1px solid #CCCCFF;
	border-bottom: 1px solid #CCCCFF;
	background: #fff;
	font-size: 12px;
	padding: 6px 6px 6px 12px;
	color: #000000;
	font-weight: normal;
}

#tab_side {
	border-right: 0px;
}

#tab_side_1 {
	border-right: 0px;
}

#tab_side span {
	margin: 0px;
	padding: 0px;
	display: block;
	width: 30%;
	float: left;
}

fieldset {
	border: 1px solid #CCCCFF;
	border-bottom: 0px solid #CCCCFF;
	font-size: 15px;
	font-weight: bolder;
	color: #000000;
}

fieldset legend {
	color: #000000;
}

#main {
	width: 99%;
	margin-left: 5px;
}

.inputTxt {
	width: 35px;
}
/*处理时间控件位置偏移*/
div {
    border-left: 0px;
    border-top: 0px;
    margin-left: 0px;
    width: 0%;
}
</style>
<script type="text/javascript">
    function btn_close(){
        window.close();
    }
    function btn_ok(){
       var command =$("input:radio:checked").val();
       if($.trim(command)==""){
       		alert("指令不能为空");
       		return ;
       }
    	var str = $("form").serialize();
        window.returnValue = str;
        window.close();
    }
</script>
	</head>

	<body>

		<div id="main">
			<form  method="post">
				<fieldset>
					<legend>
						指令下发
					</legend>
					<table style="border-collapse:collapse;border-spacing:0;"
						class="commandsend_tab">
						<tr>
							<td id="tab_side">
								<span>车辆编号<input type="text" name="vehicleid" value="${car.vehicleid}"
										readonly> </span>
								<span>设备号<input type="text" name="deviceid" value="${car.deviceid}"
										readonly> </span>
								<span>SIM卡号<input type="text" name="sim"
										value="${car.sim}" readonly> </span>
							</td>
						</tr>
					</table>
					<table style="border-collapse:collapse;border-spacing:0;"
						class="commandsend_tab">
						<caption>
							上传模式设置
						</caption>
						<tr>
						    
							<td id="tab_side">
							<c:forEach var ="dictionary" items ="${list_scms}">
							<c:choose>
							<c:when test="${dictionary.d_code=='GL0001'}">
							<span><input type="radio" value="${dictionary.d_code}" name="command" />
									${dictionary.d_value }</span>
							</c:when>
							<c:when test="${dictionary.d_code=='GL0002'}">
							<span><input type="radio" value="${dictionary.d_code}" name="command" />
									${dictionary.d_value }
									&nbsp;&nbsp;--间隔时间
							<select id="stateGL0002" name="stateGL0002">
										<option  value="1">
											1分钟
										</option>
										<option  value="5">
											5分钟
										</option>
										<option  value="10">
											10分钟
										</option>
										<option  value="20">
											20分钟
										</option>
										<option  value="60">
											1小时
										</option>
										<option  value="300">
											5小时
										</option>
										<option  value="720">
											12小时
										</option>
							</select>
							</span>
							</c:when>
						    </c:choose>
							</c:forEach>
							</td>
							
						</tr>
					</table>
					
					<table>
						<tr>
							<td align="center" colspan="4">
								<a href="javascript:void(0)" onclick="btn_ok();" id="btn_ok"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_ok">下发</span> </span></a>
								<a href="javascript:void(0)" onclick="btn_close();" id="btn_clear"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_cancel">关闭</span></span></a>
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>

	</body>
</html>