/* ------------------------------------------------------------------
 * 右击菜单控件
 * Name : contextMenu 
 * version : 1.01beta
 * Date : 8th November 2012
 * update : 12th December 2012
 * Written by : Jian.Hou
 * -------------------------------------------------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	//$.datagridColumnContextMenu 对象
	$.datagridColumnContextMenu = {

		//设置选项
		setting : {
			pane :				 'dropmenu',//contextMenu菜单容器
			submenuPane :		 'dropmenu_submenu',//contextMenu菜单容器
			shadowClass :		 'dropmenu_shadow',//contextmenu 阴影样式
			submenuClass :		 '.dropmenu_arrow', //子菜单的class
			separateclass :		 'dropmenu_separate',
			divClass :			 'table_datagrid',//Datagrid 插件动态添加的'div'的classname
			datagridClass :  	 'datagrid_pane',//数据表pane的classname
			freezeItemClass:	 'inactive',//传入冷冻菜单项class
			freezeIcoClass:		 'inactive',//冷冻菜单项class			
			freezeListClass:	 'contextmenu_freeze',//冷冻菜单项class
			icoClass :			 'ico_ok', //状态图标classname
			hoverClass :		 'contextmenu_item_hover', //状态图标classname
			specialMode :  		 true,//使用特定的对象构造
			btnClass :			 '',
			offsetX :			 -1,//与事件位置的水平偏移量
			offsetY :			 0,//与事件位置的垂直偏移量
			shadowOffsetX :		 5,//与pane位置的水平偏移量
			shadowOffsetY :		 5,//与pane位置的垂直
			eventMode :			 true,//使用右击事件或者事件定位置，否则使用元素定位
			shown :				 false, //判断是否contextMenu已经显示，'true'表示显示、'false'表示未显示
			itemMarginRight :	 26,//contextMenu菜单内容与面板的右边距离，解决IE、firefox下绝对定位的子内容不能显示完整宽度的bug
			menuMargin :		 10,
			paneWidth :			 'disable'//contextMenu菜单面板宽度,参数为数字类型或'disable'
		},	//end

		//extend
		extend : function(opts) {
			return $.extend(this.setting || {}, opts);	
		},//end	
		
		//通过递归方法找到父级指定对象
		parents : function (element, classname) {	
			if(element.parent(classname).length > 0) {
				return element.parent(classname);
			} else {
				return this.parents(element.parent(), classname);
			}
		}, //end

		//动态构建HTML结构
		//element-调用create方法的context对象
		coustructor : function(element, arg) {	
			//获取事件的body对象
		    var body = $(element).parents('body'),
				contextMenu = this,
				setting = this.setting,
				html = '',
				pane = null,
				menu = arg.items,
				methods = {};				
			
				//解析对象的结构				
				for (var i = 0; i < menu.length; i++) {
					var item = menu[i];		
					switch (item.type) {
						case 'separate' :
							html +=	'<li class="' + setting.separateclass + '"></li>';
							break;
						case 'item' : 
							html += this.spliceItem(item, methods);	
							break;
						case 'submenu' :  
							var submenu = item.subMenuDefine;
							html +=	'<li><a class="dropmenu_item '
								 + item.arrow 
								 + '" href="javascript:void(0)">'
								 + '<span class="dropmenu_ico '
								 + item.ico 
								 + 'toolbar_btn_remove"></span>'
								 + item.name 
								 + '</a><div class="dropmenu_submenu"><ul>';						
							for (var j = 0, items = submenu.items; j < items.length; j++) {
								var subItem = items[j];
								html += this.spliceItem(subItem, methods);
							}
							html += '</ul></div></li>'
							break;
					}					
				}											
				//把遍历封装好的HTML代码包装contextMenu容器
				html = $('<div class=\"'
					 + setting.pane
					 + '\"><ul>' 
					 + html 
					 + '</ul></div>');
				//html所有结构缓存到body节点
				html = $.data(document.body, 'html', html);
				//插入文档的末端
				body.append(html);
				pane = $('.' + setting.pane);
				html = $('<div class="' + setting.shadowClass + '"></div>');
				html.insertAfter(pane);	
				return methods;
		},//end
		
		//拼接HTML字符串
		spliceItem: function(item, methods) {	
			//无图标默认空字符串
			var ico = item.ico || '',	
				name = item.name || 'undefined',
				checkbox = item.checkbox || false,
				handler = item.handler,
				value = item.value,				
				freeze = item.disable;
			
			if (handler) {
				value ? methods[value] = handler : methods[name] = handler;
			}

			value = value ? 'field=\"' + value + '\"' : '';
			freeze = freeze ? 'class=\"' + this.setting.freezeListClass + '\" ' : '';
			if (checkbox) {
				var status = checkbox === 'checked' ? 'checked="checked"' : '';
				return	'<li '
						+ value
						+ freeze
						+ '><a class=\"dropmenu_item\" href=\"javascript:void(0)\"><span class=\"dropmenu_checkbox\" ><input type=\"checkbox\" ' 
						+ status
						+ '/></span>'
						+ name 
						+ '</a></li>';			
			} else {	
				return  '<li '
						+ value
						+ freeze
						+ '><a class=\"dropmenu_item\" href=\"javascript:void(0)\"><span class=\"dropmenu_ico ' 
						+ ico 
						+ '\"></span>'
						+ name
						+ '</a></li>';	
			}		
		}, //end
		

		//通过递归方法找到父级指定对象
		parents : function (element, selector) {	
			if(element.parent(selector).length > 0) {
				return element.parent(selector);
			} else {
				return this.parents(element.parent(), selector);
			}
		}, //end	

		getMenuStyle : function() {
			var menu = $('.' + this.setting.pane);
			return {width: menu.outerWidth(), off: menu.offset(), pos: menu.position()};
		},			

		//获取contextMenu显示的位置
		//鼠标相对文档的位置加设设置的偏移量
		//返回这个对象
		getPosition : function(event) {			
			var setting = this.setting,
				body = document.body,
				x = 0,
				y = 0;
			body.width = $(body).width();
			//判断是否事件定位置还是使用元素定位
			if (setting.eventMode) {
				x = event.pageX + setting.offsetX,
				y = event.pageY + setting.offsetY;
				var menuStyle = this.getMenuStyle(),
					result = body.width - x;
				if (result < menuStyle.width) {
					if ($.isIE7Le() && result < 0) {
						x = x - menuStyle.width - 50;
					} else {
						x = x - menuStyle.width;
					}
				}
			} else {
				//可包含
				var btn = $(event.target);	
				//如果按钮应该是父对象，则找寻它的父对象		
				if (btn.hasClass(setting.btnClass)) {
					btn = $(event.target).parent();
				}				
				var height = btn.outerHeight();
				//当对文档偏移量
				x = btn.offset().left + setting.offsetX;
				y = btn.offset().top + height + setting.offsetY;						
			}
			return { x: x, y: y };
		},//end

		//初始化，给容器初始化宽度
		//给每个菜单项绑定事件
		init : function(element, methods) {
			//contextMenu容器
			var contextMenu = this,
				setting = this.setting,
				pane = $('.' + setting.pane),
				submenuPane = $('.' + setting.submenuPane),
				//contextMenu菜单项
				contextMenuItem = pane.find('li'),
				i,
				width,
				children,
				sibling,
				//funcStr,
				params;
			
			//筛选获取item中的最大内容宽度
			for (i = 0; i < contextMenuItem.length; i++) {				
				//绑定单击事件
				$(contextMenuItem[i]).on('click', function(event) {					
					var event = event || window.event,
						target = event.target || event.srcElement,
						func;
					//调用contextMenu的hide方法，隐藏菜单和菜单阴影
					event.stopPropagation();//移除单击文档隐藏对菜单对象的影响					
					if(methods[$(this).attr("field")]){
						func = methods[$(this).attr("field")];
					}else if(methods[$(this).text()]){
						func = methods[$(this).text()];
					}
					/*
					funcStr = func.toString();
					try {
						//获取func的实参
						params = /function\s*\(([a-z|A-Z|0-9|\s|,]+)\)/.exec(funcStr)[1];
					} catch(e) {
						params = '';
					}
					eval('func\(' + params + '\)');
					*/
					
					if ($(this).hasClass(setting.freezeListClass)) {
						contextMenu.hide();
						return false;
					}
					//扩大checkbox的范围，使checkbox更容易选中
					var span = $(this).find('.dropmenu_checkbox'),
						checkbox = $(this).find(':checkbox'),
						value = $(this).attr('field'),						
						status;
					
					if (value && checkbox.length > 0) {
						status = checkbox.prop('checked');
						if(!$(event.target).is(":checkbox")){
							status = !status;
						}
						params = 'value, status';
					}
					//调用event方法		
					eval('func\(' + params + '\)');
					checkbox = checkbox.add(span);
					if (!$(event.target).is(checkbox)) {
						contextMenu.hide();
					}
				});		
			}			
			//给contextMenu pane设置宽度，无宽度无法正常显示
			if (typeof setting.paneWidth === 'number') {
				pane.css('width', setting.paneWidth + 'px');
			}
		},//end

		
		//子菜单展开方法
		submenu : function($elem) {
			var setting = this.setting,
				submenu = $elem.children('.dropmenu_submenu'),	
				body = document.body,
				menuStyle = this.getMenuStyle();
			
			body.height = $(body).height();
			submenu.hide();//contextmenu_submenu_shadow
			var html = $('<div class="dropmenu_submenu_shadow"></div>');
			$elem.append(html);
			var shadow = $('.dropmenu_submenu_shadow');

			//子菜单面板
			/*
			var width = submenu.outerWidth();
			if (!$.browser.webkit) {
				submenu.css('width', width + setting.itemMarginRight + 'px');
			}
			*/
			shadow.hide();	
			$elem.on('mouseenter', function(event) {
				event.stopPropagation();	
				var left = $elem.width();
				submenu.show().css({top: 0, left: left + 'px'});	
				var submenuHeight = submenu.outerHeight(),
					submenuWidth = submenu.outerWidth(),
					submenuOffset = submenu.offset(),
					resultH = submenuHeight + menuStyle.pos.top + submenuOffset.top - menuStyle.off.top - body.height,
					resultW = submenuWidth + menuStyle.pos.left + submenuOffset.left - menuStyle.off.left - body.width;
				if (resultW > 0){
					left = -submenuWidth - 3;
					submenu.css('left', left + 'px');
				}
				if (resultH > 0) {
					var height = submenuHeight - resultH - setting.menuMargin;
					submenu.css('height', height + 'px');
				}
				shadow.show().css({
					width :		submenu.outerWidth() - 5 + 'px',
					height :	submenu.outerHeight() - 5 + 'px',
					left :		left + setting.shadowOffsetX + 'px',
					top :		setting.shadowOffsetY + 'px',
					zIndex :	8
				});	
			});
			/*
			$elem.on('mouseout', function(event){				
				submenu.hide();
				shadow.hide();
			});
			*/
			submenu.on('mouseleave', function(event) {
				event.stopPropagation();
				setTimeout(function() {
					submenu.fadeOut(100);
					shadow.fadeOut(100);
				}, 800);
			});
		},//end


		//显示，获取contextMenu的鼠标位置，设置contextMenu的显示的位置
		//设置文档单击和contextMenu事件时隐藏contextMenu
		show : function(event) {
			//调用获取位置方法得到pos对象
			var contextMenu = this,
				setting = this.setting,
				pane = $('.' + setting.pane),
				shadow = $('.' + setting.shadowClass),
				pos = contextMenu.getPosition(event);
			
			//设置contextMenu pane的位置和z-index的层顺序
			pane.css({ 				
				left :		pos.x + 'px',
				top :		pos.y + 'px',
				zIndex :	9999
			});
			
			//设置pane阴影层的宽度、高度、位置和z-index的层顺序
			shadow.css ({
				width :		pane.outerWidth() - 5 + 'px',
				height :	pane.outerHeight() - 5 + 'px',
				left :		pos.x + setting.shadowOffsetX + 'px',
				top :		pos.y + setting.shadowOffsetY + 'px',
				zIndex :	9998
			});

			//当contextMenu display：none时，显示pane和shadow
			pane.show();
			shadow.show();
			//设置显示现在的状态
			setting.shown = true;	
		},
		
		//隐藏contextMenu，设置shown值为false
		hide : function() {
			var setting = this.setting,
				pane = $('.' + setting.pane),
				shadow = $('.' + setting.shadowClass);

			if (setting.shown) {
				pane.hide();
				shadow.hide();
			}
			this.shown = false;
		}, //end	
		
		//单击文档和右击文档取消面板
		
		cancel : function() {
			var contextMenu = this,
				setting = this.setting;
			
			if (setting.shown === true) {
				//单击文档隐藏contextMenu菜单
				$(document).on('click', null, function(event){	
					contextMenu.hide()
				});	
					
				//右击文档隐藏contextMenu菜单
				$(document).on('contextmenu', null, function(){
					contextMenu.hide()
				});	
			}
		}, //end
	
		//创建contextMenu的HTML结构和初始CSS设置
		//调用show方法显示菜单
		create : function(element, event, obj) {
			var setting = this.setting;
				contextMenu = this, 				
				pane = $('.' + setting.pane),
				shadow = $('.' + setting.shadowClass);		
			//如果contextMenu不存在则构建DOM结构
			if (pane.length > 0) {
				pane.remove();
				shadow.remove();	
			} 			
			//调用构建contextMenu的DOM结构方法			
			var methods = contextMenu.coustructor(element, obj);	
			contextMenu.init(element, methods);					
			//调用contextMenu显示方法
			contextMenu.show(event);
			var submenu = $(setting.submenuClass).parent();
			//绑定子菜单事件	
			contextMenu.submenu(submenu);
			//返回contextMenu对象
			contextMenu.cancel();
			return pane;
		}//end
	}
	//end
	$.fn.gridColumnMenu = function(event, opts) {
		var options = $.datagridColumnContextMenu.extend(opts);
		var obj = buildGridColumnMenuDefinition(opts.grid, opts.column);
		$.datagridColumnContextMenu.create(this, event, obj, options);
	};
	
	function buildGridColumnMenuDefinition(_gridInst, _colCode){	
		var columns = _gridInst.getDataColumns(), colItems=new Array();
		for(var i=0,len=columns.length;i<len;i++){
			colItems.push({
				type: "item",
				name: columns[i].text,
				value: columns[i].name,
				group: "columns",
				checkbox: columns[i].hidden ? "unchecked" : "checked",
				handler: function(column, show){
					showColumn(_gridInst, column, show);
				}
			});
		}
		var showItem = {type:"submenu", name:"显示/隐藏", ico:"ico_columns", arrow:"dropmenu_arrow", subMenuDefine:{items:colItems}};
		
		var groupObj;
		if(_gridInst.isGroupColumn(_colCode)){
			groupObj ={type:"item", name:"取消分组", ico:"ico_group",disable:true, handler:function(){ungroup(_gridInst, _colCode);}};
		}else{
			groupObj ={type:"item", name:"分组", ico:"ico_group",disable:true, handler:function(){group(_gridInst, _colCode);}};
		}
		var sortType = _gridInst.getSortTypeOfColumn(_colCode);
		var sortable = _gridInst.getSortableOfColumn(_colCode);
		var define = {
			items:[
				{type:"item", name:"隐藏当前列", ico:"", handler:function(){showColumn(_gridInst, _colCode, false);}},
				showItem,
				{type:"separate"},
				groupObj,
				{type:"separate"},
				{type:"item", name:"升序", ico:"ico_asc", disable:(!sortable || sortType === "asc"), handler:function(){sort(_gridInst, _colCode);}},
				{type:"item", name:"降序", ico:"ico_desc", disable:(!sortable || sortType === "desc"), handler:function(){sort(_gridInst, _colCode, true);}}
			]
		};
		return define;
	};
/**
 * 表格列的显示/隐藏
 */	
	function showColumn(grid, column, show){
		if(show){
			grid.showColumn(column);
		}else{
			grid.hideColumn(column);
		}
	};
/**
 * 表格列的排序
 */	
	function sort(grid, column, desc){
		grid.sortColumn(column, desc ? "desc":"asc");
	};
/**
 * 表格分组
 */	
	function group(grid, column){
		var fields = grid.getGroupFields();
		fields.push(column);
		//TODO::调后台分组接口
	}
	
/*================================================================*/
})( jQuery );
/*================================================================*/