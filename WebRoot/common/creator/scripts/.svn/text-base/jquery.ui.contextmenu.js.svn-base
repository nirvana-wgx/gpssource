/* ------------------------------------------------------------------
 * 表格控件
 * Name : contextMenu 
 * version : 1.0beta
 * Date : 23th July 2012
 * update : 27th July 2012
 * Written by : Jian.Hou
 * ------------------------------------------------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	//$.contextMenu 对象
	$.contextMenu = {

		//设置选项
		setting : {
			pane :				 'contextmenu',//contextMenu菜单容器
			shadowClass :		 'contextmenu_shadow',//contextmenu 阴影样式
			offsetX :			 0, //与事件位置的水平偏移量
			offsetY :			 0, //与事件位置的垂直偏移量
			shadowOffsetX :		 3, //与pane位置的水平偏移量
			shadowOffsetY :		 3, //与pane位置的垂直
			icoClass :			 'ico_ok', //状态图标classname
			hoverClass :		 'contextmenu_item_hover', //状态图标classname
			divClass :			 'table_datagrid', //Datagrid 插件动态添加的'div'的classname
			datagridClass :      'datagrid_pane', //数据表pane的classname
			shown :				 false, //判断是否contextMenu已经显示，'true'表示显示、'false'表示为显示
			itemMarginRight :	 10, //contextMenu菜单内容与面板的右边距离
			contextMenuHTML :	 null //传人的HTML菜单结构
		},
		
		//通过递归方法找到父级指定对象
		parents : function (eObj, classname) {	
			if(eObj.parent(classname).length > 0) {
				return eObj.parent(classname);
			} else {
				return this.parents(eObj.parent(), classname);
			}
		}, //end			

		//动态构建HTML结构
		coustructor : function(element, headerElems) {	
				//获取事件的body对象
			    var body = $(element).parents('body'),
					contextMenu = this,
					setting = this.setting,
					html = '';

				if (this.contextMenuHTML) {
					return;
				} else {
					//把表格所有th的内容加入到菜单项的文字区
					$.each(headerElems, function() {
						//文本内容不为空时
						if ($(this).text().length > 0) {
							html += '<div class="contextmenu_item"><div class="contextmenu_item_text">' 
									+ $(this).text() 
									+ '</div><div class="contextmenu_item_ico ' 
									+ setting.icoClass 
									+ '"></div></div>';
						}
					});
					//把遍历封装好的HTML代码包装contextMenu容器
					html = '<div class="contextmenu">' + html + '</div>';
					//html所有结构缓存到body节点
					html = $.data(document.body, 'html', html);
					//插入文档的末端
					body.append(html);
					var pane = $('.' + setting.pane);
					html = $('<div class="' + setting.shadowClass + '"></div>');
					html.insertAfter(pane);
				}
		},//end

		//获取contextMenu显示的位置
		//鼠标相对文档的位置加设设置的偏移量
		//返回这个对象
		getPosition : function(event) {
			var setting = this.setting;
			x = event.pageX + setting.offsetX;
			y = event.pageY + setting.offsetY;
			return { x: x, y: y };
		},//end

		//初始化，给容器初始化宽度
		//给每个菜单项绑定事件
		init : function(element, headerElems) {
			//contextMenu容器
			var contextMenu = this,
				setting = this.setting,
				pane = $('.' + setting.pane),
				//contextMenu菜单项
				contextMenuItem = pane.children(),
				i,
				width,
				children,
				sibling;

			//筛选获取item中的最大内容宽度
			for (i = 0; i < contextMenuItem.length; i++) {
				//绑定单击事件
				$(contextMenuItem[i]).on('click', function() {
					//调用contextMenu的event方法
					contextMenu.event(element, this, headerElems);
					//调用contextMenu的hide方法，隐藏菜单和菜单阴影
					contextMenu.hide();
				});
				//绑定hover事件
				$(contextMenuItem[i]).on('hover', function() {
					$(this).toggleClass(setting.hoverClass);
				});
				//获取单击事件对象的第一个子元素
				children = $(contextMenuItem[i]).children().first();
				//获取上一个兄弟元素对象
				sibling = $(contextMenuItem[i - 1]).children().first();
				//初始化width
				if (i === 0) {
					//宽度等于最右边的元素宽度+位置坐标(相当于偏移量)
					width = children.width() + children.position().left ;	
				//选择所有item中的最大内容宽度
				} else if (sibling.length > 0 && children.width() > sibling.width()) { 					
					width = children.width() + children.position().left;				
				}				
			}

			//给contextMenu pane设置宽度，无宽度无法正常显示
			pane.css('width', width + setting.itemMarginRight + 'px');
			
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
				width :		pane.outerWidth() + 'px',
				height :	pane.outerHeight() + 'px',
				left :		pos.x + setting.shadowOffsetX + 'px',
				top :		pos.y + setting.shadowOffsetY + 'px',
				zIndex :	9998
			});

			//当contextMenu display：none时，显示pane和shadow
			pane.show();
			shadow.show();
			//设置显示现在的状态
			setting.shown = true;	
			//单击文档隐藏contextMenu菜单
			$(document).one('click',null,function(){
				contextMenu.hide()
			});
			//右击文档隐藏contextMenu菜单
			$(document).one('contextmenu',null,function(){
				contextMenu.hide()
			});			
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

		//
		event : function(eObj, element, headerElems) {
			//contextMenu点击对象
			element = $(element);
			//获取element对象的文本内容
			var text = element.text(),
				setting = this.setting,
				dataCompound,
				field;
			
			//获取所有表头的元素的文本内容
			//比较事件对象和表头元素的文本内容，获得对应的'field'属性
			$.each(headerElems, function() {
				var content = $(this).children('div' + '.' + setting.divClass).text();
				if (content === text) {
					field = $(this).attr('field');
					dataCompound = $(this).attr('data-compound');
				}
			});
			//获取对应的全表对象
			var datagrid = this.parents(eObj, '.' + setting.datagridClass),
				//查找对应'field'属性的列
				column = $.data( document.body, 'column', datagrid.find('\'[field =' + field + ']\'') ),
				//复合表头项
				compoundHeader = datagrid.find('\'[data-compound =' + dataCompound + ']\''),
				//contextMenu菜单图标对象
				ico = element.children().last(),
				//循环变量
				i,
				//计数变量
				count = 0;		
	
			//显示隐藏列，增加'.contextMenu_hidden'区别当前菜单项的状态
			if ( element.hasClass('contextMenu_hidden') ) { 
				column.show(); 
				element.removeClass('contextMenu_hidden');
			} else { 				
				//防止全部隐藏，当包含显示图标的对象数量小于等于时返回
				if (element.parent().find('.' + setting.icoClass).length <= 1) {
					return false;
				}
				//如果菜单项单击时，有data-compound属性
				if (compoundHeader.length > 0) {
					//计数复合表头项被隐藏的元素
					for ( i = 0; i < compoundHeader.length; i++ ) {
						if ( $(compoundHeader[i]).css('display') === 'none' ) {
							count++;
						}
					}		
					//调试
					//console.log(count);//debug	
					//只是保留一个未合并单元格
					if (count >= compoundHeader.length - 2) {
						return false;
					}
				}	
				column.hide(); 	
				element.addClass('contextMenu_hidden');	
			}
			//切换图标隐藏显示图标
			ico.toggleClass(setting.icoClass);
		}, //end


		//创建contextMenu的HTML结构和初始CSS设置
		//调用show方法显示菜单
		create : function(element, headerElems, event, opt) {
			var options = $.extend(opt, {}, this.setting),
				contextMenu = this, 
				pane = $('.' + options.pane);			
			
			//如果contextMenu不存在则构建DOM结构
			if (!pane.length > 0) {
				//调用构建contextMenu的DOM结构方法			
				contextMenu.coustructor(element, headerElems);
				contextMenu.init(element,headerElems);
			}					
			//调用contextMenu显示方法
			contextMenu.show(event);
			//返回contextMenu对象
			return pane;
		}//end

	};
	//end

	//$.fn.contextMenu jQuery对象方法
	$.fn.contextMenu = function(elements, event, opt) {
		//所有操作缓存到body节点上
		return $.data( document.body, 'contextMenu', $.contextMenu.create(this, elements, event, opt) );
	};
	//end
	
/*================================================================*/
/*================================================================*/
})( jQuery );
/*================================================================*/