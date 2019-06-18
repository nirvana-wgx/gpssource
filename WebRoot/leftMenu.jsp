<%@ page language="java"  pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path =request.getContextPath();
%>
<html>
<head>
	<title>perspective_outlookbar</title>  
	<link rel="stylesheet" href="<%=path %>/css/YUIcssreset.css" type="text/css" media="all" />  
	<link rel="stylesheet" href="<%=path %>/css/layout.css" type="text/css" media="all" />
	<script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" > </script>
	<script type="text/javascript">
	 
	 function addTab(object){
	 	var _a =$(object).parent();
	 	addClass($(object));
 		var id =$(_a).find("a").attr("id");
 		var url =$(_a).find("a").attr("title");
 		var title=$(object).html();
 		//alert(id);
 		var content = window.top.frames["rightFrame"];
 		content.window.loadContent(id,title,url);
 	}
 function addClass(_a){
    //alert("addClass");
 	var $li,
	$container;
	if (_a.length) {
		$li = _a.parent();
		$container = $li.parent();
		$container.find('li').removeClass('sidebar_menu_selected');
		$li.addClass('sidebar_menu_selected');
	}
}
	</script>
</head> 
<body>
	<div class="sidebar_wrapper"> 
		<div class="sidebar">
			<!-- sidebar标题 -->
			<div class="sidebar_title">
				<h3 class="sidebar_setting">${menuTitle}</h3>
			</div><!-- .sidebar_title end -->	
					<!-- .sidebar_menu -->
						<ul class="sidebar_menu" id="dyndiv">
					<c:forEach items="${leftlist}" var ="menu">
						<li><a href="javascript:void(0);" id="${menu.code}" title="<%=path %>/${menu.url}" onclick="addTab(this)">${menu.name}</a></li>
					</c:forEach>
						</ul>		
		</div><!-- .sidebar end -->	
	</div>
</body>
</html>
