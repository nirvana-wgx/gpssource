<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>车辆管理-配置表单</title>
		 
		<link rel="stylesheet" href="<%=path%>/css/toolbars.css" type="text/css" media="all" />
		<link rel="stylesheet" href="<%=path%>/css/style.css" type="text/css" media="all" />
		
		<script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" ></script>
		
		<script type="text/javascript">
	    $(function(){
	    	// 绑定密码验证-onblur
	    	// $("#password").bind("blur",ajaxPassword);
	    	//绑定重置
	    	$("#btn_clear").bind("click",clear);
	    	//保存
	    	$("#btn_ok").bind("click",save);
	    	//新密码确认
	    	//$("#oknewpassword").bind("blur",recheck);
	    	
	    }) ;
		
			
		//密码验证函数
		function ajaxPassword(){
				 var str = $("form").serialize();
				 $.ajax({
					 url:"<%=path%>/jsp/accountmanager/ajaxPass.page",
					 type:"POST",
					 dataType:"json",
					 data:str,
					 success:function(data){
					 	if(data.message=='0'){
					 		alert("密码错误，请重新输入");
					 		$("#password").val("");
					 	} 
					 }
				 
				 });
		 		 
		};
		function clear(){
		  $("input[name=d_value]").val("");
		}
		
		function save(){
 
				if(!validform()){
					return ;
				};
				var str = $("form").serialize();
				 $.ajax({
					 url:"<%=path%>/jsp/vechiclemanager/save.page",
					 type:"POST",
					 dataType:"json",
					 data:str,
					 success:function(data){
					 	if(data.message=='0'){
					 		alert("保存失败!");
					 	}else{
					 		alert("保存成功!");
					 		var d_type=$("input[name=d_type]").val();
					 		window.location="query.page?d_type="+d_type;
					 	}
					 }
				 
				 });
		}
		function validform(){
		
			if($("input[name=d_value]").val()==""){
				alert("名称为空");
				return false ;
			}
			return true;
		}
		
		 
		</script>
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
				<input type="hidden" name="d_type" value="${dictionary.d_type}"/>
				<input type="hidden" name="d_code" value="${dictionary.d_code}"/>
					<table>
						<tr>
						
							<td class="left">
								<span class="need">*</span>类型
							</td>
							<td class="right">
								<input type="text" readonly name="d_typeName"  value="${dictionary.d_typeName}"/>
							</td>
							<td><span class="Validform_checktip"></span></td>
							
						</tr>
						<tr>
							<td class="left">
								<span class="need">*</span>名称
							</td>
							<td class="right">
								<input type="text" name="d_value" value="${dictionary.d_value}"/>
							</td>
							<td ><span class="Validform_checktip" ></span></td>
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