/* ------------------------------------------------------------------
 * Name: scrollbar
 * description：模拟scrollbar
 * version: 
 * Date: 18th December 2012
 * update: 28th December 2012
 * Written by: Jian.Hou
 * ------------------------------------------------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	var scrollbar = function(opts) {
		var defaults = {
			v_scrollbarClass: 'vert_scrollbar', //
			v_scrollbarDraggerClass: 'vert_scrollbar_dragger', //
			v_scrollbarDragClass: 'vert_scrollbar_drag', //
			v_scrollbarDragRailClass: 'vert_scrollbar_drag_rail', //
			h_ScrollbarClass: 'hor_scrollbar', //
			h_scrollbarDraggerClass: 'hor_scrollbar_dragger', //
			h_scrollbarDragClass: 'hor_scrollbar_drag', //
			h_scrollbarDragRailClass: 'hor_scrollbar_drag_rail', //
			scrollbarUpbtnClass: 'scrollbar_dragger_up', //
			scrollbarDownbtnClass: 'scrollbar_dragger_down', //
			scrollbarLeftbtnClass: 'scrollbar_dragger_left', //
			scrollbarRightbtnClass: 'scrollbar_dragger_right', //
			scrollbarBtnspace: 2,//按钮和滚动条之间的间距
			scrollbarDistance: 28//按钮控制移动距离
		}; 
		//---------------------- method's global variable----------------------//	
		//扩展设置
		var options = $.extend(defaults, {}, opts);
		//---------------------- helper methods----------------------//	 
		var cssScrollType = function(element) {
			return type ? element.innerWidth() : element.innerHeight();
		};		

		var measureScrollbar = function(htmlStr, overflowType) {
			var square = $(htmlStr),
				method,
				val1, 
				val2;

			$('body').append(square);
			val1 = cssScrollType( $('div', square), overflowType);
			square.css(overflowType, 'scroll');
			val2 = cssScrollType( $('div', square), overflowType);
			square.remove();
			return Math.max(val1 - val2, 17);
		};	

		//---------------------- 闭包变量 ----------------------//	 
		var	htmlStrY = '<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="height:100px;"></div></div>',
			htmlStrX = '<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="width:100px;height:100%;"></div></div>',
			scrollbarWidth = measureScrollbar(htmlStrY, 'overflow-y'),
			scrollbarHeight = measureScrollbar(htmlStrX, 'overflow-x'),			
			context = $(this),
			content = context.children(),
			contentW = content.outerWidth(),
			contentH = content.outerHeight(),
			elementW = context.width(),
			elementH = context.height();		

		//---------------------- main methods----------------------//	 
		var scrollbarCategory = function(type) {
			var methods = {};
			methods.unbindMousemove = function() {
	        	$('html').off('mousemove');
	        }; 
	        methods.generator = function() {
				var html = '<div class="'
						 + scrollbarClass
						 + '" style="width:'
						 + scrollbarSize
						 + 'px"><a href="" class="'
						 + dragBackClass
						 + '"><span></span></a><div class="'
						 + draggerClass
						 + '"><div class="'
						 + dragClass
						 + '"></div><div class="'
						 + dragRailClass
						 + '"></div></div><a href="" class="'
						 + dragForwClass
						 + '"><span></span></a></div>';		
				context.before(html);
			};
			methods.setData = function(element) {
				return context.data(type + '_data', element);
			};
			methods.controller = function(element) {
				if (ratio < 1) {
					if (methods.setData(type, element) == null) {
						context.trigger(type +'_generator');
					}
				} else {
					element.hide();
				}				
			};

			var listenerEvent = function() {
				if (type) {
					var updateDragPos = updateDragVertPos,
						scrollPos = 'scrollTop',
						pagePos = 'pageY',
						pos = 'top'
				} else {
					var updateDragPos = updateDragHorPos,
						scrollPos = 'scrollLeft'
						pagePos = 'pageX',
						pos = 'left'
				}
				context.bind(scrollbarType +'_generator', function() {
					generator();
					context.trigger(scrollbarType +'_repaint');
				});
				context.bind(scrollbarType +'_repaint', function() {
					repaint();
				});
				context.on('scroll', function() {
					updateDragPos();
		        });
		        drag.on('mousedown', function(e) {
		        	unbindMousemove();
		        	var offset = e[pagePos] - drag.offset()[pos];
		        	$('html').on('mousemove', function(e) {
		        		context[scrollPos]((e[pagePos] - context.offset()[pos] - offset) / ratio);
		        		return false;
		        	}).mouseup(unbindMousemove);
		        	return false;
		        });
		        dragTop.on('click', function() {
		        	var scrollPos = context[scrollPos]();	  
		        	context[scrollPos](scrollPos - options.scrollbarDistance / ratio);
		        	return false;
		        });
		        dragBottom.on('click', function() {
		        	var scrollPos = context[scrollPos]();	
		        	context[scrollPos](scrollPos + options.scrollbarDistance / ratio);
		        	return false;
		        });		        
			};			

		}; 
	};

	$.fn.scrollbar = function() {
		this.each(function() {
			scrollbar.apply(this, arguments);
		})
	};
/* ================================================================ */
})( jQuery );
/* ================================================================ */


