<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Demo - Validform - 一行代码搞定整站的表单验证！ &copy;瑞金佬的前端路</title>
		<link rel="stylesheet" href="<%=path%>/css/niceforms-default.css" type="text/css" media="all" />
		 
	</head>

	<body>

		<div class="main">
			<div class="wraper">
				<h2 class="green">
					智能的提示信息
				</h2>
				<form class="registerform" action="ajax_post.php">
					<ul>
						<li>
							<label class="label">
								<span class="need">*</span> 中文名：
							</label>
							<input type="text" value="" name="name" class="inputxt" />
							 
						</li>
						<li>
							<label class="label">
								<span class="need">*</span> 密码：
							</label>
							<input type="password" value="" name="userpassword"
								class="inputxt" />
						</li>
						<li>
							<label class="label">
								<span class="need">*</span> 确认密码：
							</label>
							<input type="password" value="" name="userpassword2"
								class="inputxt" />
						</li>
						<li>
							<label class="label">
								<span class="need">*</span> 所在城市：
							</label>
							<select name="province">
								<option value="">
									请选择城市
								</option>
								<option value="1">
									瑞金市
								</option>
							</select>
						</li>
						<li>
							<label class="label">
								<span class="need">*</span> 性别：
							</label>
							<input type="radio" value="1" name="gender" id="male" class="pr1" />
							<label for="male">
								男
							</label>
							<input type="radio" value="2" name="gender" id="female"
								class="pr1" />
							<label for="female">
								女
							</label>
						</li>
						<li>
							<label class="label">
								<span class="need">*</span> 购物网：
							</label>
							<input name="shoppingsite2" class="rt2" id="shoppingsite21"
								type="checkbox" value="1" />
							<label for="shoppingsite21">
								新蛋
							</label>
							<input name="shoppingsite2" class="rt2" id="shoppingsite22"
								type="checkbox" value="2" />
							<label for="shoppingsite22">
								淘宝
							</label>
							<input name="shoppingsite2" class="rt2" id="shoppingsite23"
								type="checkbox" value="3" />
							<label for="shoppingsite23">
								京东
							</label>
						</li>
					</ul>
					<div class="action">
						<input type="submit" value="提 交" />
						<input type="reset" value="重 置" />
					</div>
				</form>
			</div>
		 
		</div>



		<script type="text/javascript"
			src="<%=path%>/scripts/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/scripts/Validform_v5.3.2.js"></script>

		<script type="text/javascript">
$(function(){
	//$(".registerform").Validform();  //就这一行代码！;
		
	var demo=$(".registerform").Validform({
		tiptype:3,
		label:".label",
		showAllError:true,
		datatype:{
			"zh1-6":/^[\u4E00-\u9FA5\uf900-\ufa2d]{1,6}$/
		},
		ajaxPost:true
	});
	
	//通过$.Tipmsg扩展默认提示信息;
	//$.Tipmsg.w["zh1-6"]="请输入1到6个中文字符！";
	demo.tipmsg.w["zh1-6"]="请输入1到6个中文字符！";
	
	demo.addRule([{
		ele:".inputxt:eq(0)",
		datatype:"zh2-4"
	},
	{
		ele:".inputxt:eq(1)",
		datatype:"*6-20"	
	},
	{
		ele:".inputxt:eq(2)",
		datatype:"*6-20",
		recheck:"userpassword"	
	},
	{
		ele:"select",
		datatype:"*"
	},
	{
		ele:":radio:first",
		datatype:"*"
	},
	{
		ele:":checkbox:first",
		datatype:"*"
	}]);
	
})
</script>
	</body>
</html>