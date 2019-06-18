<%@ page language="java"   pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>User interface of Model-View-Controller </title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/common/creator/themes/blue/YUIcssreset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/common/creator/themes/blue/layout.css" type="text/css" media="screen" /> 
	<link rel="stylesheet" href="<%=request.getContextPath() %>/common/creator/themes/silver/forms.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/common/creator/themes/blue/datagrid.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/common/creator/themes/silver/behavior.css" type="text/css" media="all" />
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery-laster.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.layout.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.utils.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.ui.datagrid.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.ui.tab.js" type="text/javascript"></script>		
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.ui.contextmenu.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.ui.toolbardropmenu.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.easing.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.dimensions.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/common/creator/scripts/jquery.accordion.js" type="text/javascript"></script>
	<style type="text/css">
		.body_scrollbar {
			height: 24px;
		}
	</style>
	<script type="text/javascript">
	var outerlayout;
	var internalLayout;
		$(function() { 
			  outerlayout = $('#maincontent').layout( {
				west: {
							paneSelector:			'.sidebar_wrapper',
							size:					180,
							spacing_open:			5,
							spacing_closed: 		5,
							resizerClass:			'sidebar_toggle',
							togglerClass:			'collspse_left',
							togglerLength_open:		51,
							togglerLength_closed:	51,
							togglerAlign_open:		'center'
						},
				center: {
							paneSelector:			'.content_wrapper',
							spacing_open:			0,
							spacing_closed: 		0,
							onresize:				function(){
								innerlayout.resizeAll();
							}
				}
			});  
			  innerlayout = $('.content').layout( {
				north: {
							paneSelector:			'.content_header',
							size:					$(".content_header").height(),
							spacing_open:			0,
							spacing_closed: 		0
						},
				center: {
							paneSelector:			'.content_center',
							innerAdaptable:			true,
							onresize:	function() {
								$('.tabs_wrapper').tab('init');
							}
				}
			});
			 
			
			//accordion	
			$('.accordion').accordion({ 
				selectedClass: 'accordion_selected',
			    autoheight: false
			}); 
		
			defaults();
		}); 
		function defaults(){ 
			var id = "defaults";
			//页签绑定事件,点击时显示.
			$("#t"+id).bind("click",function(){
				$("#div_content").find("div").hide();
				$("#c"+id).show();
				$("#c"+id).parent().show();
				//控制页签样式的显示.
				$(".tabs_group li").removeClass("tabs_actived");
				$("#t"+id).addClass("tabs_actived");
			});
			var height = $(document).height()-48;
			$("#menuTree").parent().css("height",height);  
			$("#cdefaults").parent().attr("height",height);
			$('.tabs_wrapper').tab('init'/*,{spacing: 0}*/);
		}
		function reLayout(){
			  outerlayout.resizeAll();
			  internalLayout.resizeAll(); 
		}
		//缓存菜单
		var moduleItems = new Array();
  
		function addTab(title, url) {
			
			
		}
		//加载主工作区间。 by Leon 2012年4月11日 11:57:01
		function loadContent(id,title,url){
	 
			var existTab = $("#t"+id)[0];
			if(existTab){ 
				$("#t"+id).remove();
				$("#c"+id).remove();
			}
			addTabs(id,title,url);
			 
		}
		//添加tab页签
		function addTabs(id,title,url){
			//判断是否以存在。
			var existTab = $("#t"+id)[0];
			if(existTab){
				$(".tabs_group li").removeClass("tabs_actived");
				$("#t"+id).addClass("tabs_actived");
				$("#div_content").find("div").hide();
				$("#c"+id).show();
				return;
			}
			var strTabs = "<li class='tabs_actived' id='t"+id+"'><a href='#'><span class='tabs_icons'>"+title+"</span><span title='关闭标签' id='tc"+id+"' class='tabs_close'></span></a></li>";
			if(id=="main_index_id"){
				strTabs = "<li class='tabs_actived' id='t"+id+"'><a href='#'><span class='tabs_icons'>"+title+"</span></a></li>";
			}
			//控制页签样式的显示.
			$(".tabs_group li").removeClass("tabs_actived");
			//添加tabs页签.
			$(".tabs_group").append($(strTabs));
			//控制菜单标签滚动，请不要再屏蔽，如果屏蔽请写出理由？？？？2012年7月17日 09:03:40 by Leon
			//$('.tabs_group').horSliding();
			$('.tabs_wrapper').tab('init'/*,{spacing: 0}*/);

			
			//页签绑定事件,点击时显示.
			$("#t"+id).bind("click",function(){
				$("#div_content").find("div").hide();
				$("#c"+id).show();
				//控制页签样式的显示.
				window.top.document.getElementById("singleleftframe").contentWindow.righttab_select(id);
				$(".tabs_group li").removeClass("tabs_actived");
				$("#t"+id).addClass("tabs_actived");
			});
			//绑定关闭事件
			$("#tc"+id).bind("click",function(){
				closeTab(id);
			});
			var height = $(document).height()-48;
			var tabContent = "<div style='height: "+height+"px;' id='c"+id+"'><iframe width='100%' height='100%' scrolling='auto' frameborder='0' src='"+url+"'></iframe></div>";
			$("#div_content").find("div").hide();
			$("#div_content").append($(tabContent));
		}
		//关闭tabs页.
		function closeTab(id){
			//给页签去掉点击事件.
			$("#t"+id).unbind("click");
			//判断页签的状态.
			if($.trim($("#t"+id).attr("class")) == ""){
				$("#t"+id).remove();
				$("#c"+id).remove();
			}else{
				$(".tabs_group li").removeClass("tabs_actived");
				var next_id = $("#t"+id).prev().attr("id");
				if(next_id == null) {
				   $("#t"+id).next().addClass("tabs_actived");
               $("#c"+id).next().show();
               var sel_id = $("#t"+id).next().attr("id");
               if(sel_id != null) {
                  sel_id = sel_id.substring(1);
                  window.top.document.getElementById("singleleftframe").contentWindow.righttab_select(sel_id);
               }
				} else {
				   $("#t"+id).prev().addClass("tabs_actived");
               $("#c"+id).prev().show();
               var sel_id = $("#t"+id).prev().attr("id");
               if(sel_id != null) {
                   sel_id = sel_id.substring(1);
                   window.top.document.getElementById("singleleftframe").contentWindow.righttab_select(sel_id);
               }
               
				}
			   
				$("#t"+id).remove();
				$("#c"+id).remove();
				
			}
			//控制菜单标签滚动，2012年7月17日 09:03:40 by Leon
			//$('.tabs_group').horSliding();
			$('.tabs_wrapper').tab('init'/*,{spacing: 0}*/);

		}
		//页面跳出。 by Leon 2012年4月11日 17:16:15
		function logOut(){
			parent.location='<%=request.getContextPath()%>/logout.jsp';
		}
		function forbidBackspaceKey(){
			$('iframe').load(function(){
				$(this.contentWindow.document).bind('keydown', function(e){
					e = e || window.event;
					var currKey = e.keyCode || e.which || e.charCode;
					var target = e.srcElement || e.target;
					if(target.type != 'text' &&
						target.type != 'textarea' &&
						target.type != 'password'){
						if(currKey == 8){
							return false;
						}
					}
				});
			});
		}
	  
		 
 	</script>
