<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>车辆管理-账户密码修改</title>
		 
		<link rel="stylesheet" href="<%=path%>/css/toolbars.css" type="text/css" media="all" />
		<link rel="stylesheet" href="<%=path%>/css/style.css" type="text/css" media="all" />
		
		<script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" ></script>
		
		<script type="text/javascript"><!--
	    $(function(){
	    	// 绑定密码验证-onblur
	    	 $("#password").bind("blur",ajaxPassword);
	    	//绑定重置
	    	$("#btn_clear").bind("click",clear);
	    	//保存
	    	$("#btn_ok").bind("click",save);
	    	//新密码确认
	    	$("#oknewpassword").bind("blur",recheck);
	    	
	    }) ;
		
			
		//密码验证函数
		function ajaxPassword(){
				 var str = $("form").serialize();
				 $.ajax({
					 url:"<%=path%>/jsp/accountmanager/ajaxPass.page",
					 type:"POST",
					 dataType:"json",
					 data:str,
					 async:false,
					 success:function(data){
					 	if(data.message=='0'){
					 		alert("密码错误，请重新输入");
					 		$("#password").val("");
					 		return false;
					 	} 
					 	return true;
					 }
				 
				 });
		 		 
		};
		function clear(){
		  $("input[name=password]").val("");
		  $("input[name=newpassword]").val("");
		  $("input[name=oknewpassword]").val("");
		}
		
		function save(){
 
				if(!validform()){
					return ;
				};
				 
				var str = $("form").serialize();
				 $.ajax({
					 url:"<%=path%>/jsp/accountmanager/savePassword.page",
					 type:"POST",
					 dataType:"json",
					 data:str,
					 async:false,
					 success:function(data){
					 	if(data.message=='0'){
					 		alert("保存失败!");
					 	}else{
					 		alert("保存成功!");
					 		clear();
					 	}
					 }
				 
				 });
		}
		function validform(){
		
			if($("input[name=password]").val()==""){
				alert("密码为空");
				return false ;
			}
			
			if($("input[name=newpassword]").val()==""){
				alert("新密码为空");
				return false;
			}
			
			if($("input[name=oknewpassword]").val()==""){
				alert("密码确认为空");
				return false;
			}
			return true;
		}
		
		function recheck(){
			var pass1=$("input[name=oknewpassword]").val();
			var pass2=$("input[name=newpassword]").val();
			if($.trim(pass1)!=$.trim(pass2)){
				alert("两次输入密码不一样");
				$("input[name=oknewpassword]").val("");
				$("input[name=newpassword]").val("");
			}
		}
		--></script>
		<style type="text/css">
 body{
 	background:#fff;
 }

table {
	width: 100%;
}

table td {
	border-right: 0px solid #D1D5DE;
	border-bottom: 0px solid #D1D5DE;
	border-left: 0px solid #D1D5DE;;
	border-top:  0px solid #D1D5DE;
	background: #fff;
	font-size: 12px;
	padding: 5px ,5px ;
	margin: 5px 5px ;
	color: #5C5C5C;
	font-weight: normal;
	vertical-align:top;
	text-align:left;
}
td.left {
	text-align: right;
}

td.right {
	text-align: left;
}

fieldset {
	border: 0px ;
	font-size: 18px;
	font-weight: bolder;
	color: #000000;
}
fieldset legend{
	color: #000000;
}

div {
	width: 99%;
	margin-left: 5px;
	margin-top: 50px;
	text-align: center;
}
.need{
	width:10px;
	color:#b20202;
}
 
</style>
	</head>

	<body>
		<div>
			<fieldset>
				 
				<form class="upassform">
					<table>
						<tr>
						
							<td class="left">
								<span class="need">*</span>旧密码
							</td>
							<td class="right">
								<input type="password" name="password"  id="password"/>
							</td>
							<td><span class="Validform_checktip"></span></td>
							
						</tr>
						<tr>
							<td class="left">
								<span class="need">*</span>新密码
							</td>
							<td class="right">
								<input type="password" name="newpassword" />
							</td>
							<td ><span class="Validform_checktip" ></span></td>
						</tr>
						<tr>
							<td class="left">
								<span class="need">*</span>新密码确认
							</td>
							<td class="right">
								<input type="password" name="oknewpassword" id="oknewpassword"/>
							</td>
							<td><span class="Validform_checktip"></span></td>
						</tr>
						<tr>
							<td class="left">
								<a href="javascript:void(0)"   id="btn_ok"><span
									class="toolbar_btn"><span
										class="toolbar_btn_ico toolbar_btn_ok">保存</span> </span> </a>
							</td>
							<td class="right">
								<a href="javascript:void(0)"   id="btn_clear"><span
									class="toolbar_btn"><span
										class="toolbar_btn_ico toolbar_btn_clear">重置</span> </span> </a>
							</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</form>
			</fieldset>

		</div>
	</body>
</html>