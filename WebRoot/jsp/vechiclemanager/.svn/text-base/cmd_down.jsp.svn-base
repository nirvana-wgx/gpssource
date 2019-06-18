<%@ page language="java"   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
 
%>
<!DOCTYPE html>
<html>
	<head>
		<title>指令下发</title>
		<!--<link rel="stylesheet" href="<%=path%>/css/table.css" type="text/css" media="all" />

	-->
	<link rel="stylesheet" href="<%=path%>/css/toolbars.css" type="text/css" media="all" />
	<style type="text/css">
	body {
		font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
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
	 font-size:12px;
	 padding: 6px 6px 6px 12px;
	 
	}
	#caption_top{
		margin-top:20px;
		border-top: 1px solid #CCCCFF;
	}
	table{
	width:100%;
	}
	.commandsend_tab td{
		border-right: 1px solid #CCCCFF;
		border-bottom: 1px solid #CCCCFF;
		background: #fff;
		font-size:12px;
		padding: 6px 6px 6px 12px;
		color: #000000;
		font-weight :normal ;
	}
    #tab_side{
		border-right:0px;
	}
	fieldset{
		border: 1px solid #CCCCFF;
		border-bottom: 0px solid #CCCCFF;
		font-size: 15px;
		font-weight :bolder  ;
	 	color: #000000;
	}
	fieldset legend{
	 	color: #000000;
	}
	div{
		width:99%;
		margin-left:5px;
	}
	</style>
	</head>

	<body>
		 
			<div>
				<form action="/account.do?type=update" method="post" name="formupdate">
                    <fieldset class="">
                    <legend>指令下发</legend>

					<table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
						<tr>
							<td id="tab_side">
                                    机号：&nbsp;
								<input type="text" value="3365c138" readonly>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								设备号：&nbsp;
                                <input type="text" value="BCA0900037" readonly>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    SIM卡号：&nbsp;
                                <input type="text" value="15092789403" readonly>
							</td>
						</tr>
					</table>
					<table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
						<caption>
							下发命令设置
						</caption>
						<tr>
							<td>
								<input type="radio"  value="GE0001"
									id="command" name="command" />
								<b>信息立即回传命令</b>
							</td>
							<td>
								<input type="radio"  value="GE0003"
									id="command" name="command" />
								<b>系统重启</b>
							</td>
							<td id="tab_side">
								<input type="radio"  value="GE0020"
									id="command" name="command" />
								<b>系统重启次数回传</b>
							</td>
						</tr>
					</table>

					<table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
						<caption>
							锁车命令
						</caption>
						<colgroup>
							<col width="195" />
							<col width="195" />
							<col width="195" />
							<col width="195" />
						</colgroup>
						<tr>
							<td>
								<input type="radio"  value="LK0001"
									id="command" name="command" />
								解锁
							</td>

							<td>
								<input type="radio"  value="LK3011"
									id="command" name="command" />
								第一路立即锁车
							</td>

							<td>
								<input type="radio"  value="LK3013"
									id="command" name="command" />
								第一路判断锁车
							</td>

							<td id="tab_side">
								<input type="radio"  value="LK3021"
									id="command" name="command" />
								第二路立即锁车
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio"  value="LK3023"
									id="command" name="command" />
								第二路判断锁车
							</td>

							<td>
								<input type="radio"  value="LK3031"
									id="command" name="command" />
								第三路立即锁车
							</td>

							<td>
								<input type="radio"  value="LK3033"
									id="command" name="command" />
								第三路判断锁车
							</td>

							<td id="tab_side">
								<input type="radio"  value="LK3041"
									id="command" name="command" />
								第四路立即锁车
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio"  value="LK3043"
									id="command" name="command" />
								第四路判断锁车
							</td>

							<td>
								<input type="radio"  value="LK30A1"
									id="command" name="command" />
								所有路立即锁车
							</td>

							<td>
								<input type="radio"  value="LK30A3"
									id="command" name="command" />
								所有路判断锁车
							</td>
							<td id="tab_side">
								 &nbsp;
							</td>
					</table>

					<table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
						<caption>
							自锁车命令
						</caption>
						<colgroup>
							<col width="195" />
							<col width="195" />
							<col width="195" />
							<col width="195" />
						</colgroup>
						<tr>
							<td>
								<input type="radio"  value="LK5001"
									id="command" name="command" />
								所有类型自锁车&nbsp;
								<select>
								    <option id="" value="">禁止</option>
								    <option id="" value="">开启</option>
								</select>
							</td>

							<td>
								<input type="radio"  value="LK5005"
									id="command" name="command" />
								总线通信异常&nbsp;
                                <select>
                                    <option id="" value="">禁止</option>
                                    <option id="" value="">开启</option>
                                </select>
							</td>

							<td>
								<input type="radio"  value="LK5011"
									id="command" name="command" />
								GPS天线异常&nbsp;
                                <select>
                                    <option id="" value="">禁止</option>
                                    <option id="" value="">开启</option>
                                </select>
							</td>

							<td id="tab_side">
								<input type="radio"  value="LK5015"
									id="command" name="command" />
								开壳&nbsp;
                                <select>
                                    <option id="" value="">禁止</option>
                                    <option id="" value="">开启</option>
                                </select>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio"  value="LK5021"
									id="command" name="command" />
								长时间不入网&nbsp;
                                <select>
                                    <option id="" value="">禁止</option>
                                    <option id="" value="">开启</option>
                                </select>
							</td>

							<td>
								&nbsp;
							</td>

							<td>
								&nbsp;
							</td>
							<td id="tab_side">
								 &nbsp;
							</td>
						</tr>
					</table>

					<table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
						<caption>
							设备设置
						</caption>
						<colgroup>
							<col width="195" />
							<col width="195" />
							<col width="195" />
							<col width="195" />
						</colgroup>
						<tr>
							<td colspan="4">
								<input type="radio"  value="GE3007"
									id="command" name="command" />
								定时回传时间间隔设置&nbsp;&nbsp;
								小时：
								<input type="text">
								分钟：
                                <input type="text">
                                    秒：
                                <input type="text">
							</td>
							
						</tr>
						<tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3011"
                                    id="command" name="command" />
                                工作小时设置&nbsp;&nbsp;
                                小时：
                                <input type="text">
                                分钟：
                                <input type="text">
                                    秒：
                                <input type="text">
                            </td>
                        </tr>
					</table>

					<table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
						<caption>
							其他设置
						</caption>
						<tr>
							<td colspan="4">
							<input type="radio"  value="GE3011"
                                    id="command" name="command" />
								ID设置：<input type="text" />
							</td>
						</tr>
						<tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3005"
                                    id="command" name="command" />
                                回传方式设置：
                                <select>
                                    <option id="" value="">UDP方式</option>
                                    <option id="" value="">TCP方式</option>
                                    <option id="" value="">短信方式</option>
                                    <option id="" value="">禁止任何方式</option>
                                </select>
                                连接方式：
                                <select>
                                    <option id="" value="">域名连接方式</option>
                                    <option id="" value="">IP连接方式</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                IP地址：
                                <input type="text">&nbsp;
                                <input type="text">&nbsp;
                                <input type="text">&nbsp;
                                <input type="text">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                域名地址：
                                <input type="text">&nbsp;
                            端口号：<input type="text">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3005"
                                    id="command" name="command" />
                                实时时间设置：<input type="text">&nbsp;
                                
                                <select>
                                    <option id="" value="">0</option>
                                    <option id="" value="">1</option>
                                    <option id="" value="">2</option>
                                    <option id="" value="">3</option>
                                </select>
                                小时
                                <select>
                                    <option id="" value="">0</option>
                                    <option id="" value="">1</option>
                                    <option id="" value="">2</option>
                                    <option id="" value="">3</option>
                                </select>
                                分
                                <select>
                                    <option id="" value="">0</option>
                                    <option id="" value="">1</option>
                                    <option id="" value="">2</option>
                                    <option id="" value="">3</option>
                                </select>
                                秒
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3005"
                                    id="command" name="command" />
                                休眠时间设置：<input type="text">&nbsp;
                                
                                <select>
                                    <option id="" value="">0</option>
                                    <option id="" value="">1</option>
                                    <option id="" value="">2</option>
                                    <option id="" value="">3</option>
                                </select>
                                小时
                                <select>
                                    <option id="" value="">0</option>
                                    <option id="" value="">1</option>
                                    <option id="" value="">2</option>
                                    <option id="" value="">3</option>
                                </select>
                                分
                            </td>
                        </tr>
						<tr>
							<td colspan="4">
								<input type="radio"  value="GE3021"
									id="command" name="command" />
								不入网自锁车时间间隔设置：
								<input type="text">
							</td>
						</tr>
						<tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3013"
                                    id="command" name="command" />
                                监控状态设置：
                                <select>
                                    <option id="" value="">监控</option>
                                    <option id="" value="">不监控</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3013"
                                    id="command" name="command" />
                                系统重启
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <input type="radio" value="GE3013"
                                    id="command" name="command" />
                                系统重启次数回传
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <input type="radio"  value="GE3013"
                                    id="command" name="command" />
                                日统计信息回传
                            </td>
                        </tr>
					</table>
					<table>
					   <tr>
                        <td id="tab_side" align="center" colspan="4">
                            <a href="javascript:void(0)" onclick="" id="btn_add"> <span
                                    class="toolbar_btn"><span
                                        class="toolbar_btn_ico toolbar_btn_ok">下发</span></span></a>
                                <a href="javascript:void(0)" onclick="closeWin()" id="btn_add"><span
                                    class="toolbar_btn"><span
                                        class="toolbar_btn_ico toolbar_btn_cancel">关闭</span>
                                </span></a>
                        </td>
                    </tr>
					</table>
					</fieldset>
				</form>
			</div>
	</body>
<script type="text/javascript">
   //下发指令
   function removeFen(){
           var str = "deviceid="+"${mapinf.deviceid}";
             $.ajax({
                url:"jsp/vechiclemanager/cmdSend.page",
                type:"POST",
                dataType:"json",
                data:str,
                success:function(data){
                  if(data.message=="1"){
                     alert("下发指令成功!");
                  }else{
                     alert("下发指令失败!");
                  }
                }
           });
   }
</script>
</html>