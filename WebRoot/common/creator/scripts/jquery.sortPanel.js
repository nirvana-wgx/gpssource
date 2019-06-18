/**
 *说明：sortPanel可拖拽的面。
 *作者：Leon.Wang 2012年7月12日 10:16:26
 *©湖南科创信息技术股份有限公司(chinacreator.com)
 */
(function($){
	var getPanelDefautlWidth = function(){
		return 350;
	};
	var getPanelDefautlHeight = function(){
		return 200;
	};
	//获得要分的ul节点数。
	var getContainerSize = function(){
		var winW = $(window).width();//屏幕宽度
		//var winH = $(window).height();//屏幕高度
		//console.log(winW);
		var colWidth = 370;//标准的宽度
		var conSize = parseInt(winW/colWidth);
		if(conSize == 0){//最少有一个ul节点。
			conSize = 1;
		}
		//console.log(conSize);
		return conSize;
	};
	//获得高度最低的列。
	var getColIndex = function(jQContainer,colsize){
		if(colsize > 1){
			var tempH = jQContainer.find(".column").eq(0).height();
			for(var i=0;i<colsize; i++){
				var colH = jQContainer.find(".column").eq(i).height();
				if(colH < tempH){
					tempH = colH;
				}
			}
			//tempH保存了最低的高度值
			//得到index.
			for(var i=0;i<colsize; i++){
				var colH = jQContainer.find(".column").eq(i).height();
				if(colH == tempH){
					return i;
				}
			}
		}else{
			return 0;
		}
	}
	//设置panel的容器节点。
	var setContainer = function(jQContainer){
		jQContainer.append('<div class="wrapper" style="margin: auto; padding-left:10px; display: inline-block; "></div>');
		var conHtml = '';
		var conSize = getContainerSize();
		for(var i=0; i<conSize; i++){
			conHtml +='<div class="column"></div>';
		}
		jQContainer.children("div").append(conHtml);
	};
	//初始化一个panel。
	var initOnePanel = function(obj){
		var panelH = obj.height;
		var panelW = obj.width;
		if(panelW == null || panelW == ""){
			panelW = getPanelDefautlWidth();
		}
		if(panelH <getPanelDefautlHeight()){
			panelH = getPanelDefautlHeight();
		}
		var panel_str = '<div class="portlet">';
		panel_str += '<div class="ui-widget-content sortpanel" id="'+obj.id+'" style="height:'+panelH+'px;width:'+panelW+'px;">';
		panel_str += '<div class="sortpanel_title sortpanel_title_blue">';
		panel_str += '<b>'+obj.title+'</b>';
		panel_str += '<span style="float: right;">';
		panel_str += '<a href="javascript:void(0)" class="sortpanel_btn_close">关闭 </a>';
		panel_str += '<a href="javascript:void(0)" class="sortpanel_btn_hide">收起 </a>';
		panel_str += '<a href="javascript:void(0)" class="sortpanel_btn_refresh">刷新 </a>';
		panel_str += '</span>';
		panel_str += '</div>';
		panel_str += '<div class="sortpanel_body">';
		panel_str += '</div>';
		panel_str += '</div>';
		panel_str += '</div>';
		return panel_str;
	};
	//设置面板的可拖拽大小、位置、关闭等基础的功能方法和事件。
	var initPanelEvent = function(params){
		//设置默认值。
		var defaults = {
				sortable: true
		};
		var options = $.extend(defaults, params);
		if(options.sortable){
			$(".column").sortable({
				connectWith: ".column"
			}).disableSelection();
		}
		$(".sortpanel").each(function(){
			//console.log($(this).attr("id"));
			if($.trim($(this).find(".sortpanel_btn_hide").html()) == "收起"){//如果当前panel状态为展开的状态，可以reszie。
				$(this).resizable({
					minHeight: 200,
					maxWidth: 348,
					minWidth: 348
				});
			}
		});
		$(".sortpanel_btn_close").unbind("click");
		$(".sortpanel_btn_close").bind("click",function(){//关闭按钮
			$(this).parentsUntil(".column").remove();
		});
		$(".sortpanel_btn_hide").unbind("click");
		$(".sortpanel_btn_hide").bind("click",function(){//显示、隐藏按钮
			//$(this).parentsUntil("ul").find(".sortpanel_body").hide();
			showOrHide($(this));
		});
		$(".sortpanel_btn_refresh").unbind("click");
		$(".sortpanel_btn_refresh").bind("click", function(){//刷新
			var panel_id = $(this).parentsUntil(".column").find(".sortpanel").attr("id");
			refreshPanel(panel_id);
		});
	};
	//控制面板的隐藏或显示。需要优化，不能出现中文。可以使用class等
	var showOrHide = function(jQShowBtn){
		var panel_id = jQShowBtn.parentsUntil("ul").find(".sortpanel").attr("id");
		if($.trim(jQShowBtn.html()) == "收起"){
			jQShowBtn.parentsUntil(".column").find(".sortpanel_body").hide();
			jQShowBtn.html("展开 ");
			var panel_height = jQShowBtn.parentsUntil(".column").find(".sortpanel").height();
			$.data(document.body, "sortpanel_"+panel_id, panel_height);
			jQShowBtn.parentsUntil(".column").find(".sortpanel").height(30);
			//收起后，控制不可以改变panel的大小。
			jQShowBtn.parentsUntil(".column").find(".ui-resizable-handle").hide();
		}else{
			jQShowBtn.parentsUntil(".column").find(".sortpanel_body").show();
			var panel_height = $.data(document.body, "sortpanel_"+panel_id);
			jQShowBtn.parentsUntil(".column").find(".sortpanel").height(panel_height);
			jQShowBtn.html("收起 ");
			//如果控制大小的div存在，只需要显示。
			if(jQShowBtn.parentsUntil(".column").find(".ui-resizable-handle")[0]){
				jQShowBtn.parentsUntil(".column").find(".ui-resizable-handle").show();
			}else{
				jQShowBtn.parentsUntil(".column").find(".sortpanel").resizable({
					minHeight: 200,
					maxWidth: 348,
					minWidth: 348
				});
			}
		}
	};
	//刷新面板
	var refreshPanel = function(panelId){
		//console.log(panelId);
		//增加刷新
		var penalObj = $.data(document.body, "sort_panel_obj_"+panelId);
		if($.trim(penalObj.url) == ""){
			return;
		}
		$("<div class=\"datagrid-mask\"></div>").css({display:"block", width:"100%",height:$("#"+panelId).height()}).appendTo("#"+panelId);
		$("<div class=\"datagrid-mask-msg\"></div>").html("").appendTo("#"+panelId).css({display:"block",left: ($("#"+panelId).outerWidth(true) - 120) / 2,top:($("#"+panelId).height() - 45) / 2});
		$("#"+panelId).children("div").eq(1).load("."+penalObj.url, function(){
			$(".datagrid-mask-msg").remove();
			$(".datagrid-mask").remove();
		});
	};
	
	methodObj = {
		initPanels: function(jQContainer,params){//初始化面板。
			setContainer(jQContainer);
			$.ajax({
				url: params.url,
				type:"POST",
				dataType:"json",
				cache:false,
				async:false,
				success: function(resp){
					//var winW = $(window).width();//屏幕宽度
					//var lastpx = winW;
					$.each(resp, function(i){
						$.data(document.body, "sort_panel_obj_"+this.id, this);
						var conSize = jQContainer.find(".column").size();
						//var conIndex = i%conSize;
						var conIndex = getColIndex(jQContainer, conSize);
						//lastpx = lastpx - this.width;
						//if(this.width == null || this.width < getPanelDefautlWidth()){
						//	this.width = getPanelDefautlWidth();
						//}
						//if(conIndex == conSize -1){
						//	this.width = this.width + lastpx;
						//	lastpx = winW;
						//}
						//alert(i+"-conIndex-->"+conIndex + "-conSize-->"+conSize);
						var str = initOnePanel(this);
						jQContainer.find(".column").eq(conIndex).append(str);
						if(this.url && $.trim(this.url) != ""){
							$("#"+this.id).children("div").eq(1).load("."+this.url);
						}
					});
				}
			});
			initPanelEvent(params);
			var containerSizeB = jQContainer.find(".column").size();//当前ul的节点数。
			$(window).resize(function(){
				//console.log("窗口大小"+$(window).width());
				var containerSizeE = getContainerSize();//应该有的ul节点树。
				if(containerSizeB != containerSizeE){
					var jQPanels = jQContainer.find(".portlet").clone();
					jQContainer.html("");
					setContainer(jQContainer);
					$.each(jQPanels,function(i){
						var conSize = jQContainer.find(".column").size();
						//var conIndex = i%conSize;
						var conIndex = getColIndex(jQContainer, conSize);
						$(this).find(".ui-resizable-handle").remove();
						jQContainer.find(".column").eq(conIndex).append($(this));
					});
				}
				initPanelEvent(params);
				containerSizeB = containerSizeE;
			});
		}
	};
	
	$.fn.sortPanel = function (method,params){
		methodObj[method]($(this),params);
	};
})(jQuery);