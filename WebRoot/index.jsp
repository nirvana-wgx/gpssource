<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path =request.getContextPath();
%>
<html>
  <head>
    <title>车辆管理系统</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  
   <frameset id='parentFrame'  rows='70px,*' border="0">
  	<frame id='topFrame' name='topFrame' src='<%=path %>/header.page' scrolling="no" ></frame>
	  <frameset cols='170px,*'>
	  <frame id='leftFrame' name='leftFrame' src='<%=path %>/leftMenu.page?parentCode=1' scrolling="no"></frame>
	  <frame id='rightFrame' name='rightFrame' src='<%=path %>/workContent.page'></frame> 
	  </frameset><!--
	  <frame id='footFrame' name='footFrame' src='<%=path %>/footer.jsp' scrolling="no" ></frame>
  --></frameset>
</html>

