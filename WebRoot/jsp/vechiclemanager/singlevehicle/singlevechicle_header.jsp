<%@ page language="java" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>������</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" href="<%=path %>/css/YUIcssreset.css" type="text/css" media="all" />  
    <link rel="stylesheet" href="<%=path %>/css/layout.css" type="text/css" media="all" />
    <script src="<%=path %>/scripts/jquery-laster.js"></script>
    <script src="<%=path %>/scripts/jquery.utils.js"></script>
    <script src="<%=path %>/scripts/jquery.ui.tab.js"></script>

<style type="text/css">
.topsubnav {
    right: 35px;
    top: 10px;
}
.header{
   height: 40px;
}
.header h1 {
   top: 5px;
}
li{
	margin-left:20px;
}
</style>
  </head>
  
  <body>
    <div id="header_wrapper">
        <!-- =========================================== ͷ�� ============================================= -->
        <div class="header">
            <!-- ͷ������logo -->
            <h1>GPS���ܼ��ϵͳ</h1>
            <!-- .navigation_body -->
            <div class="navigation_body">
            </div> <!-- .navigation_body end -->    
            <!-- �����˵� -->
<!--             <ul class="topsubnav"> -->
<!--              	<li><span>${gdate}</span></li> -->
<!--                 <li class="identity" title="���"><span>${login_user.name}</span></li> -->
<!--                 <li class="exit" title="�˳�ϵͳ"><span class="topsubnav_divide"></span><a href="javascript:void(0);" id="exit">�˳�ϵͳ</a></li> -->
<!--             </ul> -->
        </div> <!-- .header end -->
        <!-- ======================================= .header end ========================================== -->
    </div> <!-- #header_wrapper end -->
</body>
</html>
