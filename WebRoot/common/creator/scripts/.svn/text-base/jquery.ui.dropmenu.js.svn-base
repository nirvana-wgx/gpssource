/* ------------------------------------------------------------------
 * 右击菜单控件
 * Name : dropmenu 
 * version : 1.02beta
 * Date : 8th November 2012
 * update : 5th January 2013
 * Written by : Jian.Hou
 * -------------------------------------------------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	//Dropmenu 对象
	var Dropmenu = function(opts) {
		var defaults = {
			//----------------- html constrctor classname -------------------//
			paneClass:			 'dropmenu',//菜单面板
			paneShadowClass:	 'dropmenu_shadow',//面板阴影
			submenuPaneClass:	 'dropmenu_submenu',//子菜单面板
			submenuShadowClass:  'dropmenu_submenu_shadow',//子菜单阴影
			submenuArrowClass:	 'dropmenu_arrow', //子菜单箭头
			separateclass:		 'dropmenu_separate',//分割线
			icoClass:			 'dropmenu_ico',//菜单图标
			itemClass:			 'dropmenu_item',//菜单项
			checkboxClass:		 'dropmenu_checkbox',//菜单checkbox			
			freezeListClass:	 'contextmenu_freeze',//冷冻菜单项class
			btnClass :			 '',//对象坐标模式的相应对象class

			//----------------- options -------------------//
			eventMode :			 true,//使用右击事件或者事件定位置，否则使用元素定位
			offsetX :			 -1,//与事件位置的水平偏移量
			offsetY :			 0,//与事件位置的垂直偏移量	
			shadowRadius :		 5,//阴影半径
			shadowOffsetX :		 5,//与pane位置的水平偏移量
			shadowOffsetY :		 5,//与pane位置的垂直
			itemMarginRight :	 26,//contextMenu菜单内容与面板的右边距离，解决IE、firefox下绝对定位的子内容不能显示完整宽度的bug
			menuMargin :		 10,//菜单边距
			scrollWidth: 		 18,//scrollbar的宽度
			paneWidth :			 'disable'//contextMenu菜单面板宽度,参数为数字类型或'disable'
		};

		var options = $.extend(defaults, {}, opts),			
			body = document.body,
			shown,
			scrollStatuss;

		//使用documentFragement构建DOM
		var appendFragment = function(htmlStr, paneClass, ShadowClass) {
			var fragment = document.createDocumentFragment(),
				pane = document.createElement('div'),
				shadow = document.createElement('div');
			pane.className = paneClass;
			shadow.className = ShadowClass;
			pane.innerHTML = htmlStr;
			fragment.appendChild(pane);
			fragment.appendChild(shadow);
			body.appendChild(fragment.cloneNode(true));
		};	

		//拼接HTML字符串
		var parseItem = function(item, methods) {	
			//无图标默认空字符串
			var ico = item.ico || '',	
				name = item.name || 'undefined',
				checkbox = item.checkbox || false,
				handler = item.handler,
				value = item.value,				
				freeze = item.disable,
				freezeDiv = null;
			
			if (handler) {
				value ? methods[value] = handler : methods[name] = handler;
			}

			value = value ? 'field="' + value + '"' : '';
			freeze = freeze ? 'class="' + this.options.freezeListClass + '" ' : '';
			freezeDiv = $.isIE8Le() && item.disable ? '<div class="' + 'freeze' + '"></div>' : '';
			if (checkbox) {
				var status = checkbox === 'checked' ? 'checked="checked"' : '';
				return	'<li '
						+ value
						+ freeze
						+ '><a class="'
						+ options.itemClass
						+ '" href="javascript:void(0)"><span class="'
						+ options.checkboxClass
						+ '"><input type="checkbox" ' 
						+ status
						+ '/></span>'
						+ name 
						+ '</a>'
						+ freezeDiv
						+ '</li>';			
			} else {	
				return  '<li '
						+ value
						+ freeze
						+ '><a class="'
						+ options.itemClass
						+ '" href="javascript:void(0)"><span class="'
						+ options.icoClass
						+ ' '
						+ ico 
						+ '"></span>'
						+ name
						+ '</a>'
						+ freezeDiv
						+ '</li>';	
			}		
		};

		//拼装分隔符
		var parseSeparate = function() {
			return '<li class="' + options.separateclass + '"></li>';
		};

		//拼接子菜单
		var parseSubmenu = function(item) {
			return '<li><a class="'
					 + options.itemClass
					 + ' '
					 + item.arrow 
					 + '" href="javascript:void(0)">'
					 + '<span class="'
					 + options.icoClass
					 + ' '
					 + item.ico 
					 + '"></span>'
					 + item.name 
					 + '</a><div class="'
					 + options.submenuPaneClass
					 + '"><ul>';				
		};

		//解析对象的结构
		var parseObj = function(html, menu, methods) {
			for (var i = 0; i < menu.length; i++) {
				var item = menu[i];		
				switch (item.type) {
					case 'separate' :
						html +=	parseSeparate();
						break;
					case 'item' : 
						html += parseItem(item, methods);	
						break;
					case 'submenu' :  
						var submenu = item.subMenuDefine;
						html +=	parseSubmenu(item);	
						//递归解析对象的方法
						html = parseObj(html, submenu.items, methods);
						html += '</ul></div></li>'
						break;
				}					
			}	
			//返回HTML字符串
			return html;
		};			

		//活动菜单style属性
		var getMenuStyle = function() {
			var menu = $('.' + options.paneClass);
			return {width: menu.outerWidth(), off: menu.offset(), pos: menu.position()};
		};

		//获取contextMenu显示的位置
		//鼠标相对文档的位置加设设置的偏移量
		//返回这个对象
		var getPosition = function(event) {			
			var x = 0,
				y = 0;
			body.width = $(body).width();
			//判断是否事件定位置还是使用元素定位
			if (options.eventMode) {
				x = event.pageX + options.offsetX,
				y = event.pageY + options.offsetY;
				//判断菜单距离容器右边距离是否小于菜单宽度
				var menuStyle = getMenuStyle(),
					result = body.width - x;
				if (result < menuStyle.width) {
					x = x - menuStyle.width;
				}
			} else {
				//可包含
				var btn = $(event.target);	
				//如果按钮应该是父对象，则找寻它的父对象		
				if (btn.hasClass(options.btnClass)) {
					btn = $(event.target).parent();
				}				
				var height = btn.outerHeight();
				//当对文档偏移量
				x = btn.offset().left + options.offsetX;
				y = btn.offset().top + height + options.offsetY;						
			}
			return { x: x, y: y };
		};		

		//隐藏contextMenu，设置shown值为false
		var hide = function() {
			var pane = $('.' + options.paneClass),
				shadow = $('.' + options.paneShadowClass);
			if (shown) {
				pane.remove();
				shadow.remove();
			}
			shown = false;
		}; //end	
		
		//返回公共方法
		return {
			//动态构建HTML结构
			constructer: function(obj) {	
				//获取事件的body对象				
				var methods = {},
					menu = obj.items,
					html = '';								
				//把遍历封装好的HTML代码使用DocumentFragment插入DOM
				html = '<ul>' + parseObj(html, menu, methods) + '</ul>';
				appendFragment(html, options.paneClass, options.paneShadowClass);
				return methods;
			},	
			//子菜单展开方法
			submenu: function($elem) {
				var submenu = $elem.children('.' + options.submenuPaneClass),	
					ul = submenu.children('ul'),
					menuStyle = getMenuStyle(),
					ulH = ul.height(),
					shadow;

				body.height = $(body).height();
				submenu.hide();
				shadow = $('<div class="' + options.submenuShadowClass + '"></div>');
				$elem.append(shadow);
				shadow = $('.' + options.submenuShadowClass);
				shadow.hide();	
				//鼠标进入显示子菜单
				$elem.on('mouseenter', function(event) {
					event.stopPropagation();	
					var left = $elem.width(),
						scrollW = 0;
					//子菜单的初始位置	
					submenu.show().css({top: 0, left: left + 'px'});
					//判断子菜单x坐标和y坐标对height和坐标的影响
					var submenuHeight = submenu.outerHeight(),
						submenuOffset = submenu.offset(),
						//高度的差值子菜单高度 + 子菜单文档位置 - 菜单文档位置 + 菜单相对容器位置 - 容器高度
						resultH = submenuHeight + menuStyle.pos.top + submenuOffset.top - menuStyle.off.top - body.height;
					if (resultH > 0) {
						var height = submenuHeight - resultH - options.menuMargin;
						submenu.css('height', height + 'px');
						//滚动条存在时设置为true，添加滚动条宽度
						scrollStatus = true;
						scrollW = options.scrollWidth;	
						//修补UL高度问题导致当地分隔线不全			
						ul.css('height', ulH + 'px');
					//修复IE7的bug	
					} else if ($.isIE7Le() && !scrollStatus) {
						submenu.css('overflow', 'visible');
					}
					//IE8、IE9滚动条影响宽度
					var	submenuWidth = submenu.outerWidth(),
						resultW = submenuWidth + menuStyle.pos.left + submenuOffset.left - menuStyle.off.left - body.width;
					//修复IE7的bug	
					if ($.isIE7Le() && scrollW !== 0) {
						submenu.css('width', submenuWidth + scrollW + options.itemMarginRight + 'px');
						//IE7重新计算菜单宽度
						submenuWidth = submenu.outerWidth();
					}
					//子菜单宽度不能显示全时，向左移动
					if (resultW > 0){
						left = -submenuWidth - 3;
						submenu.css('left', left + 'px');
					}				
					shadow.show().css({
						width :		submenu.outerWidth() - 5 + 'px',
						height :	submenu.outerHeight() - 5 + 'px',
						left :		left + options.shadowOffsetX + 'px',
						top :		options.shadowOffsetY + 'px',
						zIndex :	1
					});	
				});
				//鼠标移开隐藏子菜单
				$elem.on('mouseleave', function(event) {
					setTimeout(function() {
						submenu.fadeOut(100);
						shadow.fadeOut(100);
					}, 800);
				});
			},	

			//显示，获取contextMenu的鼠标位置，设置contextMenu的显示的位置
			//设置文档单击和contextMenu事件时隐藏contextMenu
			show: function(event) {
				//调用获取位置方法得到pos对象
				var pane = $('.' + options.paneClass),
					shadow = $('.' + options.paneShadowClass),
					pos = getPosition(event),
					width = pane.outerWidth() - options.shadowRadius,
					height = pane.outerHeight() - options.shadowRadius;
			
				//panewidth存在时，设置宽度
				if (typeof options.paneWidth === 'number') {
					pane.css('width', options.paneWidth + 'px');
				}
				//设置contextMenu pane的位置和z-index的层顺序
				pane.css({ 				
					left :		pos.x + 'px',
					top :		pos.y + 'px',
					zIndex :	9999
				});
				//设置pane阴影层的宽度、高度、位置和z-index的层顺序
				shadow.css ({
					width :		width + 'px',
					height :	height + 'px',
					left :		pos.x + options.shadowOffsetX + 'px',
					top :		pos.y + options.shadowOffsetY + 'px',
					zIndex :	9998
				});

				//当contextMenu display：none时，显示pane和shadow
				pane.show();
				shadow.show();
				//设置显示现在的状态
				shown = true;	
			},	
			getItem: function(event){
				return event.currentTarget;
			},
			clicked: function(event, eventObj, methods) {
				//扩大checkbox的范围，使checkbox更容易选中
				var span = eventObj.find('.' + options.checkboxClass),
					checkbox = eventObj.find(':checkbox'),
					value = eventObj.attr('field'),	
					params,
					func,					
					status;
				event.stopPropagation();
				//判断父容器
				//if (!eventObj.parentsUntil('.' + options.paneClass).length > 0) {return;}
				//冷冻item处理
				if (eventObj.hasClass(options.freezeListClass)) {
					//hide();
					return false;
				}	
				if (methods) {	
					//获得方法				
					if (methods[eventObj.attr("field")]){
						func = methods[eventObj.attr("field")];
					} else if (methods[eventObj.text()]) {
						func = methods[eventObj.text()];
					}						
					if (value && checkbox.length > 0) {
						status = checkbox.prop('checked');
						if (!$(event.target).is(":checkbox")) {
							status = !status;
						}
						params = 'value, status';
					}
					/*
					try {
						//获取func的实参
						params = /function\s*\(([a-z|A-Z|0-9|\s|,]+)\)/.exec(funcStr)[1];
					} catch(e) {
						params = '';
					}
					*/					
					//调用event方法		
					//eval('func\(' + params + '\)');				
					checkbox = checkbox.add(span);
					if (!$(event.target).is(checkbox)) {
						hide();
					}		
				} else {
					return;
				}	
				return this.getItem(event);											
			},
			//初始化，给容器初始化宽度
			//给每个菜单项绑定事件
			eventBind: function(element, methods) {
				var pane = $('.' + options.paneClass),
					self = this;
				//菜单项绑定事件
				pane.delegate('li', 'click', function(event) {				
					self.clicked(event, $(this), methods);
					element.trigger('dropmenuClicked', [{'menuItem': self.getItem(event)}]);
				});
				//取消菜单的右击事件
				$(document).on('click', null, hide);	
				$(document).on('contextmenu', null, hide);	
			},
			init: function(obj, event, element) {				
				var pane = $('.' + options.paneClass),
					shadow = $('.' + options.paneShadowClass),
					submenu,
					methods;
				//如果contextMenu不存在则构建DOM结构
				if (pane.length > 0) {
					pane.remove();
					shadow.remove();	
				} 	
				methods = this.constructer(obj);
				this.show(event);
				submenu = $('.' + options.submenuArrowClass).parent();
				this.submenu(submenu);
				this.eventBind(element, methods);
			}
		};
		
	};
	/*
	$.fn.dropmenu = function(opts) {
		return function(o) {
			var F = function() {};
			F.prototype = o;
			return new F();
		}($.dropmenu(opts));
	};
	*/

	$.fn.dropmenu = function(opts) {
		return new Dropmenu(opts); 
	};	

/*================================================================*/
})( jQuery );
/*================================================================*/