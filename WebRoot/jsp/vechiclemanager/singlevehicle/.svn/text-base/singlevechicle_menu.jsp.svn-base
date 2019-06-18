<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
%>

<html>
  <head>
    
    <title>${ vehicleid }≥µ¡æ–≈œ¢</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	   $(document).ready(function(){
	      var vehicleid = '${ vehicleid }';
	      var deviceid = '${ deviceid }';
	      $("#topFrame").load(function(){
	         $("#singlerightframe").attr("src", "<%=path %>/jsp/vechiclemanager/singlevehicle/singleworkContent.page");
	         
	         $("#singlerightframe").load(function(){
               $("#singleleftframe").attr("src", "<%=path%>/jsp/vechiclemanager/singlevehicle/SingleVehicleLeftMenu.page?vehicleid=" + vehicleid + "&deviceid=" + deviceid);
            });
	      });
	   
	   });
	</script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <frameset id='parentFrame'  rows='42px,*' border="0">
     <frame id='topFrame' name='topFrame' src='<%=path %>/jsp/vechiclemanager/singlevehicle/singlevechicle_header.jsp' scrolling="no" ></frame>
	  <frameset cols="185px,*" border="0">
	    <frame name="singleleftframe" id="singleleftframe" src="" scrolling="no"></frame>
	    <frame name="singlerightframe" id="singlerightframe" src="" ></frame>
	  </frameset>
  </frameset>
</html>
