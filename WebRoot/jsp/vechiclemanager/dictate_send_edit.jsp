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
							下发命令设置
						</caption>
						<tr>
							<td id="tab_side">
							<c:forEach var ="dictionary" items ="${list_xfml}">
							<span><input type="radio" value="${dictionary.d_code}" name="command" />
									${dictionary.d_value }</span>
							</c:forEach>
							<!--
								<span><input type="radio" value="GE0001" name="command" />
									信息立即回传命令</span>
								<span><input type="radio" value="GE0003" name="command" />
									系统重启</span>
								<span><input type="radio" value="GE0020" name="command" />
									系统重启次数回传</span>
							--></td>
						</tr>
					</table>
					<table style="border-collapse:collapse;border-spacing:0;"
						class="commandsend_tab">
						<caption>
							锁车命令
						</caption>
						<tr>
							<td id="tab_side">
							<c:forEach var="dictionary" items="${list_scml}">
									<span><input type="radio" value="${dictionary.d_code }" name="command" />${dictionary.d_value}</span>
							</c:forEach>
								<!--<span><input type="radio" value="LK0001" name="command" />解锁</span>
								<span><input type="radio" value="LK3011" name="command" />第一路立即锁车</span>
								<span><input type="radio" value="LK3013" name="command" />第一路判断锁车</span>
								<span><input type="radio" value="LK3021" name="command" />第二路立即锁车</span>
								<span><input type="radio" value="LK3023" name="command" />第二路判断锁车</span>
								<span><input type="radio" value="LK3031" name="command" />第三路立即锁车</span>
								<span><input type="radio" value="LK3033" name="command" />第三路判断锁车</span>
								<span><input type="radio" value="LK3041" name="command" />第四路立即锁车</span>
								<span><input type="radio" value="LK3043" name="command" />第四路判断锁车</span>
								<span><input type="radio" value="LK30A1" name="command" />所有路立即锁车</span>
								<span><input type="radio" value="LK30A3" name="command" />所有路判断锁车</span>
							--></td>
					</table>

					<table style="border-collapse:collapse;border-spacing:0;"
						class="commandsend_tab">
						<caption>
							自锁车命令
						</caption>
						<tr>
							<td id="tab_side">
							
							<c:forEach var="dictionary" items="${list_zscml}">
							
							<span><input type="radio" value="${dictionary.d_code }" name="command" />
									${dictionary.d_value} <select id="${dictionary.d_code }" name="${dictionary.d_code }">
										<option  value="00">
											禁止
										</option>
										<option  value="01">
											开启
										</option>
									</select> </span>
							</c:forEach>
								<!--<span><input type="radio" value="LK5001" name="command" />
									所有类型自锁车 <select id="stateLK5001" name="stateLK5001">
										<option  value="00">
											禁止
										</option>
										<option  value="01">
											开启
										</option>
									</select> </span>
								<span><input type="radio" value="LK5005" name="command" />
									总线通信异常  <select id="stateLK5005" name="stateLK5005">
										<option  value="00">
											禁止
										</option>
										<option  value="01">
											开启
										</option>
									</select> </span>
								<span><input type="radio" value="LK5011" name="command" />
									GPS天线异常  <select id="stateLK5011" name="stateLK5011">
										<option  value="00">
											禁止
										</option>
										<option  value="01">
											开启
										</option>
									</select> </span>
								<span><input type="radio" value="LK5015" name="command" />
									开壳    <select id="stateLK5015" name="stateLK5015">
										<option  value="00">
											禁止
										</option>
										<option  value="01">
											开启
										</option>
									</select> </span>
								<span> <input type="radio" value="LK5021" name="command" />长时间不入网
									<select id="stateLK5021" name="stateLK5021">
										<option  value="00">
											禁止
										</option>
										<option  value="01">
											开启
										</option>
									</select> </span>
							--></td>
						</tr>
					</table>

					 <table style="border-collapse:collapse;border-spacing:0;"
						class="commandsend_tab">
						<caption>
							设备设置
						</caption>
						<c:forEach var ="dictionary" items ="${list_sbsz}">
						<c:choose>
						<c:when test="${dictionary.d_code =='GE3007'}">
						<tr>
							<td id="tab_side">
								<span> <input type="radio" value="GE3007" name="command" />定时回传时间间隔设置-时分秒
								   </span><span><input type="text" id="d242"  name="hmsGE3007"
										onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
										class="Wdate" /> </span>
							</td>
						</tr>
						</c:when>
						
						<c:when test="${dictionary.d_code =='GE3011'}">
						<tr>
							<td id="tab_side">
								<span> <input type="radio" value="GE3011" name="command" />工作小时设置-时分秒
								 </span><span><input type="text" id="d242" name="hmsGE3011"
										onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
										class="Wdate" /> </span>
							</td>
						</tr>
						</c:when>
						
						</c:choose>
						</c:forEach>
						<!--<tr>
							<td id="tab_side">
								<span> <input type="radio" value="GE3007" name="command" />定时回传时间间隔设置-时分秒
								   </span><span><input type="text" id="d242"  name="hmsGE3007"
										onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
										class="Wdate" /> </span>
							</td>
						</tr>
						<tr>
							<td id="tab_side">
								<span> <input type="radio" value="GE3011" name="command" />工作小时设置-时分秒
								 </span><span><input type="text" id="d242" name="hmsGE3011"
										onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
										class="Wdate" /> </span>
							</td>
						</tr>
					--></table>

					<table style="border-collapse:collapse;border-spacing:0;" class="commandsend_tab">
						<caption>
							其他设置
						</caption>
						<c:forEach var ="dictionary" items="${list_qtsz}">
						<c:choose>
						
						<c:when test="${dictionary.d_code=='GE3001'}">
						<tr><td id="tab_side">
						<span><input type="radio" value="GE3001" name="command" />ID设置<input type="text" name="numGE3001" /></span>
						</td></tr>
						</c:when>
						
						<c:when test="${dictionary.d_code=='GE3013'}">
						<tr><td id="tab_side">
						<input type="radio" value="GE3013" name="command" />监控状态设置 
						<select id="stateGE3013" name="stateGE3013">
										<option  value="00">
											监控
										</option>
										<option  value="01">
											不监控
										</option>
						</select> 
						</td></tr> 
						</c:when>
						
						<c:when test="${dictionary.d_code=='GE3005'}">
						<tr><td id="tab_side">
						<span><input type="radio" value="GE3005" name="command" />回传方式设置   
									<select id="returntype" name="returntype">
				                        <option value="01">UDP方式</option>
				                        <option value="02">TCP方式</option>
				                        <option value="03">短信方式</option>
				                        <option value="04">禁止任何方式</option>
                        			</select>  
                        </span>
                        <span>连接方式 
								<select id="conntype" name="conntype">
									<option value="00">域名连接方式</option>
                    				<option value="01">IP连接方式</option>
								</select> 
						</span>
						    IP地址 
								 	<input type="text" class="inputTxt" name="ipaddress1">-
									<input type="text" class="inputTxt" name="ipaddress2">- 
									<input type="text" class="inputTxt" name="ipaddress3">- 
									<input type="text" class="inputTxt" name="ipaddress4">
								<span>域名地址<input type="text" name="domainaddress"> </span>
								<span>端口号<input type="text" name="port"> </span>
						</td></tr>
						</c:when>
						
						<c:when test="${dictionary.d_code=='GE3005'}"> 
						<tr><td id="tab_side">
						<input type="radio" value="GE3005" name="command" />实时时间设置<input type="text" id="d242" name="hmsGE3005" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" class="Wdate" />  
						</td></tr> </c:when>
						
						<c:when test="${dictionary.d_code=='GE3017'}">
						<tr><td id="tab_side">
						<input type="radio" value="GE3017" name="command" />休眠时间设置<input type="text" id="d242" name="hmsGE3017" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" class="Wdate" />  
						</td></tr></c:when>
						
						<c:when test="${dictionary.d_code=='GE3021'}">
						<tr><td id="tab_side">
						<input type="radio" value="GE3021" name="command" />不入网自锁车时间间隔设置<input type="text" name="numGE3021">天
						</td></tr></c:when>
						 
						</c:choose>
						</c:forEach>
						<!--<tr>
							<td id="tab_side">
								<span> <input type="radio" value="GE3011" name="command" />ID设置
								<input type="text" name="numGE3001" /></span>
								<span><input type="radio" value="GE3005" name="command" />
									回传方式设置   
									<select id="returntype" name="returntype">
				                        <option value="01">UDP方式</option>
				                        <option value="02">TCP方式</option>
				                        <option value="03">短信方式</option>
				                        <option value="04">禁止任何方式</option>
                        			</select>  </span>
								<span> 连接方式 
								<select id="conntype" name="conntype">
					<option value="00">域名连接方式</option>
                    <option value="01">IP连接方式</option>
									</select> </span>
							</td>
						</tr>
						<tr>
							<td id="tab_side">
								 IP地址 
								 	<input type="text" class="inputTxt" name="ipaddress1">-
									<input type="text" class="inputTxt" name="ipaddress2">- 
									<input type="text" class="inputTxt" name="ipaddress3">- 
									<input type="text" class="inputTxt" name="ipaddress4">  
								<span>域名地址<input type="text" name="domainaddress"> </span>
								<span>端口号<input type="text" name="port"> </span>
							<td>
						</tr>
						<tr>
							<td id="tab_side">
								  <input type="radio" value="GE3005" name="command" />实时时间设置
									<input type="text" id="d242" name="hmsGE3005"
										onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
										class="Wdate" />  
								  <input type="radio" value="GE3017" name="command" />休眠时间设置
									<input type="text" id="d242" name="hmsGE3017"
										onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
										class="Wdate" />  
							</td>
						</tr>
						<tr>
							<td id="tab_side">
								<input type="radio" value="GE3021" name="command" />
								不入网自锁车时间间隔设置
								<input type="text" name="numGE3021">天
							</td>
						</tr>
						<tr>
							<td id="tab_side">
							  <input type="radio" value="GE3013" name="command" />
									监控状态设置 <select id="stateGE3013" name="stateGE3013">
										<option  value="00">
											监控
										</option>
										<option  value="01">
											不监控
										</option>
									</select>  
								  <input type="radio" value="GE0003" name="command" />系统重启
								 
								  <input type="radio" value="GE0020" name="command" />系统重启次数回
								 
								  <input type="radio" value="GE0021" name="command" />日统计信息回传
								 
							</td>
						</tr>
					-->
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