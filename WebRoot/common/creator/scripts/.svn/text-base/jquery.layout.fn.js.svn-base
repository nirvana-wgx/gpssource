/* --------------------------
 * layout封装
 * Name : layoutControl
 * version : 0.1beta
 * Date : 19th June 2012
 * Written by : Jian.Hou
 * --------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
$.fn.layoutControl = function(opt) {

	//默认参数复位
	var defaults = {
		outerLayout:			false, //外层布局
		centerLayout:			false, //中间布局
		innerLayout:			false, //内层布局
		onresize:				'resizeAll', //触发resize
		spacing_closed:			0,	//关闭宽度
		spacing_open:			0,	//打开宽度
		north:					null, //布局区域north
		south:					null, //布局区域south
		west:					null, //布局区域west
		east:					null, //布局区域east
		center:					null, //布局区域center
	    togglerAlign_closed:	null, //开关位置
		slide:					false, //触发滑动控件
		closable:				false //pane can open & close
	};

	var options = $.extend(defaults, opt || {});

	//获取layout调用参数对象
	var getPane = function(opt) {

		var pane = {},
			region,
			layout;
		
		//遍历参数属性
		for (var property in opt) {
			//得到布局layout字符串
			if (opt[property] === true) layout = property;
			//获取布局区域的属性
			if (typeof opt[property] === 'object' && opt[property] != null) {
				for (var pry in opt[property]) {					
					if (pry === 'paneSelector') {
						region = property;
						var paneSelector = region + '__' + pry;				
						pane[paneSelector] = opt[property][pry];
					}
					if (opt[property][pry] != null && pry !== 'paneSelector') {
						var config = region + '__' + pry;
						pane[config] = opt[property][pry];
					}
				};	
			//设置属性
			} else if (typeof opt[property] === 'number') {				
				pane[property] = opt[property];
			}
		};
		if (options.onresize != null) 
			pane[region + '__onresize'] = layout + '.' + options.onresize;
		
		if (options.togglerAlign_closed != null) 
			pane.togglerAlign_closed = options.togglerAlign_closed;
		pane.closable = options.closable;

		return pane;
	};
	
	//得到调用参数对象
	var pane = getPane(options);
	var layout = this.layout(pane);

	if (options.slide === true) {	
		$('.collapse_left').click( function() {
			layout.close('west');
			$('.tabs_group').trigger('detection');	
			$('.tabs_group').horSliding();
		});

		$('.ui-layout-toggler-closed').click( function() {
			$('.tabs_group').trigger('detection');	
			$('.tabs_group').horSliding();
		});		
	}

	return this;
};
/*================================================================*/
	//方法调用

/*================================================================*/
})( jQuery );
/*================================================================*/