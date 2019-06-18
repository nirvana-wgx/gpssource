<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>导航栏</title>
    
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
    <script type="text/javascript">
     $(function() {     
        $('#navigation').tab('init', 
            {   tabClass: '.navigation_lists',
                prevButton : '.nav_prev_arrow',
                nextButton : '.nav_next_arrow',
                slideSpace : 100
            }
        );
        $(window).on('resize', function() {
            $('#navigation').tab('init', 
                {   tabClass: '.navigation_lists',
                    prevButton : '.nav_prev_arrow',
                    nextButton : '.nav_next_arrow',
                    slideSpace : 100
                }
            );
        });
        
        $("#exit").bind("click",function(){
        	window.parent.location="exit.page";
        });
         
    });
    </script>
    
<style type="text/css">
li{
	margin-left:20px;
}
</style>
  </head>
  
  <body>
    <div id="header_wrapper">
        <!-- =========================================== 头部 ============================================= -->
        <div class="header">
            <!-- 头部标题logo -->
            <h1>GPS智能监控系统</h1>
            <div class="navigation_header"></div>
            <!-- .navigation_body -->
            <div class="navigation_body">
                <!-- ================= 导航菜单 ================= -->
                <div class="navigation" id="navigation"> 
                    <!-- 导航左边区域 -->
                    <div class="navigation_left_region">
                    <!-- 左箭头按钮 -->
                        <a class="nav_prev_arrow" title="向前"></a>
                    </div> <!-- .navigation_left_region end -->
                    <!-- 导航左边区域 -->
                    <div class="navigation_right_region">
                    <!-- 右箭头按钮 -->
                        <a class="nav_next_arrow" title="向后"></a>
                    </div> <!-- .navigation_right_region end -->
                    <!-- 导航中间区域 -->
                    <div class="navigation_center_region">
                        <!-- 导航菜单列表 -->
                          <ul class="navigation_lists" id="nav"><!-- 导航菜单项 -->
	                          <c:forEach var="menu" items="${headerlist}">
	                           <li><a href="<%=path %>/${menu.url}" target="leftFrame">${menu.name} </a></li><!-- 选中的导航菜单项 -->
	                          </c:forEach>
                           </ul> <!-- ul.navigation_lists end --> 
                    </div> <!-- .navigation_center_region end -->
                </div> <!-- ================= .navigation end  ================= -->
            </div> <!-- .navigation_body end -->    
            <!-- 顶部菜单 -->
            <ul class="topsubnav">
             	<li><span>${gdate}</span></li>
                <li class="identity" title="身份"><span>${login_user.name}</span></li>
                <li class="exit" title="退出系统"><span class="topsubnav_divide"></span><a href="javascript:void(0);" id="exit">退出系统</a></li>
            </ul>
        </div> <!-- .header end -->
        <!-- ======================================= .header end ========================================== -->
    </div> <!-- #header_wrapper end -->
</body>
</html>
<script type="text/javascript">
    //这里必须要在li标签后加载才能起效果
	window.onload=function()
	{
		var oli=document.getElementById('nav').getElementsByTagName('li');
			for (i=0;i<oli.length;i++)
			{
				oli[0].className='nav_selected';
				oli[i].onclick=function()
				{
					for (i=0;i<oli.length;i++)
					{
					   oli[i].className='navlist_items';
					}
				this.className='nav_selected';
			}
		}
	}
</script>
