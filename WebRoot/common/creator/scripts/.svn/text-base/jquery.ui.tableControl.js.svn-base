/****************************************************************/
//Name : tableScrollWidth  表格滚动条宽度自适应方法
//version : 0.1beta
//Date : 22th April 2012
//Written by : Jian.Hou
/*--------------------------------------------------------------*/
//Change log
//Date： 31th May 2012
//增加参数的设置；
//新增滚动条判断
/****************************************************************/
(function($) {
/*--------------------------------------------------------------*/
	
	//获取表头的jquery对象

	$.fn.getHeader = function(classname, elements) {
		var elems = elements || 'div';
		classname = classname.replace(/\.([a-z|_]*)/,"$1");
		var obj = null;
		this.each( function() {			
			if ($(this).prev(elems).hasClass(classname)) {
				obj = $(this).prev(elems);
			} else {
				obj = $(this).parent(elems);			
				if (obj.prev(elems).hasClass(classname)) {
					obj = obj.prev(elems);
				}
			}					
		});
		return obj;
	};
	// end

	//取所有单元格的宽度
	/*
	$.fn.getCellsWidth = function() {	
		var widths = [];
		var cellWd = [];
		this.find('table tr th').each( function(i) {
			widths[i] = $(this).width();
			$(this).css('width', widths[i]);

		});
		
		$('.table_body').find('table tr').first().find('td').each( function(i) {
			var width = widths[i];
			$(this).css('width', width);
			cellWd[i] = $(this).width();
			$(this).css('width', cellWd[i]);
			if (cellWd[i] > width) {
				widths[i] = cellWd[i];	
			}		
		});
		this.find('table tr th').each( function(i) {			
			$(this).css('width', cellWd[i])
		});
	};
	
*/

	//表格滚动条宽度自适应

	$.fn.tableScrollWidth = function(opts) {		
				
		var defaults = {
			header : '.table_header', //表头
			body : '.table_body', //表内容
			scrollWidth : 18, //scroll的宽度设置
			maxHeight : 150 //允许出现滚动条的最大高度
		}; 

		var options = $.extend(defaults, opts || {});	


		return this.each(function(){			
			
			//if($(this).height() < options.maxHeight) return; //根据最大高度判断是有滚动条
			
			
			var width = 0;			
			var cellWidth = []; //宽度存储数组
			var	selfWidth = $(this).find('table').width(); //获取宽度初始值
			var	parentWidth = $(this).width(); //获取宽度初始值
			
			//判断是宽度参照对象
			if (selfWidth > parentWidth) {
				width = selfWidth;
			} else {
				width = parentWidth;
			}
			
			//设置可见表头容器高度
			$(options.header).css('height', function() {
				return $(this).find('table').height();
			});
			
			//模拟操作表头滚动条
			$(this).scroll( function() {
				$(this).getHeader(options.header).find('table').css('left', -$(this).scrollLeft());	
			});

			//给表头、表体填写px值宽度
			$(this).getHeader(options.header).find('table').css('width', width - options.scrollWidth + 'px');			
			$(this).find('table').css('width', width - options.scrollWidth + 'px');

			

			//单元格宽度自适应
			//数据缓存
			var headerCellData = $.data(document.body, 'headerData', $(this).getHeader(options.header).find('table tr th'));
			var bodyCellData =  $.data(document.body, 'headerData', $(this).find('table tr').first().find('td'));
			
			headerCellData.each( function(i) {
				cellWidth[i] = $(this).width();
				$(this).css('width', cellWidth[i])
			});	
			
			bodyCellData.each( function(i) {
				$(this).css('width', cellWidth[i]);				
			});
		});	

	};
	// end

	/**
	// 拖动改变表格列宽
	// @Author: xiaoqing.qiu
	*/
		
	$.fn.resizeTable = function(opts) {
		var defaults = {
			header : '.easylist_table_header',
			body : '.easylist_table_body',
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
		//添加拖拽指针
		$(this).append("<div id='resizeColCursor' "
				+"style='position:absolute;display:none;background-color:grey;maggin-left:5px;maggin-right:5px;width:1px;height:"
				+(header.clientHeight+body.clientHeight)+"px'></div>");
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
		var cursorH = $(header).height()+Math.min($(body).parent().height(),$(body).height());
		$(resizeCursor).css({'display': 'block',
							'height': cursorH+'px',
							'top':'0px',
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
			
	//		$(body).find("td:eq("+columnIndex+")").width(orgW+increaseW);
	//		$(body).find("td:eq("+(columnIndex-1)+")").width(prevColW-increaseW);
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
			
	//		$(body).find("td:eq("+columnIndex+")").width(orgW+increaseW);
	//		$(body).find("td:eq("+(columnIndex+1)+")").width(nextColW-increaseW);
		}
	};
	
/*--------------------------------------------------------------*/
	//方法调用
	$(function() {
		$('.table_body').tableScrollWidth();
		//$('.easylist_result').resizeTable();
	});
/*--------------------------------------------------------------*/

})( jQuery );