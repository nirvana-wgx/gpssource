/**
 * ToolBar的jquery插件。
 * 日期：2012年7月5日 09:08:33
 * 作者：Leon.Wang
 * Email: wang_yunlong@163.com
 * Copyright:湖南科创信息股份有限公司(chinacreator.com)。
 * readme：
 * 
 * log:
 */
(function($){
	
	var addTool = function(jQToolBar,tempObj){
		var defaults = {
				ico: "",
				text: "",
				event: null,
				enable: true,
				index: null
		};
		var options = $.extend(defaults, tempObj);
		if(getToolIndex(jQToolBar,options.text)){//判断同名的按钮是否存在。
			return;
		}
		
		var jQBtn = $('<a href="javascript:void(0)"><span class="toolbar_btn"><span class="toolbar_btn_ico"></span></span></a>');
		jQBtn.find(".toolbar_btn_ico").append(options.text);
		if(options.event && options.enable){//如果事件存在，且为可用的时候。
			jQBtn.bind("click",function(){
				options.event(this);
			});
		}
		if(!options.enable){//如果是禁用的按钮。
			jQBtn.find(".toolbar_btn").addClass("inactive");
		}
		jQBtn.find(".toolbar_btn_ico").addClass("toolbar_btn_"+options.ico);
		if(options.index){//在新增的时候，如果传递了序号。
			jQToolBar.find(".toolbar").find("a").eq(options.index).before(jQBtn);
		}else{
			jQToolBar.find(".toolbar").append(jQBtn);
		}
		//缓存该tool属性。
		$.data(document.body, options.text, options);
	};
	var getToolIndex = function(jQToolBar,toolText){
		var index = "";
		jQToolBar.find("a").each(function(i){
			if(jQuery.trim($(this).find(".toolbar_btn_ico").html()) == toolText){
				index += ","+i;
			}
		});
		if(index != ""){
			index = index.substring(1);
		}
		return index;
	};
	
	methodObj = {
		init: function(jQToolBar,params){//初始化的方法。
			//console.log($.isPlainObject(params));
			if(jQuery.isArray(params)){//判断传递是否为数组对象。
				if(!jQToolBar.find(".toolbar")[0]){//判断容器是否存在。
					jQToolBar.append("<div class=\"toolbar\"></div>");
				}
				$.each(params,function(i,tempObj){
					addTool(jQToolBar,tempObj);
				});
				//将初始化参数缓存
				$.data(document.body, jQToolBar.selector, params);
			}
		},add:function(jQToolBar, params){
			if($.isArray(params)){
				$.each(params,function(i,tempObj){
					addTool(jQToolBar,tempObj);
				});
			}else if($.isPlainObject(params)){
				addTool(jQToolBar,params);
			}
		},addsplit: function(jQToolBar, params){//新增分割线
			jQToolBar.find(".toolbar").find("a").eq(params).before("<span class='toolbar_separator'></span>");
		},delsplit: function(jQToolBar, params){//删除分割线
			jQToolBar.find(".toolbar").children("span").eq(params).remove();
		},disable: function(jQToolBar, params){//禁用的功能。
			//获得禁用按钮的序号
			var index = getToolIndex(jQToolBar, params);
			if(index.indexOf(",") > -1){
				return;
			}
			//克隆指定的按钮，将其的事件去除，同时设置样式类。
			var jqClonBtn = jQToolBar.find("a").eq(index).clone().addClass("inactive").attr("href","javascript:void(0)");
			jqClonBtn.removeAttr("id");
			jQToolBar.find("a").eq(index).hide();
			jQToolBar.find("a").eq(index).before(jqClonBtn);
			
		},enable: function(jQToolBar, params){//启用的功能。
			var index = getToolIndex(jQToolBar, params);
			if(index.indexOf(",") > -1){
				jQToolBar.find("a").eq(index.split(",")[1]).show();
				jQToolBar.find("a").eq(index.split(",")[0]).remove();
			}
		},del: function(jQToolBar, params){//删除的功能。
			var index = getToolIndex(jQToolBar, params);
			jQToolBar.find("a").eq(index).remove();
		},commList: function(jQToolBar){//列表常用的BUTTON。
			var toolsArray = new Array();
			var search = {ico:"search",text:"查询",event:function(){try {toQuery();} catch (e) {}}};
			toolsArray.push(search);
			var clear = {ico:"clear",text:"重置",event:function(){try {toClear();} catch (e) {}}};
			toolsArray.push(clear);
			var add = {ico:"add",text:"新增",event:function(){try {toForm();} catch (e) {}}};
			toolsArray.push(add);
			var edit = {ico:"edit",text:"修改",event:function(){try {toForm();} catch (e) {}}};
			toolsArray.push(edit);
			var remove = {ico:"remove",text:"删除",event:function(){try {toDelete();} catch (e) {}}};
			toolsArray.push(remove);
			var filesave = {ico:"filesave",text:"保存",enable:false,event:function(){try {toSave();} catch (e) {}}};
			toolsArray.push(filesave);
			var undo = {ico:"undo",text:"返回",enable:false,event:function(){try {toReturn();} catch (e) {}}};
			toolsArray.push(undo);
			
			this.init(jQToolBar, toolsArray);
			
		},commForm: function(jQToolBar){//表单常用的BUTTON。
			var toolsArray = new Array();
			var search = {ico:"search",text:"查询",enable:false,event:function(){try {toQuery();} catch (e) {}}};
			toolsArray.push(search);
			var clear = {ico:"clear",text:"重置",enable:false,event:function(){try {toClear();} catch (e) {}}};
			toolsArray.push(clear);
			var add = {ico:"add",text:"新增",enable:false,event:function(){try {toForm();} catch (e) {}}};
			toolsArray.push(add);
			var edit = {ico:"edit",text:"修改",enable:false,event:function(){try {toForm();} catch (e) {}}};
			toolsArray.push(edit);
			var remove = {ico:"remove",text:"删除",enable:false,event:function(){try {toDelete();} catch (e) {}}};
			toolsArray.push(remove);
			var filesave = {ico:"filesave",text:"保存",event:function(){try {toSave();} catch (e) {}}};
			toolsArray.push(filesave);
			var undo = {ico:"undo",text:"返回",event:function(){try {toReturn();} catch (e) {}}};
			toolsArray.push(undo);
			
			this.init(jQToolBar, toolsArray);
		},addQueryComp : function(jQToolBar, params){ //添加查询控件：创建新的控件
			jQToolBar.find(".toolbar").addQueryComp(params);
		},buildQueryComp : function(jQToolBar, params){ //添加查询控件：重构表单内容，将label提取出来作为下拉菜单的显示值，将表单控件克隆出来作为查询控件
			jQToolBar.find(".toolbar").buildQueryComp(params);
		}
		
	};
	
	$.fn.toolBar = function (method,params){
		if(typeof method == "string" && params){
			methodObj[method]($(this),params);
		}else{
			methodObj[method]($(this));
		}
	};
	
/** -------------------------------------
添加查询控件：创建新的控件
@Author : xiaoqing.qiu
@Date : 2012-7-20
------------------------------------------*/	
	$.fn.addQueryComp = function(opts){
		var defaults = {
			/*
			menuItems 必须项，对象形式如下：
					{displayValue:显示在下拉菜单上的值,
					realValue:实际用于查询操作需要传递的值,
					compType:查询控件的类型（支持'text','select','date'）,
					options:一个数组，当compType='select'时传给下拉框的数据，
						形如：{value: 实际用于查询操作需要传递的值,, label: 下拉框中的显示值}
				   }
			*/
			menuItems : [],
			/**必须项，执行查询操作的回调函数*/
			queryFunc : function(){},
			//下面是可选项
			id : "",
			selectedIndex : 0,
			container : ""
		};
		
		//生成查询控件	作为container的子元素
		var createElement = function(container, opts){
			$(container).append("<div id='"+opts.id+"' class='queryComp'></div>");
			var box = $(container).find('#'+opts.id);
			var param = opts.menuItems[opts.selectedIndex];
			switch(param.compType){
				case "date":
					$(box).append("<input type='text' name='queryComp' class='Wdate search_query_box'/>");
					var wdate = $(box).find('input.Wdate');
					$(wdate).bind(param.bindEvent);
					break;
				case "select":
					var select = "<select name='queryComp' class='search_query_box'>";
					$.each(param.options,function(index,item){
						select += "<option value='"+item.value+"'>"+item.label+"</option>";
					});
					select += "</select>";
					$(box).append(select);
					break;
				case "text":
				default:
					$(box).append("<input type='text' name='queryComp' class='input_text search_query_box menu_label_init' value='"+param.displayValue+"' />");
					//文本框绑定事情
					$(box).find('input[name=queryComp]').bind({
						'focus': function(){
							if($(this).hasClass('menu_label_init')){
								$(this).val("");
								$(this).removeClass('menu_label_init');
							}
						},'keyup': function(e){
							var currKey=0,e=e||event;
							currKey=e.keyCode||e.which||e.charCode;
							if(currKey == 13){ //回车触发查询
								$(comp).find("span[name='search_icon']").trigger('click');
							}
						}
					});
					break;
			}
			$(box).append("<span name='search_icon' class='span_search_icon'></span><span name='dropdown_icon' class='span_dropdown_icon'></span>");
		};	
		//生成下拉菜单
		var createDropdownList = function(opts){
			var strHtml = "<div class='dropdownlist_normal' target='"+opts.id+"' style='position:absolute;display:none;'><ul>";
			var items = opts.menuItems;
			var menu = "";
			$.each(items, function(i, item){
				var liClass = "menuItem_normal";
				var iconClass = "menuItem_icon";
				if(i==opts.selectedIndex){
					liClass = "menuItem_normal menuItem_selected"; 
					iconClass = "menuItem_icon menuItem_icon_selected"
				}
				menu +="<li class='"+liClass+"' realValue='"+item.realValue+"' compType='"+item.compType+"'><span class='"+iconClass+"'></span>"
					+"<span class='menu_label_normal'>"+item.displayValue+"</span></li>";
			});
			strHtml = strHtml+menu+"</ul></div>";
			return strHtml;
		};
		
		var init = function(opts){
			$(document.body).append(createDropdownList(opts)); //生成下拉菜单
			createElement($(opts.container), opts); //根据选中菜单指定的类型生成查询组件
			
			var comp = $(opts.container).find("div#"+opts.id)[0];
			var ddList = $(document.body).find("div[target="+opts.id+"]");
			var h = parseInt($(ddList).find('li').css('height'));
			$(ddList).css({
				'width':'140px',
				'height':opts.menuItems.length*h+'px',
				'top':comp.getBoundingClientRect().bottom+"px",
				'right':($(document).width() - comp.getBoundingClientRect().right)+"px"
			});
			$(ddList).find('li').each(function(index){
				$.data(this, 'menuData', opts.menuItems[index]);
				$(this).bind('click', function(){//绑定鼠标事件
					//修改样式
					$(ddList).find('li.menuItem_selected').removeClass("menuItem_selected");
					$(ddList).find('span.menuItem_icon_selected').removeClass("menuItem_icon_selected");
					$(this).addClass("menuItem_selected");
					$(this).find('span.menuItem_icon').addClass("menuItem_icon_selected");
					//隐藏下拉菜单
					$(ddList).hide();
					//根据选中菜单项指定的类型更新查询组件
					var type = $(this).attr("compType");
					switch(type){
						case 'date':
							//如果原来不是日期控件，用日期控件替换当前的元素
							if(!$(comp).find("[name='queryComp']").hasClass("Wdate")){
								$(comp).find("input[name='queryComp']").replaceWith("<input type='text' name='queryComp' class='Wdate search_query_box'/>");
							}
							var wdate = $(comp).find('input.Wdate');
							$(wdate).bind($.data(this, 'menuData').bindEvent);
							break;
						case 'select':
							var select = "<select name='queryComp' class='search_query_box'>";
							var options = $.data(this, 'menuData').options;
							$.each(options,function(index,item){
								select += "<option value='"+item.value+"'>"+item.label+"</option>";
							});
							select += "</select>";
							$(comp).find("input[name='queryComp']").replaceWith(select);
							break;
						case 'text':
						default:
							//如果原来不是文本框，用文本框替换当前的元素
							if($(comp).find("[name='queryComp']").attr('type')!='text' || $(comp).find("[name='queryComp']").hasClass("Wdate")){
								$(comp).find("[name='queryComp']").replaceWith("<input type='text' name='queryComp' class='input_text search_query_box'/>");
								//文本框绑定事情
								$(comp).find('input[name=queryComp]').bind({
									'focus': function(){
										if($(this).hasClass('menu_label_init')){
											$(this).val("");
											$(this).removeClass('menu_label_init');
										}
									},'keyup': function(e){
										var currKey=0,e=e||event;
										currKey=e.keyCode||e.which||e.charCode;
										if(currKey == 13){ //回车触发查询
											$(comp).find("span[name='search_icon']").trigger('click');
										}
									}
								});
							}
							var textInput = $(comp).find('input[name=queryComp]');
							//如果用户没有在当前文本框中输入过值，将选中菜单项的文本赋给文本框
							if($(textInput).val() == null || $.trim($(textInput).val())=="" || $(textInput).hasClass("menu_label_init")){
								$(textInput).val($(this).find('span.menu_label_normal').html());
								$(comp).find('input[name=queryComp]').addClass('menu_label_init');
							}else{//文本框有用户输入的值，直接触发查询
								$(comp).find("span[name='search_icon']").trigger('click');
							}
							break;
					}
				});
			});
			//文本框绑定事件
			$(comp).find('input[name=queryComp]').bind({
				'focus': function(){
					if($(this).hasClass('menu_label_init')){
						$(this).val("");
						$(this).removeClass('menu_label_init');
					}
				},'keyup': function(e){
					var currKey=0,e=e||event;
					currKey=e.keyCode||e.which||e.charCode;
					if(currKey == 13){ //回车触发查询
						$(comp).find("span[name='search_icon']").trigger('click');
					}
				}
			});
			//查询按钮绑定事件
			$(comp).find("span[name='search_icon']").bind("click", function(){
				if($(comp).find('input[name=queryComp]').hasClass('menu_label_init')){
					return;
				}
				if(typeof opts.queryFunc == 'function'){
					var cond = $(ddList).find('li.menuItem_selected').attr('realValue');
					var value = $(comp).find('[name=queryComp]').val();
					var param = {};
					param[cond] = value;
					opts.queryFunc(param);
				}
			});
			//下拉小箭头绑定事件
			$(comp).find("span[name='dropdown_icon']").bind("click", function(event){
				event = event || window.event;
				stopPropagation(event);
				if($(ddList).css("display")=="none"){
					$(ddList).show();
					$(document.body).bind('click', closeDDList);
				}else{
					$(ddList).hide();
					$(document.body).unbind('click', closeDDList);
				}
			});
			
		};
		var closeDDList = function(event){
			var ddList = $(document.body).find("div[target="+options.id+"]")[0];
			$(ddList).hide();
		};
		
		var options = $.extend(defaults, opts);
		if(!options.id || options.id==""){
			options.id = "queryComp_"+parseInt(Math.random() * 1000);
		}
		if(!options.container || options.container==""){
			options.container = this;
		}
		init(options);
	};
	
/** -------------------------------------
添加查询控件：重构表单内容，将label提取出来作为下拉菜单的显示值，将表单控件克隆出来作为查询控件
@Author : xiaoqing.qiu
@Date : 2012-7-25
------------------------------------------*/
	$.fn.buildQueryComp = function(opts){
		var defaults = {
			id : "",
			formContainer:null,//包含多个表单控件的容器
			queryFunc : function(){},
			selectedIndex : 0,
			filterClass : "ignore",
			container : ""
		};
		//生成查询控件	作为container的子元素
		var createElement2 = function(container, opts){
			$(container).append("<div id='"+opts.id+"' class='toolbar_search'></div>");
			var box = $(container).find('#'+opts.id);
			//param对象的属性{displayValue:显示在下拉菜单上的文本,queryComp:作为查询按钮前面的表单控件的母本}
			var param = opts.menuItems[opts.selectedIndex];
			$(box).append("<div class='toolbar_searchbox'></div>");//包含表单控件的容器
			//添加表单控件
			if(param){
				var newQueryComp =$(param.queryComp).clone(true);
				if($(newQueryComp).is(":text") && $(newQueryComp).val() ==""){//文本框根据title属性添加灰色提示文本
					var title = param.displayValue;
					if($(newQueryComp).attr("title")){
						title = $(newQueryComp).attr("title");
					}
					if($(newQueryComp).hasClass("Wdate")){//日期控件去掉提示文本，与日期的验证冲突
						title="";
					}
					$(newQueryComp).val(title).addClass("toolbar_search_input_init");
					$(newQueryComp).bind({
						"focus": function(){
							if($(this).hasClass("toolbar_search_input_init")){
								$(this).removeClass("toolbar_search_input_init");
							}
							if(title==$(this).val()){
						//	if($(this).hasClass("toolbar_search_input_init") && title==$(this).val()){
								$(this).val("");
							}
						},
						"blur": function(){
							if($(this).val()==""){
								$(this).val(title).addClass("toolbar_search_input_init");
							}
						}
					});
				}
				$(box).find(".toolbar_searchbox").append(newQueryComp);
			}
			//添加查询按钮和下拉按钮
			$(box).append("<span name='search_icon' class='toolbar_search_ico'></span><span name='dropdown_icon' class='toolbar_search_arrow'></span>");
			layoutQueryBox($(box).find('.toolbar_searchbox'));
		};	
		//给位于查询按钮前面的表单控件添加靠左的样式
		var layoutQueryBox = function(queryBox){
			$(queryBox).children().each(function(){
				$(this).css('float', 'left');
				var h =  parseInt($(queryBox).css("height"));
				var w = parseInt($(queryBox).css("width"));
				if($(this).is("select")){
			//		$(this).css({'width':w+'px', 'height':h+'px'});
					$(this).css({'width':w+'px'});
				}else if($(this).is("input")){
					h -= parseInt($.curCSS(this, "paddingTop"));
					h -= parseInt($.curCSS(this, "paddingBottom"));
					h -= parseInt($.curCSS(this, "borderTopWidth"));
					h -= parseInt($.curCSS(this, "borderBottomWidth"));
					w -= parseInt($.curCSS(this, "paddingLeft"));
					w -= parseInt($.curCSS(this, "paddingRight"));
					w -= parseInt($.curCSS(this, "borderLeftWidth"));
					w -= parseInt($.curCSS(this, "borderRightWidth"));
			//		$(this).css({'width':w+'px', 'height':h+'px'});
					$(this).css({'width':w+'px'});
				}else if($(this).is("a.link_button_more")){
		//			$(this).css({'background-position':'center center',
		//						'position':'absolute', 'right':'1px','width':'16px', 'height':(h-4)+'px'});
					$(this).css({'background-position':'center center',
						'position':'absolute', 'right':'1px','width':'16px'});
				}
			});
		}
		//生成下拉菜单
		var createDropdownList = function(opts){
			var strHtml = "<div class='dropdownlist_normal' target='"+opts.id+"' style='position:absolute;display:none;'><ul>";
			var items = opts.menuItems;
			var menu = "";
			$.each(items, function(i, item){
				var liClass = "menuItem_normal";
				var iconClass = "menuItem_icon";
				if(i==opts.selectedIndex){//选中项的样式类
					liClass = "menuItem_normal menuItem_selected"; 
					iconClass = "menuItem_icon menuItem_icon_selected"
				}
				menu +="<li class='"+liClass+"' index='"+i+"'><span class='"+iconClass+"'></span>"//图标span
					+"<span class='menu_label_normal'>"+item.displayValue+"</span></li>";//文本span
			});
			strHtml = strHtml+menu+"</ul></div>";
			return strHtml;
		};
		//隐藏下拉菜单
		var closeDDList = function(event){
			var ddList = $(document.body).find("div[target="+options.id+"]")[0];
			$(ddList).hide();
		};
		
		//重组表单内容：将label提取出来作为下拉菜单的显示值，将表单控件克隆出来作为查询控件
		var getQueryCondition = function(options){
			var formContainer = options.formContainer;
			var filterClass = options.filterClass;//需要过滤的项
			var conds = new Array();
			$(formContainer).children("li").each(function(){
				if(filterClass == null || !$(this).hasClass(filterClass)){
					var label = $(this).find('label').html();
					var form = $(this).clone(true);
					form.find('label').remove();
					form = $(form).children();
					var canSupport = true;
					$.each(form, function(i, elem){
						if($(elem).is('input:checkbox, input:radio, input[type="hidden"]')){//过滤复选、单选框、隐藏域
							canSupport = false;
						}
					});
					if(canSupport){
						conds.push({displayValue:label,queryComp:form});
					}
				}
			});
			return conds;
		};
		
		var init = function(opts){
			$(document.body).append(createDropdownList(opts)); //生成下拉菜单
			createElement2($(opts.container), opts); //根据选中菜单指定的类型生成查询组件
			//查询控件
			var comp = $(opts.container).find("div#"+opts.id)[0];
			//下拉菜单
			var ddList = $(document.body).find("div[target="+opts.id+"]");
			//菜单中一行的高度
			var h = parseInt($(ddList).find('li').css('height'));
			h += parseInt($.curCSS($(ddList).find('li')[0], "paddingTop"));
			h += parseInt($.curCSS($(ddList).find('li')[0], "paddingBottom"));
			h += parseInt($.curCSS($(ddList).find('li')[0], "borderTopWidth"));
			h += parseInt($.curCSS($(ddList).find('li')[0], "borderBottomWidth"));
			//定位菜单
			$(ddList).css({
				'height':opts.menuItems.length*h+'px'
			});
			//菜单项绑定事件
			$(ddList).find('li').each(function(index){
				$.data(this, 'menuData', opts.menuItems[index]);
				$(this).bind('click', function(){//绑定鼠标事件
					//修改下拉菜单项的样式
					$(ddList).find('li.menuItem_selected').removeClass("menuItem_selected");
					$(ddList).find('span.menuItem_icon_selected').removeClass("menuItem_icon_selected");
					$(this).addClass("menuItem_selected");
					$(this).find('span.menuItem_icon').addClass("menuItem_icon_selected");
					//隐藏下拉菜单
					$(ddList).hide();
					//修改查询控件的前面部分-表单控件
					$(comp).find(".toolbar_searchbox").children().remove();
					var newQueryComp = $($.data(this, 'menuData').queryComp).clone(true);
					if($(newQueryComp).is(":text") && $(newQueryComp).val() ==""){//文本框根据title属性添加灰色提示文本
						var title = $(this).find("span.menu_label_normal").html();
						if($(newQueryComp).attr("title")!=null){
							title = $(newQueryComp).attr("title");
						}
						if($(newQueryComp).hasClass("Wdate")){//日期控件去掉提示文本，与日期的验证冲突
							title="";
						}
						$(newQueryComp).val(title).addClass("toolbar_search_input_init");
						$(newQueryComp).bind({
							"focus": function(){
								if($(this).hasClass("toolbar_search_input_init")){
									$(this).removeClass("toolbar_search_input_init");
								}
								if(title==$(this).val()){
							//	if($(this).hasClass("toolbar_search_input_init") && title==$(this).val()){
							//		$(this).removeClass("toolbar_search_input_init");
									$(this).val("");
								}
							},
							"blur": function(){
								if($(this).val()==""){
									$(this).val(title).addClass("toolbar_search_input_init");
								}
							}
						});
					}
					$(comp).find(".toolbar_searchbox").append(newQueryComp);
					layoutQueryBox($(comp).find('.toolbar_searchbox'));
				});
			});
			
			//查询按钮绑定事件-执行查询动作
			$(comp).find("span[name='search_icon']").bind("click", function(){
				if(typeof opts.queryFunc == 'function'){
					var target = $(comp).find(".toolbar_searchbox").children(":first");
					var cond = $(target).attr('name');
					var value = "";
					if(!$(target).hasClass("toolbar_search_input_init")){
						value = $(target).val();
					}
					var param = {};
					param[cond] = value;
					opts.queryFunc(param);
				}
			});
			//下拉小箭头绑定单击事件-弹出/隐藏下拉菜单
			$(comp).find("span[name='dropdown_icon']").bind("click", function(event){
				var event = event || window.event;
				stopPropagation(event);
				if($(ddList).css("display")=="none"){
					$(ddList).show();
					//定位菜单
					$(ddList).css({
						'top':comp.getBoundingClientRect().bottom+"px",
						'right':($(document).width() - comp.getBoundingClientRect().right)+"px"
					});
					$(document.body).bind('click', closeDDList);
				}else{
					$(ddList).hide();
					$(document.body).unbind('click', closeDDList);
				}
			});
		};
		
		var options = $.extend(defaults, opts);
		if(!options.id || options.id==""){
			options.id = "queryComp_"+parseInt(Math.random() * 1000);
		}
		if(!options.container || options.container==""){
			options.container = this;
		}
		if(options.formContainer!=null){
			options.menuItems = getQueryCondition(options);
		}
		init(options);
	};
})(jQuery);