/**
 *说明：tabs的UI插件。
 *作者：Leon.Wang
 *日期：2012年5月8日 14:52:33
 *@Copyright：湖南科创信息股份有限公司(chinacreator.com)
 *@Email:wang_yunlong@163.com
 *使用说明：
 *
 *
 *
 */
(function($){
	//内部封装。
	$.fn.innerTabsMethods = {
		init:function(jqtabsObje){//tabs页签的初始化。
			jqtabsObje.children("div").children("div").hide();
			jqtabsObje.children("div").children("div").eq(0).show();
		},
		getIndex:function(jqtabsObj,jqliObject){//根据li的对象，获得li的index。
			var tabIndex = 0;
			var tabtitle = "";
			if(typeof jqliObject == "string"){
				tabtitle = jqliObject;
			}else{
				tabtitle = jqliObject.find(".form_tabs_text").text();
			}
			$.each(jqtabsObj.children("ul").find("li"),function(i,templiObject){
				if($(templiObject).find(".form_tabs_text").text() == tabtitle){
					tabIndex = i;
				}
			});
			return tabIndex;
		},
		select:function(jqtabsObj,jqliObject){//选择的方法。
			var tabIndex = $.fn.innerTabsMethods.getIndex(jqtabsObj, jqliObject);
			jqtabsObj.children("ul").find("li").removeClass();
			jqtabsObj.children("ul").find("li").toggleClass("form_tabs_normal");
			jqtabsObj.children("ul").find("li").children().removeClass();
			jqtabsObj.children("ul").find("li").children().toggleClass("form_tabs_span");
			jqtabsObj.children("ul").find("li").eq(tabIndex).removeClass();
			jqtabsObj.children("ul").find("li").eq(tabIndex).toggleClass("form_tabs_selected");
			jqtabsObj.children("ul").find("li").eq(tabIndex).children().removeClass();
			jqtabsObj.children("ul").find("li").eq(tabIndex).children().toggleClass("form_tabs_selected_span");
			jqtabsObj.children("div").children("div").hide();
			jqtabsObj.children("div").children("div").eq(tabIndex).show();
		},
		close:function(jqTabsObj, jqcloseSpan){
			//给关闭按钮span的父级元素li解除点击事件。
			jqcloseSpan.parentsUntil("li").parent().unbind("click");
			//获得关闭页签的tabIndex
			var tabIndex = $.fn.innerTabsMethods.getIndex(jqTabsObj,jqcloseSpan.parentsUntil("li").parent());
			//获得当前页签title的样式，用于标识是否被选择了。
			var currClass = jqcloseSpan.parentsUntil("li").parent().attr("class");
			//删除内容。
			jqTabsObj.children("div").children("div").eq(tabIndex).remove();
			//删除标题。
			jqcloseSpan.parentsUntil("ul").remove();
			//当前tabs页签没有被打开。
			if(currClass == "form_tabs_selected"){
				if(tabIndex>0){//如果删除的不是第一个,默认让上一下tabs也签被选中。
					var jqliObject = jqTabsObj.children("ul").find("li").eq(tabIndex-1);
					$.fn.innerTabsMethods.select(jqTabsObj,jqliObject);
				}else{
					var jqliObject = jqTabsObj.children("ul").find("li").eq(tabIndex);
					$.fn.innerTabsMethods.select(jqTabsObj,jqliObject);
				}
			}
		}
	};
	
	//定义tabs初始化的一些方法。
	$.fn.tabsInit = function(jqTabsObj,options){
		//设置默认参数。
		var defaults = {
			text:"",//tabs页签的标题。
			height:"600px",//高度。auto
			closable:false,//是否可以关闭。false：不能关闭。true：可以关闭。
			onSelect:null//当选中某个页签后的事件。
		};
		//合并默认值和传递的参数。
		var options = $.extend(defaults, options);
		//调用初始化的方法。
		$.fn.innerTabsMethods.init(jqTabsObj);
		//给每个tabs标题的li绑定点击事件
		jqTabsObj.children("ul").find("li").bind("click",function(){
			$.fn.innerTabsMethods.select(jqTabsObj, $(this));
			if(options.onSelect && typeof options.onSelect == "function"){
				options.onSelect($(this).find(".form_tabs_text").html(),this);
			}
		});
		//给每个li对应的tab容器div增加属性tabtitle
		jqTabsObj.children("ul").find("li").each(function(i){
			jqTabsObj.children("div").children("div").eq(i).attr("tabtitle",$(this).find(".form_tabs_text").html());
		});
		
		//关闭按钮点击事件。
		jqTabsObj.children("ul").find(".form_tabs_close").bind("click",function(){
			$.fn.innerTabsMethods.close(jqTabsObj, $(this));
		});
		var jqliObject = jqTabsObj.children("ul").find("li").eq(0);
		$.fn.innerTabsMethods.select(jqTabsObj,jqliObject);
		
	};
	//定义tabs提供的方法。
	$.fn.tabsMethods = function(methodName, options, tabsObj){
		var defaults = {
				index:null,
				textTitle:"",//tabs页签的标题。
				content:"",//tabs页签对应的内容。
				href:"",//tabs加载地址。
				closable:false//是否可以关闭，默认为不能关闭。true：可以关闭。
		};
		if(typeof options == "object"){
			//合并默认值和传递的参数。
			var options = $.extend(defaults, options);
		}
		
		//定义变量，页签头部的html,页签标题span的html。关闭按钮的html，内容容器的html。
		var titleHtml = "<li class='form_tabs_selected'><span class='form_tabs_selected_span'></span></li>";
		var closeSpanHtml = "<span class='form_tabs_close'></span>";
		var contentHtml = "<div class='form_fieldset'></div>";
		if(methodName == "add"){//新增tabs的方法。
			var titleSpanHtml = "<span class='form_tabs_text'>"+options.textTitle+"</span>";
			var titleObj = $(titleHtml);
			if(options.closable){//如果新增的tabs是可以关闭的。
				titleObj.find("span").append(titleSpanHtml+closeSpanHtml);
			}else{
				titleObj.find("span").append(titleSpanHtml);//如果不可以关闭。
			}
			tabsObj.children("ul").append(titleObj);//开始添加页签的标题。
			//在tabs内容的主容器中添加一个div。
			tabsObj.children("div").append(contentHtml);
			//添加页签对应的内容。
			if(options.href && options.href.length>0){
				//取内容主容器中的最后一个div，然后让它load。
				tabsObj.children("div").children("div").last().load(options.href);
			}else{
				tabsObj.children("div").children("div").last().append(options.content);
			}
			//绑定页签标题的事件。
			titleObj.bind("click",function(){
				$.fn.innerTabsMethods.select(tabsObj, $(this));
			});
			//绑定关闭按钮的事件。
			titleObj.find(".form_tabs_close").bind("click",function(){
				$.fn.innerTabsMethods.close(tabsObj, $(this));
			});
			//使新增的tabs页被选择。
			$.fn.innerTabsMethods.select(tabsObj,titleObj);
		}else if(methodName == "delete"){//删除tabs的方法。
			if(options.index){
				var jqcloseSpan = tabsObj.children("ul").find(".form_tabs_close").eq(options.index);
				$.fn.innerTabsMethods.close(tabsObj, jqcloseSpan);
				return;
			}else if(options.textTitle){
				var tempIndex = null;
				$.each(tabsObj.children("ul").find("li"),function(i,tempLiObj){
					if($(tempLiObj).children("span").find("span").eq(0).text() == options.textTitle){
						tempIndex = i;
					}
				});
				if(tempIndex){
					var jqcloseSpan = tabsObj.children("ul").find(".form_tabs_close").eq(tempIndex);
					$.fn.innerTabsMethods.close(tabsObj, jqcloseSpan);
					return;
				}
			}
		}else if(methodName == "select"){
			$.fn.innerTabsMethods.select(tabsObj,options);
		}
	};
	//外部调用的js方法。
	$.fn.tabs = function(param1, param2){
		if(typeof param1 == "string"){
			$.fn.tabsMethods(param1, param2, this);
		}else{
			$.fn.tabsInit(this,param1);
		}
	};
})(jQuery);

jQuery(function($){
	$(".form_maincontent").tabs();
});