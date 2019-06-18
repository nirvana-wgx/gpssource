/**
 * 表头拖拽效果。
 * author：xiaoqing.qiu
 */
(function($) {
	$.fn.resizeTable = function(opts) {
		var defaults = {
			header : '.easylist_table_header',
			body : '.easylist_table_body',
	//		total : "", //options
			allowResizeColWidth : true,
			allowResizeRowHeight : true,
			colMinWidth : 10,
			rowMinHeight : 15
		}; 
		var options = $.extend(defaults, opts || {});	
		var header = $(this).find(options.header).find("table")[0];
		$(header).css('tableLayout','fixed');
		var headerRow = $(header).find("tr:first");
		var body = $(this).find(options.body).find("table")[0];
		$(body).css('tableLayout','fixed');
		var resizeCursorHeight = header.clientHeight+body.clientHeight;
		var total;
		if(options.total && options.total.length>0){
			total = $(this).find(options.total).find("table")[0];
			$(total).css('tableLayout','fixed');
			resizeCursorHeight += total.clientHeight;
		}
		//添加拖拽指针
		
		$(this).find(options.header).parent().append("<div id='resizeColCursor' "
				+"style='position:absolute;display:none;background-color:grey;maggin-left:5px;maggin-right:5px;width:1px;height:"
				+resizeCursorHeight+"px'></div>");
		if(options.allowResizeColWidth){
			var resizeColOpts = $.extend({target:this}, options);
			var colNum = $(headerRow).find("th").length;
			$(headerRow).find("th").each(function(index, domEle){
				//domEle：表头单元格
				var resizeOpts;
				$(domEle).bind({
					mousemove: function(event){
						event = event || window.event;
						if(event.button>0){//鼠标有按中某个键，firefox除外，在ff里面button=0代表按下左键或没按键。
							return;
						}
						var target = event.target || event.srcElement;
						//鼠标单元格之间左右space个px内响应
						var space = 3;
						//鼠标相对应目标单元格左边框的距离
						var targetClientX = event.clientX - target.getBoundingClientRect().left;
						if(index > 0 && targetClientX <= space && targetClientX >= 0){ //在目标单元格左边框附近
							resizeOpts = $.extend({colIndex: index, isLeftBorder: true},resizeColOpts);
							$(domEle).css('cursor', 'col-resize');
							$(domEle).bind('mousedown',resizeOpts, onMouseDownHandle);
						}else if(index < colNum-1 && targetClientX >= $(domEle).outerWidth()-space
							&& targetClientX <= $(domEle).outerWidth()){ //在目标单元格右边框附近
							resizeOpts = $.extend({colIndex: index, isLeftBorder: false},resizeColOpts);
							$(domEle).css('cursor', 'col-resize');
							$(domEle).bind('mousedown',resizeOpts, onMouseDownHandle);
						}else{
							$(domEle).css('cursor', 'default');
							$(domEle).unbind('mousedown', onMouseDownHandle);
						}
					},
					mouseout: function(event){
						$(domEle).unbind('mousedown', onMouseDownHandle);
					}
				});
			});
		}
	};
	
	onMouseDownHandle = function(e){
		e = e || window.event;
		var opts = e.data;
		//target： 响应鼠标事件的单元格
		var target = e.target || e.srcElement; 
		var container = e.data.target[0]; //包含了header和body的容器
		var header = $(container).find(opts.header).find("table")[0];
		var body = $(container).find(opts.body).find("table")[0];
		var containerX = container.getBoundingClientRect().left;
		var resizeCursor = $(container).find('#resizeColCursor');
		var cursorH = Math.min($(header).parent().height(),$(header).height())+Math.min($(body).parent().height(),$(body).height());
		var total;
		if(opts.total && opts.total.length>0){
			total = $(container).find(opts.total).find("table")[0];
			cursorH +=  Math.min($(total).parent().height(),$(total).height());
		}
		//remove
		var cursorTop = 0;
		if($(container).find(opts.header).css("position")=="absolute"){
			cursorTop = $(container).find(opts.header).offset().top;
		}else{ //表头前面有元素时，cursorTop=前面元素所占的高度总和+header.top
			var index = $(container).parent().children().index($(container));
			var prevSiblings = $(container).parent().children().slice(0, index);
			$(prevSiblings).each(function(){
				cursorTop += $(this).outerHeight();
			});
			cursorTop += parseInt($(container).find(opts.header).css("top"));
		}
		$(resizeCursor).css({'display': 'block',
							'height': cursorH+'px',
							'top':cursorTop+"px",
							'left':e.clientX - containerX+'px'});
		
		var isMouseDown = true;
		$(document).bind({
			mousemove : function(event){
				if(isMouseDown){
					event = event || window.event;
					$(target).css('cursor','col-resize');
					$(target).siblings().css('cursor','col-resize');
					$(resizeCursor).css({'left':event.clientX - containerX+'px'});
				}
			},
			mouseup : function(event){
				if(isMouseDown){
					$(target).css('cursor','default');
					$(target).siblings().css('cursor','default');
					event = event || window.event;
					resizeTableColumnWidth($.extend({
						mouseClientX : event.clientX 
						}, opts));
					$(resizeCursor).css({'display':'none'});
					isMouseDown = false;
				}
			}
		});
	};
	resizeTableColumnWidth = function(opts){
		var $table = $(opts.target);
		var columnIndex = opts.colIndex;
		var mouseX = opts.mouseClientX;
		var colMinWidth = opts.colMinWidth;
		
		var header = $table.find(opts.header).find('table').find('tr:first');
		var target = $(header).find("th:eq("+columnIndex+")")[0];
		
		var body = $table.find(opts.body).find('table').find('tr:first');
		var orgW=$(target).width();
		var prevColW = $(target).prev().width();
		var nextColW = $(target).next().width();
		var increaseW; //目标单元格的宽度的增量 
		if(opts.isLeftBorder){ //拖动左border
			increaseW = target.getBoundingClientRect().left - opts.mouseClientX;
			if(increaseW>0 && colMinWidth + increaseW > prevColW){//向左拖,保证前一列最小宽度
				increaseW = prevColW - colMinWidth;
			}else if(increaseW<0 && colMinWidth - increaseW > orgW){//向右拖，保证当前列最小宽度
				increaseW = colMinWidth - orgW;
			}
			
			$(target).width(orgW+increaseW);
			$(target).prev().width(prevColW-increaseW);
			
			$table.find(opts.body).find('table').find('tr').each(function(){
				$(this).find("td:eq("+columnIndex+")").width(orgW+increaseW);
				$(this).find("td:eq("+(columnIndex-1)+")").width(prevColW-increaseW);
			});
			if(opts.total && opts.total.length>0){
				$table.find(opts.total).find('table').find('tr').each(function(){
					$(this).find("td:eq("+columnIndex+")").width(orgW+increaseW);
				$(this).find("td:eq("+(columnIndex-1)+")").width(prevColW-increaseW);
				});
			}
		}else{ //拖动右border
			increaseW = opts.mouseClientX - target.getBoundingClientRect().right;
			if(increaseW > 0 && colMinWidth + increaseW > nextColW){ //向右拖，保证后一列最小宽度
				increaseW = nextColW - colMinWidth;
			}else if(increaseW < 0 && colMinWidth - increaseW > orgW){ //向左拖，保证当前列最小宽度
				increaseW = colMinWidth - orgW;
			}
			$(target).width(orgW+increaseW);
			$(target).next().width(nextColW-increaseW);
			
			$table.find(opts.body).find('table').find('tr').each(function(){
				$(this).find("td:eq("+columnIndex+")").width(orgW+increaseW);
				$(this).find("td:eq("+(columnIndex+1)+")").width(nextColW-increaseW);
			});
			if(opts.total && opts.total.length>0){
				$table.find(opts.total).find('table').find('tr').each(function(){
					$(this).find("td:eq("+columnIndex+")").width(orgW+increaseW);
					$(this).find("td:eq("+(columnIndex+1)+")").width(nextColW-increaseW);
				});
			}
		}
	};
})( jQuery );