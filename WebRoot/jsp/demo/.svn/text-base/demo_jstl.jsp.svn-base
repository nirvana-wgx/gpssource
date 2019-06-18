<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>DEMO_JSTL</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    获取Session中account对象的name：<font color="red">${ sessionScope.account.name }</font><br/><br/><br/>
    
    <c:if test="${ type == '0' }">
        <font color="red">
    </c:if>
    ${ data }
    <c:if test="${ type == '0' }">
        
    </c:if>
    <br/><br/><br/>
    
    <c:choose>
        <c:when test="${ type == '0' }">
            <font color="blue">${ data }</font>
        </c:when>
        <c:otherwise>
        ${ data }
        </c:otherwise>
    </c:choose>
    
    
  </body>
</html>