</head> 
<body> 
<div id="maincontent"> 
		 <div id="center" class="content_wrapper">
			<!-- 内容区 -->
			<div class="content">
			<!-- ======================= demo .content_header ======================= -->
			<div class="content_header">
				<!-- 标签封装 -->
				<div class="tabs_wrapper">
					<!-- 标签组左箭头 -->
					<span class="tabs_leftarrow">
						<a href="javascript:void(0)" title="上一个"></a>
					</span> <!-- .tabs_leftarrow end -->
					<!-- 标签组右箭头 -->
					<span class="tabs_rightarrow">
						<a href="javascript:void(0)" title="下一个"></a>
					</span> <!-- .tabs_rightarrow end -->
					<div class="tabs_group_container">
						<!-- 标签组 -->
						<ul class="tabs_group">
						 	<!-- 标签头区域 -->
						</ul>
					</div> <!-- .tabs_group_container end -->
				</div> <!-- .tabs_wrapper end -->
			</div><!-- demo .content_header end -->
			<!-- ============== .content_center ============== -->				
			<div class="content_center" id="div_content">
				<!-- ============== .content_center_container  数据区域============== -->	
				<!-- http://172.16.81.32:8080/self-study/perspective_content.frame?menu_path=module%3A%3Amenu%3A%2F%2Fsysmenu%24root%2Fsysmanager%24module%2Fmenumanage%24item&menu_type=1&ancestor=2 -->	 
			 	<div style='height: 199px;' id='cdefaults'></div>
			</div><!-- .content_center -->
		</div> <!-- .content end -->
	</div> <!-- .content_wrapper end -->
</div> <!-- #maincontent end -->
 
	 
</body>
</html>