<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'footer.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
    <link rel="stylesheet" href="css/YUIcssreset.css" type="text/css" media="all" />  
    <link rel="stylesheet" href="css/layout.css" type="text/css" media="all" />

  </head>
  
  <!-- .footer -->
    <div class="footer">        
        <div class="footer_content">
            <span class="footer_infomation">
                <em>������Ա�������ͣ�wgx��</em><em>���ڻ��������ϸ���ͨ����0101��</em>
            </span>
            <span class="footer_copyright">
                ����֧�֣�XXX��Ϣ�ɷ����޹�˾
            </span>
        </div>
    </div>  <!-- .footer end-->
</html>
