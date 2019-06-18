<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path =request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CSS Tables</title>
<link href="<%=path %>/css/table.css" rel="stylesheet" type="text/css" />

   <link rel="stylesheet" type="text/css" href="<%=path %>/plugs/jPaginate/css/style.css" media="screen"/>
<script type="text/javascript" src="<%=path %>/plugs/jPaginate/jquery-1.3.2.js"></script>
<script type="text/javascript" src="<%=path %>/plugs/jPaginate/jquery.paginate.js" ></script>
 
<script type="text/javascript">
		$(function() {
			$("#demo2").paginate({
				count 		: 5,
				start 		: 1,
				display     : 10,
				border					: false,
				text_color  			: '#888',
				background_color    	: '#EEE',	
				text_hover_color  		: 'black',
				background_hover_color	: '#CFCFCF'
			});
		});
		</script>
 
</head>

<body>
 
 
<div id="demo2">                   
</div>
 
<table id="mytable" cellspacing="0" summary="The technical specifications of the Apple PowerMac G5 series">
<!--<caption>Table 1: Power Mac G5 tech specs </caption>
  --><tr>
    <th scope="col" abbr="Configurations">Configurations</th>

    <th scope="col" abbr="Dual 1.8">Dual 1.8GHz</th>
    <th scope="col" abbr="Dual 2">Dual 2GHz</th>
	<th scope="col" abbr="Dual 2.5">Dual 2.5GHz</th>
  </tr>
  <tr>
    <th scope="row" abbr="Model" class="spec">Model</th>
    <td>M9454LL/A</td>

    <td>M9455LL/A</td>
    <td>M9457LL/A</td>
  </tr>
  <tr>
    <th scope="row" abbr="G5 Processor" class="specalt">G5 Processor</th>
    <td class="alt">Dual 1.8GHz PowerPC G5</td>
    <td class="alt">Dual 2GHz PowerPC G5</td>

    <td class="alt">Dual 2.5GHz PowerPC G5</td>
  </tr>
  <tr>
    <th scope="row" abbr="Frontside bus" class="spec">Frontside bus</th>
    <td>900MHz per processor</td>
    <td>1GHz per processor</td>
    <td>1.25GHz per processor</td>

  </tr>
  <tr>
    <th scope="row" abbr="L2 Cache" class="specalt">Level2 Cache</th>
    <td class="alt">512K per processor</td>
    <td class="alt">512K per processor</td>
    <td class="alt">512K per processor</td>
  </tr>

</table>

 
</body>
</html>
