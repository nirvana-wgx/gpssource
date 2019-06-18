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
	$.scrollbar = function(element, opts) {
		var defaults = {
			scrollbarClass: 'scrollbar', //
			scrollbarTopbtnClass: 'scrollbar_dragger_top', //
			scrollbarBottombtnClass: 'scrollbar_dragger_bottom', //
			scrollbar_draggerClass: 'scrollbar_dragger', //
			scrollbar_dragClass: 'scrollbar_drag', //
			scrollbar_dragRailClass: 'scrollbar_drag_rail', //
			scrollbar_btnspace: 2,//按钮和滚动条之间的间距
			scrollbar_distance: 28//按钮控制移动距离
		}; 
		//扩展设置
		var options = $.extend(defaults, {}, opts),
			scrollbar = element.data('scrollbar');

		var cssScrollType = function(element, type) {
			return type === 'overflow-y' ? element.innerWidth() : element.innerHeight();
		};	
			
		var measureScrollbar = function(htmlStr, overflowType) {
			var square = $(htmlStr),
				method,
				val1, val2;
			$('body').append(square);
			val1 = cssScrollType( $('div', square), overflowType);
			square.css(overflowType, 'scroll');
			val2 = cssScrollType( $('div', square), overflowType);
			square.remove();
			return Math.max(val1 - val2, 17);
		};	

		if (scrollbar == null) {
			var htmlStrY = '<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="height:100px;"></div></div>',
				htmlStrX = '<div style="width:50px;height:50px;overflow:hidden;position:absolute;top:-200px;left:-200px;"><div style="width:100px;height:100%;"></div></div>',
				scrollbarWidth = measureScrollbar(htmlStrY, 'overflow-y'),
				scrollbarHeight = measureScrollbar(htmlStrX, 'overflow-x');

			var	scrollbar = options.scrollbarClass,
				dragTop	= options.scrollbarTopbtnClass,
				dragBottom	= options.scrollbarBottombtnClass,
				dragger	= options.scrollbar_draggerClass,
				drag = options.scrollbar_dragClass,
				dragRail = options.scrollbar_dragRailClass,
				btnspace = options.scrollbar_btnspace,
				distance = options.scrollbar_distance,
				html = '<div class="'
					 + scrollbar
					 + '" style="width:'
					 + scrollbarWidth
					 + 'px"><a href="" class="'
					 + dragTop
					 + '"><span></span></a><div class="'
					 + dragger
					 + '"><div class="'
					 + drag
					 + '"></div><div class="'
					 + dragRail
					 + '"></div></div><a href="" class="'
					 + dragBottom
					 + '"><span></span></a></div>';

			element.before(html);
			element.append('<div style="clear:both;"></div>');
			element.data('scrollbar', $('.' + scrollbar));

		}
		scrollbar = element.data('scrollbar');
		drag = $('.' + drag);
		dragTop = $('.' + dragTop);
		dragBottom = $('.' + dragBottom);
		var content = element.children(),
			contentH = content.outerHeight(),
			elementH = element.height(),
			ratio = elementH / contentH;

		if (ratio < 1) {
			//滚动条出现的位置，由于原出滚动条的容器属于同一层的所以选择position作为参照坐标
			//设置滚动条的高度
			//设置滚动条的位置	
			var left = element.position().left + element.outerWidth() - scrollbar.outerWidth() - parseInt(element.css('borderRightWidth')),
				top = element.position().top + parseInt(element.css('borderTopWidth'));
			scrollbar.css({
				height: elementH + 'px',
				left: left,
				top: top
			});
 			var dragHeight = Math.max(Math.round(elementH * ratio), dragTop.outerHeight() + dragBottom.outerHeight());
 			drag.css('height', dragHeight + 'px');
 			var updateDragPosTop = function() {
 				//控制滚动条开始和结束的位置
 				var dragPosTop = Math.min(Math.round(element.scrollTop() * ratio) + dragTop.outerHeight() + btnspace ,
 								 elementH - dragHeight - dragBottom.outerHeight() - btnspace);
 				drag.css('top', dragPosTop + 'px');   
 			};
 			updateDragPosTop();		
 			//利用容器的滚动条事件触发位置
	        element.on('scroll', function(event) {
	          updateDragPosTop();
	        });
	        var unbindMousemove = function() {
	        	$('html').off('mousemove');
	        }; 
	        //drag绑定事件mousedown事件
	        //drag拖动element触发scroll事件，调用updateDragPosTop方法
	        drag.on('mousedown', function(e) {
	        	unbindMousemove();
	        	var offset = e.pageY - drag.offset().top;
	        	$('html').on('mousemove', function(e) {
	        		element.scrollTop((e.pageY - element.offset().top - offset) / ratio);
	        		return false;
	        	}).mouseup(unbindMousemove);
	        	return false;
	        });
	        dragTop.on('click', function() {
	        	var scrollTop = element.scrollTop();	  
	        	element.scrollTop(scrollTop - distance);
	        	return false;
	        });

	        dragBottom.on('click', function() {
	        	var scrollTop = element.scrollTop();	
	        	element.scrollTop(scrollTop + distance / ratio);
	        	return false;
	        });
		} else {
			element.off();
			drap.hide();
		}
	
	};

	$.fn.scrollbar = function(opts) {
		this.each(function() {
			$.scrollbar($(this), opts);
		})
	};
/* ================================================================ */
})( jQuery );
/* ================================================================ */