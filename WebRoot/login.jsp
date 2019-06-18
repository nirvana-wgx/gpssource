<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path =request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Login </title>  
  <link rel="stylesheet" href="<%=path %>css/YUIcssreset.css" type="text/css" media="all" />  
  <link rel="stylesheet" href="<%=path %>/css/login.css" type="text/css" media="all" />
  <script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js"></script>
 
  <!--[if lte IE 6]>
  	  <script src="css/jquery-laster.js"></script> 
	  <script>
	       $(function() {
	       		function maxMinFix(max, min) {	
					var loginBody = $('.login_body'),
						lbHeight = loginBody.height();
					if (lbHeight > max) {
						loginBody.css('height', max + 'px');
					} else if (lbHeight < min){
						loginBody.css('height', min + 'px');
					} 
	       		}
	       		maxMinFix(500, 280);
	       		$(window).on('resize', function() {
					setTimeout( function() {maxMinFix(500, 280)}, 200 );
	       		})
	       });
	  </script>     
   <![endif]-->
   <script type="text/javascript">
	   $(function(){
	   	 
		   $("#loginBtn").bind("click",login);
		   $("#checkcode").bind("keydown",enterlogin);
	       $("#btn_reload").bind("click",function(){
		 		btn_reload();
		   });
		   $("#btn_clear").bind("click",function(){
		 		btn_clear();
		   });
	   });
	    function login(){
 
		    if(validate()){
		    	document.forms['loginform'].submit();
		    }
	    }
	    function btn_reload(){
		   $("#image").removeAttr("src");
		   $("#image").attr("src","<%=path %>/jsp/image.jsp");
		 }
		  function btn_clear(){
			  $(":input").not("input[type=button]").each(function(){
			  	 $(this).val("");
			  });
		 }
    	function enterlogin(){
	    	if(event.keyCode==13 && validate()){
	    		document.forms['loginform'].submit();
	    	}
    	}
    	function validate(){
	    	var name =$("#name").val();
	    	var pass=$("#pass").val();
	    	var checkcode =$("#checkcode").val();
    		if($.trim(name)==''){
	    		//alert("请输入用户名");
	    		$("#name").focus();
	    		return false;
    		}
    		if($.trim(pass)==''){
	    		//alert("请输入密码");
	    		$("#pass").focus();
	    		return false;
    		}
    		if($.trim(checkcode)==''){
	    		//alert("请输入验证码");
	    		$("#checkcode").focus();
	    		return false;
    		}
    		return true;
    	}
   </script>
</head> 
<body>
	<!-- ==================.login_pane================== -->
	<div class="login_pane">
		<!-- ==================.login_header================== -->
		<div class="login_header">
			<div class="login_header_wrapper">
				<h1></h1>
			</div>	
		</div><!-- .login_header end-->
		<!-- ==================.login_body================== -->
		<div class="login_body">
			<!-- .login -->
			<div class="login">
				<div class="login_image"></div>
				<form name="loginform"  action="login.page" method="post">
					<div class="login_title">
						<h2></h2>
					</div>
					<label for="">用 户：<input type="text" id="name" name="name"/></label>
					<label for="">密 码：<input type="password" id="pass" name="pass"/></label>
					<label for="">验证码：<input type="text" id="checkcode" name="checkcode"  class="login_captcha"><img id="image" src="<%=path %>/jsp/image.jsp" /><span style="margin-left:100px;"><a href ="javascript:void(0);" id="btn_reload">换一张</a></span></label>				
					<div class="login_button">
						<a href="javascript:void(0);" id ="loginBtn" name ="loginBtn" class="login_button_sign"><span>登录</span></a><a href="javascript:void(0);" id="btn_clear" name ="btn_clear" class="login_button_sign"><span>重置</span></a>
					</div>	
				</form>
			</div><!-- .login end -->			
		</div><!-- .login_body end-->
		<!-- ==================.login_footer================== -->
		<div class="login_footer">
			<div class="login_footer_wrapper">
				<span></span>
			</div>
		</div><!-- .login_footer end-->
	</div><!-- .login_pane -->
</body>

</html>