(function($) {
	
	Datagrid = function(element, options) {


		/**----------常量定义-------------**/
		//行类型常量
		var rowTypeConstant = {
				GROUP_HEADER_ROW : "groupHeaderRow",
				GROUP_FOOTER_ROW : "groupFooterRow",
				COMMON_ROW : "commonRow",
				SUBGRID_ROW : "subgridRow",
				PAGE_STATS_ROW : "pageStatsRow",
				GLOBAL_STATS_ROW : "globalStatsRow"
		};
		//列类型常量
		var columnTypeConstant = {
				DATA_COLUMN : "dataColumn",
				GROUP_COLUMN : "groupColumn",
				CHECKBOX_COLUMN : "chkboxColumn",
				ROW_NUMBER_COLUMN : "rowNumberColumn",
				SUBGRID_ICON_COLUMN : "subgridIconColumn"
		};
		
		//统计公式
		var statsConstant = {
				COUNT : "COUNT",
				SUM : "SUM",
				MAX: "MAX",
				MIN: "MIN",
				AVG: "AVG"
		};
		
/**
*===========默认配置项=============
**/	
		var settings = {			
			datagrid_class:				'datagrid_pane',
			bodyPane :					'.datagrid_content',//主数据表容器
			undefinedpx :				'.undefinedpx', //设置未定义类
			pickOnRowClass :			'selector', //选中行classname
			rownumberClass :			'row_number', //行序号classname
			rowcheckboxClass :			'row_checkbox', //行选择checkbox classname
			hoverClass :				'rows_hover', //鼠标hover classname
			trbgcolorClass :			'row_bgcolor',//行背景classname
			thhoverClass : 				'datagrid_th_hover',//表头hover事件的classname
			tddivClass :				'table_datagrid',
			columnIndex :				'field', //自定义列属性
			rownumberIndex :			'tablerowindex', //自定义行号属性
			compoundTh :				'data-compound', //自定义复合表头属性
			rowSelectEvent:				'dblclick', //'dblclick'/ click
			vScrollbarClass :           'datagrid_v-scrollbar',//垂直滚动条classname
			hScrollbarClass :   		'datagrid_h-scrollbar',//水平滚动条classname
			vScrollbarContentClass :  	'datagrid_v-scrollbar_content',//垂直滚动条内容classname
			hScrollbarContentClass :	'datagrid_h-scrollbar_content',//水平滚动条内容classname	
			row_selectable:				true,//点击行触发选中该行的开关
			row_selectedClass : 		"row_selected",
			focusRowClass:				"row_focus",//获得焦点的行的样式类
			mouseoverHighlight:			true,//鼠标在行上高亮该行的开关
			thMouseoverHighlight:		true,//表格表头单元格高亮开关
			interlaceMode:				true,//隔行表色开关
			colResizable:				true,//拖拽改变列宽的开关
			colResizeCursor : 			'e-resize', //拖拽时的指针样式
			rowHeight:					25,
			gridType:					"group", //plain || subgrid || group
			//group table settings
			groupPatternList:			[], //className Array
			groupExpandedClass:			"row_collapse",
			groupCollapsedClass:		"row_expand",
			singleSelection:			false, //选择模式：单选和多选，默认是多选
			sizeAdaptable:				true, //自适应开关
			
			//subgrid setting
			isSubgrid :					false,
			subgridExpandClass :		'row_expand',
			subgridCollapseClass :		'row_collapse',
			querySubgridFieldName:		'',//指定获得子表时需要传递的参数名	
			subgridRowHeight:			100,	
			subgridUrl:					"",
			
			rownumberWidth :			24, //行序号宽度：默认为24px
			checkboxWidth :				20, //checkbox宽度：默认为20px
			colMinWidth:				20,
			tableHeaderRowHeight:		24,
			detailRowHeight:			21,
			tableFooterRowHeight:		24,
			scrollWidth :				17, //scroll的宽度设置：默认为16px
			defaultHeight:				262 //默认表格整体高度
	//		height:						null
		}; 
		var columnConfig = {
			type: columnTypeConstant.DATA_COLUMN,  	
			colSpan: 1,
			rowSpan:1,
			className: "",
	//		title: "", //为前台生成表格预留的属性
			hidden : false
		};
		var fieldConfig = { // columnConfig's children element
			contentType: "label",	
			name: "",
			className: "",
			enable : true,
			sortable: true,	
			dataType: "STRING_EN"			//数据类型，排序需要的一个参数 "NUMBER",'DATE','STRING_EN'
		};
		
			
/**
*=================私有方法========================
**/	
		/**
		* 组合默认配置和用户配置
		**/
		var expendConfig = function(options){
			var temp = $.extend({}, settings, options);
			if(temp.colDefine){
				for(var i in temp.colDefine.fixedColumns){
					temp.colDefine.fixedColumns[i] = $.extend({},columnConfig, temp.colDefine.fixedColumns[i]);
					if(temp.colDefine.fixedColumns[i].children){
						for(var j in temp.colDefine.fixedColumns[i].children){
							temp.colDefine.fixedColumns[i].children[j] = $.extend({},fieldConfig, temp.colDefine.fixedColumns[i].children[j]);
						}
					}
				}
				for(var i in temp.colDefine.columns){
					temp.colDefine.columns[i] = $.extend({},columnConfig, temp.colDefine.columns[i]);
					if(temp.colDefine.columns[i].children){
						for(var j in temp.colDefine.columns[i].children){
							temp.colDefine.columns[i].children[j] = $.extend({},fieldConfig, temp.colDefine.columns[i].children[j]);
						}
					}
				}
			}
			return temp;
		};
		var getStyles = function(element, property) {
			//获得元素属性
			var styles = element.attr('style'),
				value = 0,
				i;

			if (typeof styles !== 'string') {return;}
			//根据":" and ";"排除之间的空格
			styles = styles.split(/(?:\:\s*)|\;\s*/); 
			for ( i = 0; i < styles.length; i++ ) {
				//当获取数组值等于属性并且值不为NaN的属性值
				if (styles[i] === property && isNaN(parseInt(styles[i + 1])) !== true) {
					value = parseInt(styles[i + 1]);
				}		
			}// for end
			return value;
		 }; //end

		 //className参数的转换
		var getClassName = function(className) {
			if (typeof className !== 'string') return;
			//移除className前面的"."
			return className.replace(/\.(a-z_)*/, '$1');
		 }; //end

		//设置行的背景色		
		var setRowBgcolor = function(rows, bgcolorClass) {	
			if(!rows || rows.length==0){
				return;
			}
			var len = rows.length;
			//IE6、IE7不支持tr的样式操作，现有行背景添加样式在tr的单元格上			
			if (isIE7Le) {
				for ( var i = 0; i < len; i++ ) {
					//清除原有背景色
					$(rows[i]).find('td').removeClass(bgcolorClass);
					//奇数改变背景色
					if (i%2 === 1) {
						$(rows[i]).find('td').addClass(bgcolorClass);					
					}
				}// for end		
			  //对其它浏览器使用tr样式
			} else {
				for (var i = 0; i < len; i++ ) {
					//清除原有背景色
					$(rows[i]).removeClass(bgcolorClass);
					//奇数改变背景色
					if (i%2 === 1) {
						$(rows[i]).addClass(bgcolorClass);					
					}
				}// for end					
			}// if end	
			i=null;
		}; //end	
		
		//设置行索引，可选参数:index用来筛选层，默认为全选
		var setRowIndexAttr = function() {
			var activeRows = $BodyCols[1].find("tr");
			$HeaderCols[1].find("tr").each(function(i){
				if($RowIndex==-1){
					$RowIndex = 0;
				}
				$(this).attr($Options.rownumberIndex, $RowIndex);
				$(activeRows[i]).attr($Options.rownumberIndex, $RowIndex);
				$RowIndex++;
			});
		}; //end
		//获取固定column的表格层装入数组，固定列的逻辑结构
		var getHeaderColumn = function() {
			var array = [],
				colgroup = $HeaderPane.children();

			array.push($(colgroup[0]));
			array.push($(colgroup[1]).children());
			if ($(colgroup[2]).length > 0) {
				array.push($(colgroup[2]));
			}
			return array;
		};// end
		
		//获取主数据column的表格层装入数组，主数据列的逻辑结构
		var getBodyColumn = function() {
			var array = [],
				colgroup = $BodyPane.children(),
				bodygroup = $(colgroup[1]).children().children();

			array.push($(colgroup[0]).children());
			array.push($(bodygroup[0]));
			if ($(bodygroup[1]).length > 0) {
				array.push($(bodygroup[1]));
			}
			return array;
		}; //end
		
		var getThGrids = function(colgroup) {							//参数colgroup $HeaderCols or $BodyCols对象
			var $elem,
				rowgrids;
			$elem = colgroup[0];
			var grid = [];
			if(!$($elem).find("th[data-compound]")[0]){
				grid = $elem.children().find('[field]');
			}else{//对于2层结构的表头排序
				var rows = $elem.find("tr");
				var row1Cell = $(rows[0]).find("th");
				for(var i=0; i<row1Cell.length; i++){
					var cell = row1Cell[i];
					if($(cell).attr("field") && cell.rowSpan==rows.length){
						grid.push(cell);
					}else if($(cell).attr("data-compound")){
						var attr = $(cell).attr("data-compound");
						var comps = $(rows[1]).find("th[data-compound='"+attr+"']");
						for(var j=0; j<comps.length;j++){
							grid.push(comps[j]);
						}
					}
				}
			}
			return grid;
		};//end
		
		//数组转换为jQuery对象
		var tojQuery = function(array) {
			var i,
				elem,
				$elems = $(elem);					//建立空的jQuery wrapper set

			for (i = 0; i < array.length; i++) {
				elem = $(array[i]);
				$elems = $elems.add(elem);			//合并每个数组成员对象
			}
			return $elems;							//返回合并后的对象
		};//end
		
		//获得全部有效的表头对象
		var getAllThGrids = function() {
			var grids = getThGrids($HeaderCols);				//固定列表头数组
			grids = $.merge(grids, getThGrids($BodyCols));		//合并主列表头数组
			return tojQuery(grids);								//返回表头jQuery对象
		};//end

		//处理单元保留单元格的宽度
		//获取表头单元格的宽度数组
		var getGridWidth = function(grids) {
			var	options = $Options,
				undefinedpx = getClassName(options.undefinedpx),
				rownumber = {},
				rowcheckbox = {},
				$grid = {},
				array = [],
				count = 0,
				width;

			//分别处理定宽单元格和未定宽单元格，仅限style方式设置的宽度
			for (var i = 0, len=grids.length; i < len; i++ ) {
				$grid = $(grids[i]);
				width = getStyles($grid, 'width');
				if(!width) {
					rownumber = $grid.hasClass(options.rownumberClass);
					rowcheckbox = $grid.hasClass(options.rowcheckboxClass);
					if (rownumber || rowcheckbox) {
						rownumber ? array[i] = options.rownumberWidth : array[i] = options.checkboxWidth;
					} else {
						$grid.addClass(undefinedpx);
						array[i] = $grid.outerWidth();						
						count ++;//增加计数器					
					}
				} else if (width > 0) {
					array[i] = width;		
				}			
			}// for end
			
			// 返回保存的count和width数组的对象			
			return {count: count, width: array};
		}; //end

		//设置单元格宽度
		//根据单元格对象集或单元格数组，按顺序设置宽度或者增加分配的增量宽度
		//每次设置一行的单元格的看宽度
		var setGridWidth = function(rowgrids) {			
			for (var i = 0, len=rowgrids.length; i < len; i++ ) {
				$grid = $(rowgrids[i]);
				if($grid.attr("field")){
					$grid.children('div').css('width', $ColumnPropsMap[$grid.attr("field")]["width"] + 'px');
				}
			}			
		}; //end

		//根据行属性索引，把对应行对象组放入数组；
		//行对象是jQuery对象集合
		var mergeRow = function(headerRows, bodyRows, rownumberIndex) {
			var $headerRow,
				$bodyRow,
				rowindex,
				array = [],
				len = headerRows.length,
				i,j;
				
				if (!len > 0 ) return;
				//根据对应的行索引把固定列的行装入数组
				for ( i = 0; i < len; i++ ) {
					$headerRow = $(headerRows[i]);
					rowindex = $headerRow.attr(rownumberIndex);
					array.push($(bodyRows[i]).add($headerRow));
				}
				return array;			
		};//end
		
		//获取固定列或主列行的包装集
		//colgroup：$HeaderCols or $BodyCols
		var getColsRows = function(colgroup, index) {
			var rows,
				$rows;

			//index为数组类型时，可以返回对应序号的层的行对象 wrapped set
			if (typeof index === 'number') {
				$rows = colgroup[index].children('table').children().children('tr');
			//返回非表头层的行对象 wrapped set
			} else {		
				$rows = $(rows);
				for (var i = 1, len=colgroup.length; i < len; i++) {
					rows = colgroup[i].children('table').children().children('tr');
					$rows = $rows.add(rows);
				}
			}
			return $rows;
		};//end

		//默认获得所有的行，可选参数index对应位置的行包装集
		var getAllRows = function(index) {
			var headerRows = getColsRows($HeaderCols, index),
				bodyRows = getColsRows($BodyCols, index);

			return mergeRow(headerRows, bodyRows, $Options.rownumberIndex);
		};//end
		
		//获得列集合，value是列属性的值，可选参数index
		var getColsColumns = function(colgroup, value, index) {
			var cols,
				$cols,				
				i,
				columnIndex = $Options.columnIndex,						//列属性名
				condition = '\'[' + columnIndex + '='+ value + ']\'';		//合并条件-字符串，这种方法IE是否支持待验证

			if (typeof index === 'number') {
				$cols = colgroup[index].children('table').find(condition);
			} else {
				$cols = $(cols);
				for (var i = 0, len=colgroup.length; i < len; i++) {
					cols = colgroup[i].children('table').find(condition);
					$cols = $cols.add(cols);								//取列组的合集
				}
			}
			return $cols;
		};
		/**
		*设置单元格的属性:宽度(td内部div的宽度)
		**/
		var setTableCellProps = function(cell){
			var fieldName = $(cell).attr("field");
			if(fieldName && $ColumnPropsMap[fieldName]){
				var w = $ColumnPropsMap[fieldName]["width"] || $ColumnPropsMap[fieldName]["unscaledWidth"];
				w = w - parseInt($(cell).css('padding-left')) || 0;
				w = w - parseInt($(cell).css('padding-right')) || 0;
				if($(cell).css('border-right-style') != "none"){
					w = w - parseInt($(cell).css('border-right-width')) || 0;
				}
				if($(cell).css('border-left-style') != "none"){
					w = w - parseInt($(cell).css('border-left-width')) || 0;
				}
				$(cell).children('div').css('width', w+"px");
		//		$ColumnPropsMap[fieldName]["hidden"] ? $(cell).hide() : $(cell).show();
			}
		};
		//处理区域内部所有单元格
		var processGrid = function(colgroup) {
			$.each(colgroup, function(){
				$(this).children("table").children("tbody").children("tr").children("th,td").each(function(){
					setTableCellProps(this);
				});
			});
		};//end
		
		/**
		*计算内容区各列的宽度
		*@divWidth：table的可视宽度，外围div的clientWidth
		**/
		var calculateBodyColumnsWidth = function(divWidth){
			var tableWidth = 0,
				divWidth = divWidth || $($BodyCols[0]).width();
			var thgrids = getThGrids($BodyCols);
			var adapterTHs = [],//自适应表头单元格的数组。表头单元格有：隐藏的，固定宽度的，没设宽度需要自适应的
				visibleTHs = []; //可视表头单元格的数组
			for(var i=0, len=thgrids.length; i< len; i++){
				var fieldName = $(thgrids[i]).attr("field");
				if($ColumnPropsMap[fieldName].hidden===false){
					if($(thgrids[i]).hasClass(getClassName($Options.undefinedpx))){
						adapterTHs.push(thgrids[i]);
					}
					visibleTHs.push(thgrids[i]);
					tableWidth += $ColumnPropsMap[fieldName].width || $ColumnPropsMap[fieldName].unscaledWidth || $Options.colMinWidth;
				}
			}
			if(tableWidth>0){
				if(divWidth > tableWidth){//表格容器（div）的宽度大于表格本身的宽度
					if(adapterTHs.length>0){//有可自适应的列
						var len = adapterTHs.length,
							fieldName,
						    increaseW = parseInt((divWidth - tableWidth)/len);
						for(var i=0; i< len-1; i++){//设置显示列的实际宽度
							fieldName=$(adapterTHs[i]).attr("field");
							$ColumnPropsMap[fieldName]["width"] = ($ColumnPropsMap[fieldName].width || $ColumnPropsMap[fieldName].unscaledWidth)+increaseW;
						}
						//最后一列的宽度
						fieldName=$(adapterTHs[len-1]).attr("field");
						$ColumnPropsMap[fieldName]["width"] = ($ColumnPropsMap[fieldName].width || $ColumnPropsMap[fieldName].unscaledWidth)+divWidth - tableWidth - increaseW*(len-1);
					}else{//所有列都设了固定宽度
						var len = visibleTHs.length,
							increaseW = parseInt((divWidth - tableWidth)/len);
						for(var i=0; i< len-1; i++){
							var fieldName = $(visibleTHs[i]).attr("field");
							$ColumnPropsMap[fieldName]["width"] = ($ColumnPropsMap[fieldName].width || $ColumnPropsMap[fieldName].unscaledWidth)+increaseW;
						}
						//最后一列的宽度
						fieldName=$(visibleTHs[len-1]).attr("field");
						$ColumnPropsMap[fieldName]["width"] = ($ColumnPropsMap[fieldName].width || $ColumnPropsMap[fieldName].unscaledWidth)+divWidth - tableWidth - increaseW*(len-1);
					}
					tableWidth = divWidth;
				}else if(divWidth < tableWidth){
					var i=adapterTHs.length-1;
					while(divWidth < tableWidth && i>=0){
						var fieldName=$(adapterTHs[i]).attr("field");
						var fieldProp = $ColumnPropsMap[fieldName];
						if(fieldProp.width && fieldProp.width > fieldProp.unscaledWidth){
							var w = Math.max(fieldProp.unscaledWidth, (fieldProp.width-(tableWidth-divWidth)));
							tableWidth += (w - fieldProp.width);
							fieldProp.width = w;
						}
						i--;
					}
				}
			}
			return tableWidth;
		};

		//模拟滚动条
		var scroll = function() {			
			var bodyCols = $BodyCols,
				headerCols = $HeaderCols,
				totalBodyStatus,
				scrollX,
				scrollY,
				scrollTop,
				scrollLeft,
				hScrollbar = $Element.find('.' + $Options.hScrollbarClass),
				vScrollbar = $Element.find('.' + $Options.vScrollbarClass);

			//使用隐藏滚动条的滚轮事件
			bodyCols[1].on('scroll', function() {
				scrollLeft = $(this).scrollLeft();
				scrollTop = $(this).scrollTop();
				//firefox 补丁解决慢速问题
				if ($.browser.mozilla) {
					setTimeout(function() {
						vScrollbar.scrollTop(scrollTop);
					}, 150);
				} else {
					vScrollbar.scrollTop(scrollTop);
				}
				//事件关联	
				hScrollbar.scrollLeft(scrollLeft);				
			});

			//垂直滚动事情，移动主数据表表头
			vScrollbar.on('scroll', function() {							
				scrollY = $(this).scrollTop();
				bodyCols[1].scrollTop(scrollY);
				headerCols[1].scrollTop(scrollY);
			});	

			//水平滚动事情，移动主数据表表头	
			hScrollbar.on('scroll', function() {							
				scrollX = $(this).scrollLeft();
				bodyCols[0].scrollLeft(scrollX);
				bodyCols[1].scrollLeft(scrollX);
				if (bodyCols[2]) {
					bodyCols[2].scrollLeft(scrollX);
					totalBodyStatus = bodyCols[2].children().height() > 0 ? false : true;
				} else {
					totalBodyStatus = false;
				}				
				//判断只要主表内容或统计表内容为空，记录滚动条当前的位置
				//否则移出存储的属性
				if (bodyCols[1].children().height() === 0 || totalBodyStatus) {
					hScrollbar.data('scrollX',scrollX);
				} else if(bodyCols[1].children().height() > 0 && !totalBodyStatus) {
					hScrollbar.removeData('scrollX');
				}					
				//hScrollbar.trigger('hScroll', scrollX);						//给滚动条元素触发hScroll事件，传递对应的坐标
			});	
			//修复IE6 scrollLefe移动层的无效的bug		
			var ie6 = $.browser.msie && $.browser.version == 6;				//判断IE浏览器并且版本是IE6
			if (ie6) {														//如果是IE6准备滚动条对应的表头层				
				var headerScroll = bodyCols[0];				
				headerScroll.css({											//设置表头层的css属性，准备移动
					width : '100%', 
					position : 'absolute'
				} );				
				headerScroll.parent().css ({								//设置表头层的父级css属性，显示内容
					width : headerScroll.width() + 'px',
					height : headerScroll.height() + 'px',
					position : 'relative'
				}) ;			
				bodyCols[1].parent().parent().off('scroll');				//解除'scroll'事件
				bodyCols[1].parent().parent().on('scroll', function() {		//重新绑定'scroll'事件，使用绝对定位的偏移量的负值，模拟移动表头层
					headerScroll.css('left', -$(this).scrollLeft());	
				});
			} //end
		};//end
		
		//分组表格行背景样式设置
		var groupTableFillRowPattern = function(){
			
		};
		
		//设置行背景
		var rowBgcolor = function(rows) {			
			if($Options.gridType=="group"){
				groupTableFillRowPattern();
			}else if ($Options.interlaceMode) {
				setRowBgcolor(rows, $Options.trbgcolorClass);
			}			
		};//end
		
		//设置行号
		var setRowNumber = function() {
			var div,
				rowNumber = $HeaderCols[1].find("td[field='"+$NumberField+"']").children('div');
			for (var i = 0, len=rowNumber.length; i < len; i++) {
				div = rowNumber[i];
				$(div).text(i + 1);
			}			
		};//end
		
		/*重设行号和背景色*/
		var resetStyle = function(){
			//重设rownumber
			setRowNumber();
			rowBgcolor(getAllRows(1));
		};
		
		/**在表格数据区的第rowIndex行新增一行，数据：rowDataObj，原第rowIndex行及后续行往后平移一个位置
		* rowDataObj：
		* { "itemid1" : "label1",
		*	"itemid3" : "value3"
		* },
		* rowIndex: ==-1时，默认在表格最后增加一行; 是新增行在表格的自然行序号，随着行的删除上下移动值是会变化的，与行的rowIndex属性不同
		**/
		var addRow = function(rowDataObj, rowIndex) {
			var template = $Options.colDefine;
			var index = 0;
			if($RowIndex>=0){
				index = $RowIndex+1;
			}
			
			//固定列新增一行，设置单元格宽度
			var targetTable = $HeaderCols[1];
			//如果第rowIndex行是subgrid，将新加的行移到rowIndex+1
			if($(targetTable).find("tr:eq("+(rowIndex)+")").attr("rowType")===rowTypeConstant.SUBGRID_ROW){
				rowIndex = rowIndex+1;
			}
			if(targetTable){
				var html = createTrContent(index, template.fixedColumns, rowDataObj);
				if(rowIndex && $(targetTable).find("tr:eq("+rowIndex+")").length>0){
					$(targetTable).find("tr:eq("+rowIndex+")").before(html);
				}else{
					if(!$(targetTable).find("table")[0]){
						$(targetTable).append("<table><tbody></tbody></table>");
					}
					$(targetTable).find("table").append(html);
				}
			}
			
			//数据列新增一行
			targetTable = $BodyCols[1];
			if(targetTable){
				var html = createTrContent(index, template.columns, rowDataObj);
				if(rowIndex && $(targetTable).find("tr:eq("+rowIndex+")").length>0){//指定行序号新增一行
					$(targetTable).find("tr:eq("+rowIndex+")").before(html);
				}else{
					if(!$(targetTable).find("table")[0]){
						$(targetTable).append("<table><tbody></tbody></table>");
					}
					$(targetTable).find("table").append(html);//在表格末尾新增一行
				}
			}
			/**对于html类型的列，无法动态赋值，需要重新反序列化，更新数据, 会触发单元格控件change事件，必须在表单控件绑定事件之前执行**/
			if(rowDataObj){
				updateRowData(index, rowDataObj);
			}
			$RowIndex = index;
			//绑定事件 index行 
			var fixedRow = $HeaderCols[1].find("tr["+$Options.rownumberIndex+"='"+index+"']");
			var normalRow = $BodyCols[1].find("tr["+$Options.rownumberIndex+"='"+index+"']");
			bindRowEvent(fixedRow);
			bindRowEvent(normalRow);
			var chkbox = fixedRow.find("td[field='"+$ChkField+"']").find(":checkbox");
			$(chkbox).bind('click', function(event){
				var event = event || window.event;
				stopPropagation(event);
				var target = event.target || event.srcElement;
				var tr = $(target).closest("tr");
				var selected = $(chkbox).attr("checked")==="checked";
				selectRow($(tr).attr($Options.rownumberIndex), selected);
				focusRow($(tr).attr($Options.rownumberIndex));
			});
			formBindEvent(fixedRow.find("input,select").not(chkbox));
			formBindEvent(normalRow.find("input,select").not(chkbox));
			
			$Element.trigger("addRowEvent", [{rowIndex: $RowIndex}]);
			
		};
		/**
		* 表单控件绑定事件
		**/
		var formBindEvent = function(form){
			$(form).each(function(){
				if($(this).is("input")){
					$(this).bind("keyup", function(event){
						var event = event || window.event;
						var target = event.target || event.srcElement;
						var rowIndex = $(target).closest("tr").attr($Options.rownumberIndex);
						try{
							$ColumnPropsMap[$(target).closest("td").attr("field")]["define"]["children"][0].onKeyup(target);
						}catch(e){
						}
					});
				}
				//特殊控件的事件绑定：时间控件
				if($(this).hasClass("Wdate")){
					$(this).bind("focus", function(){
						$(this).trigger("change");
					});
				}
				$(this).bind({
					"click": function(event){
							var event = event || window.event;
							var target = event.target || event.srcElement;
							var tr = $(target).closest("tr");
							cancelBubble(event);
							focusRow($(tr).attr($Options.rownumberIndex));
							try{
								$ColumnPropsMap[$(target).closest("td").attr("field")]["define"]["children"][0].onClick(target);
							}catch(e){
							}
						},
					"dblclick": function(event){
							var event = event || window.event;
							var target = event.target || event.srcElement;
							try{
								$ColumnPropsMap[$(target).closest("td").attr("field")]["define"]["children"][0].onDblClick(target);
							}catch(e){
							}
						},
					"change": function(event){
							var event = event || window.event;
							var target = event.target || event.srcElement;
							var rowIndex = $(target).closest("tr").attr($Options.rownumberIndex);
							$UpdatedRowIndex = rowIndex;
							var field = $(target).closest("td").attr("field");
							try{
								$ColumnPropsMap[field]["define"]["children"][0].onChange(target);
							}catch(e){
							}
							if(!$AddedRows[rowIndex]){//该行不是新增行
								var obj = serializeTableCell($(target).closest("td"));
								if($UpdatedRows[rowIndex]){
									$.extend($UpdatedRows[rowIndex], obj);
								}else{
									$UpdatedRows[rowIndex] = obj;
								}
							}
							if($ColumnPropsMap[field]["define"]["children"][0]["pageStatType"]){
								var statsValue = statsColumn(field);
								//datagrid容器触发一个statsEvent
								$Element.trigger("statsEvent", [{
																	fieldName: field,
																	statType: $ColumnPropsMap[field]["define"]["children"][0]["pageStatType"],
																	value: statsValue
																}]);
							}
						}
				});
			});
		};
		
		//统计列
		var statsColumn = function(fieldName){
			//收集值
			var trArray, result=[], statsTd;
			if($ColumnPropsMap[fieldName]["isFixed"]){
				//该列在固定区
				trArray = $HeaderCols[1].find("tbody").children("tr");
				statsTd = $HeaderCols[2].find("table").find("td[field='"+fieldName+"']");
			}else{
				trArray = $BodyCols[1].find("tbody").children("tr");
				statsTd = $BodyCols[2].find("table").find("td[field='"+fieldName+"']");
			}
			var index = $(trArray[0]).find("td[field='"+fieldName+"']").index();
			for(var i=0,len=trArray.length; i<len; i++){
				var obj = serializeTableCell($(trArray[i]).children().eq(index));
				if(obj[fieldName]){
					result.push(obj[fieldName]);
				}
			}
			
			//计算并给统计单元格赋值
			var statsResult;
			switch($ColumnPropsMap[fieldName]["define"]["children"][0]["pageStatType"]){
				case statsConstant.SUM:
					statsResult=0;
					for(var i=0,len=result.length;i<len;i++){
						statsResult += parseFloat(result[i]);
					}
					break;
				case statsConstant.COUNT:
					statsResult = result.length;
					break;
				case statsConstant.MAX:
					statsResult = parseFloat(result[0]);
					for(var i=1,len=result.length;i<len;i++){
						statsResult = Math.max(parseFloat(result[i]), statsResult);
					}
					break;
				case statsConstant.MIN:
					statsResult = parseFloat(result[0]);
					for(var i=1,len=result.length;i<len;i++){
						statsResult = Math.min(parseFloat(result[i]), statsResult);
					}
					break;
				case statsConstant.AVG:
					statsResult=0;
					for(var i=0,len=result.length;i<len;i++){
						statsResult += parseFloat(result[i]);
					}
					statsResult = statsResult/len;
					break;
			}
			if(statsResult){
				$(statsTd).find("span[name='"+fieldName+"_pgstas']").html(statsResult);
			}
			return statsResult;
		};
		/*生成表格行的html*/
		var createTrContent = function(index, columnsDef, rowDataObj){
			var html = "<tr "+$Options.rownumberIndex+"='"+index+"' >";
			for(var col=0, len=columnsDef.length; col<len;col++){
				var tempObj = columnsDef[col];
				var cls = (tempObj.className && tempObj.className.length>0) ? "class='"+tempObj.className+"'" : "";
				var divCls = $Options.tddivClass ? "class='" +$Options.tddivClass+"'" : "";
				var td = "";
				var fieldProp = $ColumnPropsMap[tempObj.field];
				var w = fieldProp["width"] || fieldProp["unscaledWidth"];
				w = isNaN(w) ? 0 : w - (fieldProp["borderWidth"] || 0) - (fieldProp["paddingWidth"] || 0); 
				var displayStyle = fieldProp["hidden"] ? "display:none;" : "";
				switch(tempObj.type){
					case columnTypeConstant.ROW_NUMBER_COLUMN:
						td = "<td "+cls+" field='"+tempObj.field
							+"' style='"+displayStyle+"'><div "+divCls
							+" style='width:"+w+"px;'></div></td>";
						break;
					case columnTypeConstant.CHECKBOX_COLUMN:
						td = "<td "+cls+" field='"+tempObj.field
							+"' style='"+displayStyle+"'><div "+divCls+" style='width:"
							+w+"px;'><input type='checkbox'></div></td>";
						break;
					case columnTypeConstant.DATA_COLUMN:
						var hAlign = "";
						if(tempObj.horizontalAlign && tempObj.horizontalAlign!=""){
							hAlign = "text-align:"+tempObj.horizontalAlign;
						}
						td = "<td "+cls+" field='"+tempObj.field
							+"' style='"+displayStyle+"'><div "+divCls+" style='width:"
							+w+"px;"+hAlign+"'>";
						td += createTdContent(tempObj, rowDataObj);
						td += "</div></td>";
						break;
				}
				html += td;
			}
			html += "</tr>";
			return html;
		};
		/**
		* 根据表格模板生成单元格内容控件的html。
		* template：列的模板
		* value : 单元格的值
		**/
		var createTdContent = function(columnTemplate, rowData){
			var str = "";
			for(var i=0, len= columnTemplate.children.length; i < len; i++){
				var field = columnTemplate.children[i];
				var cls = (field.className && field.className.length>0) ? "class='"+field.className+"'" : "";
				var style = (field.style && field.style.length>0) ? "style='"+field.style+"'" : "";
				var value = ((rowData && rowData[field.name]) ? rowData[field.name] : field.defaultValue) || "";
				var disabled = field.enable===false ? "disabled" : "";
				var validateProp = "";
				if(field.validateInfo){
					for(var prop in field.validateInfo){
						//增加判断，当属性值不为""的时候，增加节点属性。 by Leon 2012年10月16日 09:54:25
						if($.trim(field.validateInfo[prop]) != ""){
							validateProp += prop+"='"+field.validateInfo[prop]+"' ";
						}
					}
				} 
				switch(field.contentType){
					case "select":
						str += "<select name='"+field.name+"' "+disabled+" "+cls+" "+style+" "+validateProp+">";
						if(field.options && field.options.length>0){
							for(var i=0; i < field.options.length; i++){
								if(field.options[i].value === value){
									str += "<option value='"+field.options[i].value+"' selected>"+field.options[i].text+"</option>"
								}else{
									str += "<option value='"+field.options[i].value+"'>"+field.options[i].text+"</option>";
								}
							}
						}
						str += "</select>";
						break;
					case "label":
						str += "<span name='"+field.name+"' "+cls+" "+style+">"+value+"</span>";
						break;
					case "isBoolean": //checkbox,是非复选框。选中表示一个值，不选中表示另一个值
						var checked = (value===field.checkedValue) ? "checked" : "";
						str += "<input type='checkbox' "+cls+" "+style+" name='"+field.name+"' isBoolean='true' "+checked+" checkedValue='"+field.checkedValue+"' uncheckedValue='"+field.uncheckedValue+"' "+disabled+"/>";
						break;
					case "date":
						if(!cls || cls==""){
							cls = "class='Wdate'";
						}else if(cls.indexOf("Wdate")==-1){
							cls =cls.substr(0, cls.length-1)+" Wdate'";
						}
						//日期控件的参数字符串化
						var condStr = "";
						for(var i in field.dateCondition){
							condStr += i;
							if(typeof(field.dateCondition[i]) =="string"){
								condStr += ":\""+field.dateCondition[i]+"\",";
							}else{
								condStr += ":"+field.dateCondition[i]+",";
							}
						}
						condStr = condStr.substr(0, condStr.length-1);
						str += "<input type='text' name='"+field.name+"' "+cls+" "+style+" value='"+value+"' "+disabled+" "+validateProp+" onclick='WdatePicker({"+condStr+"})'/>";
						
						break;
					case "html":
						str += field.html;
						break;
					default: //text checkbox radio
						var readonly="";
						if(field.readonly){
								readonly = "readonly='readonly'";
						}
						str += "<input name='"+field.name+"' "+cls+" "+style+" type='"+field.contentType+"' value='"+value+"' "+disabled+" "+validateProp+" "+readonly+"/>";
						break;
				}
			}
			return str;
		};
		/**
		*获取选中行的集合，返回一个{fixed:选中行的固定区部分, data:选中行的右边主数据部分}对象的数组。
		**/
		var getSelectedRows = function(){
			//获取选中行的复选框列的field属性值
			var selectedRows = new Array();
			if($ChkField){
				var fixedRow = $HeaderCols[1].find("tbody").children("tr");
				var dataRow = $BodyCols[1].find("tbody").children("tr");
				for(var i=0; i <fixedRow.length; i++){
					var chk = $(fixedRow[i]).find("td[field='"+$ChkField+"']").find(":checkbox");
					if(chk[0] && $(chk).attr("checked") === "checked"){
						selectedRows.push({fixed: fixedRow[i], data: dataRow[i]});
					}
				}
			}
			return selectedRows;
		};
		
		/*序列化行*/
		var serializeTableRow = function(tr){
			//group header行不序列化
			if($(tr).attr("rowType") && $(tr).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
				return null;
			}
			var result = {};
			$(tr).children().each(function(){
				$.extend(result, serializeTableCell(this));
			});
			return result;
		};
		/*序列化单元格*/
		var serializeTableCell = function(td){
			var target = $(td).find("[name]"); 
			if(!target[0]){
				return null;
			}
			var object = new Object();
			if(target.length===1){//单元格内只有一个需要序列化的元素
				var key = $(target).attr("name");
				var value;
				if($(target).is("span")){//文本
					value = $(target).html();
				}else if($(target).is(":checkbox") && $(target).attr("isBoolean")){//是非选择框
					value = $(target).attr("checked")==="checked" ? $(target).attr("checkedValue") : $(target).attr("uncheckedValue");
				}else{//其他普通的表单控件 text textarea select password hidden
					value = $(target).val();
				}
				if($ColumnPropsMap[$(td).attr("field")]["define"]["children"][0]["formatType"]=="number"){
					value = $.string2Number(value);
				}
				object[key]=value;
			}else{//单元格内有多个需要序列化的元素：序列化的元素必须是普通的能被序列化的html表单控件
				var fields = $(target).serializeArray();
				$.each(fields,function(i,field){
					if($ColumnPropsMap[$(td).attr("field")]["define"]["children"][i]["formatType"]=="number"){
						object[field.name] = $.string2Number(field.value);
					}else{
						object[field.name] = field.value;
					}
					
				});
			}
			return object;
		};
		
		/**
		 * 序列化行中的指定字段
		 */
		var serializeAssignedField = function(tr, fields){
			var result = {};
			for(var i=0,len=fields.length;i<len;i++){
				$.extend(result, serializeTableCell($(tr).find("td[field='"+fields[i]+"']:first").closest("td")));
			}
			return result;
		};
		
		/**设置表格是否支持拖拽改变列宽
		 @tableContainer表头和表数据主体的父容器
		 @resizable: true允许拖拽
		*/
		
		var setBodyColResizable = function(tableContainer, resizable){
			//主数据column数组:table的上一层div
			var bodyCol = $BodyCols;
			var options = $Options;
			if(resizable){//增加拖拽功能
				options = $.extend({tableContainer:  tableContainer}, options);
				if(!$(tableContainer).find(".resizeColCursor") || $(tableContainer).find(".resizeColCursor").length==0){
					//tableContainer新加一个拖拽指示线
					$(tableContainer).append("<div id='resizeColCursor' class='resizeColCursor' "
					+"style='position:absolute;cursor:"+options.colResizeCursor+";display:none;background-color:gray;maggin-left:5px;maggin-right:5px;"
					+"width:1px;'></div>");
				}
				
				//表头单元格添加鼠标事件监听
				var fixedColCount = $Options.colDefine.fixedColumns.length;
				$(bodyCol[0]).find("th[field]").each(function(index, cell){
					//当前单元格在表格中的列序号（从0开始）
					var colIndex = $ColumnPropsMap[$(cell).attr('field')]["colIndex"] - fixedColCount;
					//当前表格总的列数
					var colNum = $Options.colDefine.columns.length;
					$(cell).bind({
						mousemove: function(event){//鼠标在表头单元格上移动，改变鼠标指针样式，单元格监听mousedown事件
							if(isMouseDown){//说明某个表头单元格处于拖拽操作过程中，直接返回
								return;
							}
							//表头单元格只有在isMouseDown==false的情况下才会执行后续操作
							event = event || window.event;
							var target = event.target || event.srcElement;
							//鼠标在单元格之间左右space个px内响应
							var space = 3;
							//鼠标相对应目标单元格左边框的距离
							var targetClientX = event.clientX - target.getBoundingClientRect().left;
							/*鼠标位置移到单元格边框附近时，改变单元格指针样式，绑定mousedown事件，
							  移出监听范围外时再复原指针样式，解绑mousedown  */
							if(colIndex > 0 && targetClientX <= space && targetClientX >= 0){ //在目标单元格左边框附近
								options = $.extend(options, {field: $(this).attr('field'), isLeftBorder: true});
								$(cell).css('cursor', options.colResizeCursor);
								$(cell).bind('mousedown',options, onMouseDownHandle);
							}else if(colIndex < colNum-1 && targetClientX >= $(cell).outerWidth()-space
								&& targetClientX <= $(cell).outerWidth()){ //在目标单元格右边框附近
								options = $.extend(options, {field: $(this).attr('field'), isLeftBorder: false});
								$(cell).css('cursor', options.colResizeCursor);
								$(cell).bind('mousedown',options, onMouseDownHandle);
							}else{
								$(cell).css('cursor', 'default');
								$(cell).unbind('mousedown', onMouseDownHandle);
							}
						},
						mouseout: function(event){
							$(cell).css('cursor', 'default');
							$(cell).unbind('mousedown', onMouseDownHandle);
						}
					});
				});
			}else{//取消拖拽功能
				//删除拖拽指示线
				if($(tableContainer).children(".resizeColCursor") && $(tableContainer).children(".resizeColCursor").length>0){
					$(tableContainer).children(".resizeColCursor").remove();
					//表头单元格解绑事件
					var headerTH = $(bodyCol[0]).find("th[field]");
					$.each(headerTH, function(index, cell){
						$(cell).unbind('mousemove');
					});
				}
			}
			//---------------end: resizeTableColumnWidth--------------------------//
		}; // end: setBodyColResizable 
		//-----------表头单元格mousedown事件处理函数------------//
		var onMouseDownHandle = function(e){
			e = e || window.event;
			e.stopPropagation();
			//鼠标按下,某个表头单元格被拖拽
			isMouseDown = true;
			var opts = e.data;
			//target： 响应鼠标事件的表头单元格
			var target = e.target || e.srcElement; 
			var container = e.data.tableContainer[0]; //表头和表数据主体的父容器
			var containerX = container.getBoundingClientRect().left;
			var resizeCursor = $(container).find('#resizeColCursor');
			//表的各个组成部分：header, body, footer
			var bodyCol = $BodyCols;
			//拖拽指示线的高度=header,body,footer的高度之和
			var cursorH = 0;
			$.each(bodyCol, function(i){
				cursorH += $(bodyCol[i]).height();
			});
			var cursorTop = 0;
			var containerPosition = $(container).css('position');
			if(containerPosition == 'absolute'){//绝对定位是，指示线的top值=header的top值
				cursorTop = parseInt($(bodyCol[0]).css('top'));
				if(isNaN(cursorTop)){
					cursorTop = 0;
				}
			}else if(containerPosition == 'relative'){//TODO:: 以前版本遗留的代码，未测试
				if($(bodyCol[0]).css("position")=="absolute"){//header的定位方式
					cursorTop = $(bodyCol[0]).offset().top;
				}else{ //表头前面有元素时，cursorTop=前面元素所占的高度总和+header.top
					var index = $(container).parent().children().index($(container));
					var prevSiblings = $(container).parent().children().slice(0, index);
					$(prevSiblings).each(function(){
						cursorTop += $(this).outerHeight();
					});
					cursorTop += parseInt($(bodyCol[0]).css("top")) || 0;
				}
			}
			//表格内容禁止被选中
			setSelectable($(resizeCursor).parent(), false);
			$(resizeCursor).css({'display': 'block',
								'height': cursorH+'px',
								'top':cursorTop+'px',
								'left':e.clientX - containerX+'px'});
			
			$(document).unbind("mousemove");
			$(document).unbind("mouseup");
			$(document).bind({
				mousemove : function(event){
					if(isMouseDown){
						$(target).css('cursor',opts.colResizeCursor);
						$(target).siblings().css('cursor',opts.colResizeCursor);
						//复合表头会有多行的情况，每行的th都要做处理
						$(target).parent().siblings().children().css('cursor',opts.colResizeCursor);
						event = event || window.event;
						$(resizeCursor).css({'left':event.clientX - containerX+'px'});
					}
				},
				mouseup : function(event){
					if(isMouseDown){
						$(target).css('cursor','default');
						$(target).siblings().css('cursor','default');
						$(target).parent().siblings().children().css('cursor','default');
						event = event || window.event;
						resizeTableColumnWidth($.extend({
							mouseClientX : event.clientX 
							}, opts));
						$(resizeCursor).css({'display':'none'});
						//表格内容允许被选中
						setSelectable($(resizeCursor).parent(), true);
						isMouseDown = false;
					}
				}
			});
		};
		//-----------end: onMouseDownHandle------------//
		//---------------改变列宽--------------------------------//
		var resizeTableColumnWidth = function(opts){
			var tableContainer = opts.tableContainer;
			//拖拽单元格的field属性值
			var field = opts.field;
			var mouseX = opts.mouseClientX;
			var colMinWidth = opts.colMinWidth;
			//表的各组成部分header,body,footer
			var bodyCol = $BodyCols;
			
			//获取主数据表中第一行的field属性值与拖拽单元格相同的单元格
			var target = $(bodyCol[0]).find("th:[field='"+field+"']")[0];
			//拖拽单元格及前后格的宽度值
			var orgW=$(target).width();
			var prevCell, nextCell;
			var increaseW; //拖拽单元格的宽度的增量 
			if(opts.isLeftBorder){ //拖动左border
				var prevColProp = getPrevVisibleColProps(field);
				if(prevColProp){
					prevCell = $(bodyCol[0]).find("th[field='"+prevColProp.define.field+"']:first");
				}
				if(!prevCell[0]){
					return;
				}
				var prevColW = $(prevCell).width();
				
				increaseW = target.getBoundingClientRect().left - opts.mouseClientX;
				if(increaseW>0 && colMinWidth + increaseW > prevColW){//向左拖,保证前一列最小宽度
					increaseW = prevColW - colMinWidth;
				}else if(increaseW<0 && colMinWidth - increaseW > orgW){//向右拖，保证当前列最小宽度
					increaseW = colMinWidth - orgW;
				}
				var currentW = $(target).find('div.table_datagrid').width()+increaseW;
				var prevW = $(prevCell).find('div.table_datagrid').width()-increaseW;
				var prevField = $(prevCell).attr("field");
				var currCompound=$(bodyCol[0]).find("th:[field='"+field+"']").attr("data-compound");
				var preCompound = $(bodyCol[0]).find("th:[field='"+prevField+"']").attr("data-compound");
				/** 当前单元格是复合单元格的子格 */
				if(currCompound){
					//并且它和它的前一个单元格的data-compound属性值不同时，要修改该复合单元格的父格的宽度 
					if(currCompound != preCompound){
						$(bodyCol[0]).find("th:[data-compound='"+currCompound+"']").each(function(){
							if(parseInt($(this).attr("colspan"))>1){
								$(this).children().width($(this).children().width()+increaseW);
							}
						});
						//前一个单元格也是另一个复合单元格的子格时，修改前一个单元格所在的复合单元格的父格的宽度
						if(preCompound){
							$(bodyCol[0]).find("th:[data-compound='"+preCompound+"']").each(function(){
								if(parseInt($(this).attr("colspan"))>1){
									$(this).children().width($(this).children().width()-increaseW);
								}
							});
						}
					}
				}else{ //当前单元格是普通单元格
					/** 当前单元格的前一个单元格是复合单元格时，要修改该复合单元格的父格的宽度 */
					if(preCompound){
						$(bodyCol[0]).find("th:[data-compound='"+preCompound+"']").each(function(){
							if(parseInt($(this).attr("colspan"))>1){
								$(this).children().width($(this).children().width()-increaseW);
							}
						});
					}
				}
				//设置单元格内部div的宽度 
				$.each(bodyCol, function(i, domElm){
					$(domElm).find("th:[field='"+field+"'], td:[field='"+field+"']").find('div.table_datagrid').width(currentW);
					$(domElm).find("th:[field='"+prevField+"'], td:[field='"+prevField+"']").find('div.table_datagrid').width(prevW);
					
				});
				var currFieldW = currentW + $ColumnPropsMap[field]["paddingWidth"]+$ColumnPropsMap[field]["borderWidth"];
				var prevFieldW = prevW  + $ColumnPropsMap[prevField]["paddingWidth"]+$ColumnPropsMap[prevField]["borderWidth"];
				$ColumnPropsMap[field]["width"] = currFieldW;
				$ColumnPropsMap[prevField]["width"] = prevFieldW;
				
			}else{ //拖动右border
				var nextColProp = getNextVisibleColProps(field);
				if(nextColProp){
					nextCell = $(bodyCol[0]).find("th[field='"+nextColProp.define.field+"']:first");
				}
				if(!nextCell[0]){
					return;
				}
				var nextColW = $(nextCell).width();
				increaseW = opts.mouseClientX - target.getBoundingClientRect().right;
				if(increaseW > 0 && colMinWidth + increaseW > nextColW){ //向右拖，保证后一列最小宽度
					increaseW = nextColW - colMinWidth;
				}else if(increaseW < 0 && colMinWidth - increaseW > orgW){ //向左拖，保证当前列最小宽度
					increaseW = colMinWidth - orgW;
				}
				var currentW = $(target).find('div.table_datagrid').width()+increaseW;
				var nextW = $(nextCell).find('div.table_datagrid').width()-increaseW;
				var nextField = $(nextCell).attr("field");
				var currCompound=$(bodyCol[0]).find("th:[field='"+field+"']").attr("data-compound");
				var nextCompound = $(bodyCol[0]).find("th:[field='"+nextField+"']").attr("data-compound");
				/** 当前单元格是复合单元格的子格 */
				if(currCompound){
					//并且它和它的后一个单元格的data-compound属性值不同时，要修改当前复合单元格的父格的宽度 
					if(currCompound != nextCompound){
						$(bodyCol[0]).find("th:[data-compound='"+currCompound+"']").each(function(){
							if(parseInt($(this).attr("colspan"))>1){
								$(this).children().width($(this).children().width()+increaseW);
							}
						});
						//后一个单元格也是另一个复合单元格的子格时，修改后一个单元格所在的复合单元格的父格的宽度
						if(nextCompound){
							$(bodyCol[0]).find("th:[data-compound='"+nextCompound+"']").each(function(){
								if(parseInt($(this).attr("colspan"))>1){
									$(this).children().width($(this).children().width()-increaseW);
								}
							});
						}
					}
				}else{ //当前单元格是普通单元格
					/** 当前单元格的后一个单元格是复合单元格时，要修改该复合单元格的父格的宽度 */
					if(nextCompound){
						$(bodyCol[0]).find("th:[data-compound='"+nextCompound+"']").each(function(){
							if(parseInt($(this).attr("colspan"))>1){
								$(this).children().width($(this).children().width()-increaseW);
							}
						});
					}
				}
				//设置单元格内部div的宽度 
				$.each(bodyCol, function(i, domElm){
					$(domElm).find("th:[field='"+field+"'], td:[field='"+field+"']").find('div.table_datagrid').width(currentW);
					$(domElm).find("th:[field='"+nextField+"'], td:[field='"+nextField+"']").find('div.table_datagrid').width(nextW);
				});
				var currFieldW = currentW + $ColumnPropsMap[field]["paddingWidth"]+$ColumnPropsMap[field]["borderWidth"];
				var nextFieldW = nextW + $ColumnPropsMap[nextField]["paddingWidth"]+$ColumnPropsMap[nextField]["borderWidth"];
				$ColumnPropsMap[field]["width"] = currFieldW;
				$ColumnPropsMap[nextField]["width"] = nextFieldW;
			}
		};
		/*设置obj的内容是否允许被选中
		selectable为true允许被选中；false禁止选中内容
		*/
		var setSelectable = function(obj, selectable){
			if(selectable){
				$(obj).css({ 
							'-moz-user-select' : 'auto', 
							'-webkit-user-select': 'auto',
							'-ms-user-select': 'auto'
							});
				$(obj).unbind('selectstart');
			}else{
				$(obj).css({ 
							'-moz-user-select' : 'none', 
							'-webkit-user-select': 'none',
							'-ms-user-select': 'none'
							});
				$(obj).bind('selectstart', function(){return false;});
			}
		};// end: setSelectable 
		
		/** 
		调用例子：mergeSort(rows, 0, rows.length-1, false, 'NUMBER');//rows待排序的行元素数组
		对array做排序
		begin,end指定排序的范围
		desc指定升降序:true是降序
		dataType做比较的数据类型：'NUMBER','DATE','STRING_EN','STRING_CH'
		*/
		var mergeSort = function(array,begin,end,desc,dataType){
			if(begin==end || begin==-1 || end==-1){
				return;
			}
			var mid=Math.floor((begin+end)/2);
			mergeSort(array,begin,mid,desc,dataType);
			mergeSort(array,mid+1,end,desc,dataType);
			merge(array,begin,end,desc,dataType);   
		};
		//对array[begin,end]做排序
		var merge = function(array,begin,end,desc, type){
			if(begin==-1 || end==-1){
				return;
			}
			var mid=Math.floor((begin+end)/2);
			 /**
			  left 前半部分数组起始指针
			  right 后半部分数组起始指针
			  k 临时数组指针
			 */
			var left=begin, right=mid+1, k=begin;
			var temp =new Array(array.length);
			while(left<=mid && right<=end){
				if(compareRowObj(array[left], array[right], desc, type)){
					temp[k++]=array[left++];
				}else{
					temp[k++]=array[right++];
				}
			}
		  //前半数组中剩余的值赋给temp
			while(left<=mid)   
				temp[k++]=array[left++];  
		  //后半数组中剩余的值赋给temp 
			while(right<=end)  
				temp[k++]=array[right++]; 
			for(var i=begin;i<=end;i++)
				array[i]=temp[i];
		}; //end
		
		/*比较行的data('sortKey')
		desc=true为降序排序做比较；false为升序排序做比较
		type: NUMBER, STRING-EN, STRING-CH, DATE.
		返回值是false:需要调换a,b的顺序
		*/
		var compareRowObj = function(a, b, desc, type){
			var va = $(a).data('sortKey');
			var vb = $(b).data('sortKey');
			switch(type){
				case 'NUMBER':
					if(va.search('.')>=0 || vb.search('.')>=0){ //小数
						var fa = parseFloat(va);
						var fb = parseFloat(vb);
						return desc ? (fa-fb)>=0 : (fa-fb)<=0;
					}else{ //整数
						var ia = parseInt(va);
						var ib = parseInt(vb);
						return desc ? (ia-ib)>=0 : (ia-ib)<=0;
					}
					break;
				case 'DATE'://暂时支持的短日期字符串格式：月/日/年  Date.parse(va)返回毫秒数
					return desc ? (Date.parse(va)-Date.parse(vb))>=0 : (Date.parse(va)-Date.parse(vb))<=0;
					break;
				case 'STRING_CH':
					
				//	break;
				case 'STRING_EN':
				default:
					return desc ? va.localeCompare(vb)>=0 : va.localeCompare(vb)<=0;
					break;
			}
		}; //end
		
		var getSortType = function(fieldName){
			var th = $BodyCols[0].find("th[field='"+fieldName+"']").find("span.sort");
			var type = "nosort";
			if($(th).hasClass("desc")){
				type = "desc";
			}else if($(th).hasClass("asc")){
				type = "asc";
			}
			return type;
		};
		
		/**
		 * type: "asc" | "desc"
		 */
		var sort = function(fieldName, type){
			var sortType = getSortType(fieldName);
			if(sortType === type){
				return;
			}
			var $eObj = $BodyCols[0].find("th[field='"+fieldName+"']");
			if(!$eObj[0]){
				$eObj = $HeaderCols[0].find("th[field='"+fieldName+"']");
			}
			if(!$eObj[0]){//表格内部不存在这样的列
				return;
			}
			var	span = $eObj.find('span');
			
			//span没有'sort'class时，不排序
			if (!span.hasClass('sort')) {
				return;
			}
			
			var rows = new Array(),
				anotherRows,	
				headerRows = getColsRows($HeaderCols, 1),
				bodyRows = getColsRows($BodyCols, 1),
				dataType = $ColumnPropsMap[fieldName]["define"]["children"][0]["dataType"];
			
			var thgrids = getAllThGrids();						//事件的span对象			
			$(thgrids).find('span.sort').removeClass('asc desc');//移除无关的排序图标
			type==="asc" ? span.addClass("asc") : span.addClass("desc");
			if($ColumnPropsMap[fieldName]["isFixed"]){
				var headerRows = getColsRows($HeaderCols, 1);
				$.each(headerRows, function(i, row){
					var v = serializeTableCell($(row).children("td[field='"+fieldName+"']")[0]);
					if(v){//包含该field的行缓存数据sortkey
						$(row).data('sortKey', v[fieldName]);
						rows.push(row);
					}
				});
			}else{
				var bodyRows = getColsRows($BodyCols, 1);
				$.each(bodyRows, function(i, row){
					var v = serializeTableCell($(row).children("td[field='"+fieldName+"']")[0]);
					if(v){//包含该field的行缓存数据sortkey
						$(row).data('sortKey', v[fieldName]);
						rows.push(row);
					}
				});
			}
			mergeSort(rows, 0, rows.length-1, type==="desc", dataType);
			var fixedTable = $HeaderCols[1].find("table")[0];						//固定列的表格容器包装集
			var normalTable = $BodyCols[1].find("table")[0];		
			$.each(rows, function(i) {	
				var subBody = null;
				var subFixed = null;
				var index = $(this).attr($Options.rownumberIndex);
				var currFixed = $(fixedTable).find("tr["+$Options.rownumberIndex+"='"+index+"']");
				if($(this).next() && $(this).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW){
					subBody = $(this).next();
					subFixed = $(currFixed).next();
				}
				currFixed.appendTo($(fixedTable));
				$(this).appendTo($(normalTable));
				if(subBody){
					$(subBody).appendTo($(normalTable));
					$(subFixed).appendTo($(fixedTable));
				}
			});
			resetStyle();
		};
		
		var toggleSort = function(fieldName){
			var sortType = getSortType(fieldName);
			if(sortType == "asc"){
				sort(fieldName, "desc");
			}else{
				sort(fieldName, "asc");
			}
		};
		
		//排序方法
		var sort_old = function(eObj, fieldName, dataType) {
			//获取事件对象的属性
			var rows,
				anotherRows,	
				headerRows = getColsRows($HeaderCols, 1),
				bodyRows = getColsRows($BodyCols, 1),
				$eObj = $(eObj),
				span = $eObj.find('span');	//getAllThGrids
			var thgrids = getAllThGrids();						//事件的span对象			
			$(thgrids).not($eObj).find('span').removeClass('asc desc');//移除无关的排序图标

			//span没有'sort'class时，不排序
			if (!span.hasClass('sort')) {
				return;
			}
			//如果事件对象的span元素有'asc'或'desc'classname的改变他们的状态，否则直接加'asc'classname
			if (span.hasClass('asc') || span.hasClass('desc')) {					
				span.toggleClass('desc').toggleClass('asc');
			} else {
				span.addClass("asc");
			}		
			var rows = new Array();				
			$.each(bodyRows, function(i, row) {
				var v;
				if($(row).children("td[field='"+$eObj.attr("field")+"']")[0]){
					v = serializeTableCell($(row).children("td[field='"+$eObj.attr("field")+"']")[0]);
				}else{
					v = serializeTableCell($(headerRows[i]).children("td[field='"+$eObj.attr("field")+"']")[0]);
				}
				if(v){//包含该field的行缓存数据sortkey
					$(row).data('sortKey', v[fieldName]);
					rows.push(row);
				}
				
			});

			//行排序
			var desc = span.hasClass('desc');

			//调用排序
			//如果类型是返回则删除'asc' 'desc'样式
			if (dataType === 'return') {
				span.removeClass('asc desc');
				return;
			//否则按相关类型调用
			} else {				
				mergeSort(rows, 0, rows.length-1, desc, dataType);
			} 	
			var fixedTable = $HeaderCols[1].find("table")[0];						//固定列的表格容器包装集
			var normalTable = $BodyCols[1].find("table")[0];		
			$.each(rows, function(i) {	
				var subBody = null;
				var subFixed = null;
				var index = $(this).attr($Options.rownumberIndex);
				var currFixed = $(fixedTable).find("tr["+$Options.rownumberIndex+"='"+index+"']");
				if($(this).next() && $(this).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW){
					subBody = $(this).next();
					subFixed = $(currFixed).next();
				}
				currFixed.appendTo($(fixedTable));
				$(this).appendTo($(normalTable));
				if(subBody){
					$(subBody).appendTo($(normalTable));
					$(subFixed).appendTo($(fixedTable));
				}
			});
			resetStyle();
		}; //end
		
		/**
		 * 展开分组
		 */
		var expandGroup = function(rowIndex){
			var fixedRow = getFixedRow(rowIndex);
			if($(fixedRow).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
				var normalRow = getNormalRow(rowIndex);
				var depth = parseInt($(fixedRow).attr("depth"));
				var targetFixed=fixedRow, targetNormal=normalRow;
				//当前分组行分组字段的样式切换
				$(fixedRow).find("td[field='"+$GroupProps[$(fixedRow).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(fixedRow).attr("depth")]["groupName"]+"']").each(function(){
					$(this).removeClass($Options.groupCollapsedClass).addClass($Options.groupExpandedClass);
				});
				$(normalRow).find("td[field='"+$GroupProps[$(normalRow).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(normalRow).attr("depth")]["groupName"]+"']").each(function(){
					$(this).removeClass($Options.groupCollapsedClass).addClass($Options.groupExpandedClass);
				});
				targetFixed = $(targetFixed).next();
				targetNormal = $(targetNormal).next(); 
				while(targetFixed[0] && !$(targetFixed).attr("depth") || parseInt($(targetFixed).attr("depth"))>depth){
					if($(targetFixed).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
						$(targetFixed).find("td[field='"+$GroupProps[$(targetFixed).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(targetFixed).attr("depth")]["groupName"]+"']").each(function(){
							$(this).removeClass($Options.groupCollapsedClass).addClass($Options.groupExpandedClass);
						});
						$(targetNormal).find("td[field='"+$GroupProps[$(targetNormal).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(targetNormal).attr("depth")]["groupName"]+"']").each(function(){
							$(this).removeClass($Options.groupCollapsedClass).addClass($Options.groupExpandedClass);
						});
					}
					$(targetFixed).show();
					$(targetNormal).show();
					targetFixed = $(targetFixed).next();
					targetNormal = $(targetNormal).next(); 
				}
			}
			//resetHeight();
			measureBodyUpdate();
		};
		/**
		 * 关闭分组
		 */
		var collapseGroup = function(rowIndex){
			var fixedRow = getFixedRow(rowIndex);
			if($(fixedRow).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
				var normalRow = getNormalRow(rowIndex);
				var depth = parseInt($(fixedRow).attr("depth"));
				var targetFixed=fixedRow, targetNormal=normalRow;
				//当前分组行分组字段的样式切换
				$(fixedRow).find("td[field='"+$GroupProps[$(fixedRow).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(fixedRow).attr("depth")]["groupName"]+"']").each(function(){
					$(this).removeClass($Options.groupExpandedClass).addClass($Options.groupCollapsedClass);
				});
				$(normalRow).find("td[field='"+$GroupProps[$(normalRow).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(normalRow).attr("depth")]["groupName"]+"']").each(function(){
					$(this).removeClass($Options.groupExpandedClass).addClass($Options.groupCollapsedClass);
				});
				targetFixed = $(targetFixed).next();
				targetNormal = $(targetNormal).next(); 
				while(targetFixed[0] && !$(targetFixed).attr("depth") || parseInt($(targetFixed).attr("depth"))>depth){
					if($(targetFixed).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
						$(targetFixed).find("td[field='"+$GroupProps[$(targetFixed).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(targetFixed).attr("depth")]["groupName"]+"']").each(function(){
							$(this).removeClass($Options.groupExpandedClass).addClass($Options.groupCollapsedClass);
						});
						$(targetNormal).find("td[field='"+$GroupProps[$(targetNormal).attr("depth")]["groupField"]+"']").find("[name='"+$GroupProps[$(targetNormal).attr("depth")]["groupName"]+"']").each(function(){
							$(this).removeClass($Options.groupExpandedClass).addClass($Options.groupCollapsedClass);
						});
					}
					$(targetFixed).hide();
					$(targetNormal).hide();
					targetFixed = $(targetFixed).next();
					targetNormal = $(targetNormal).next(); 
				}
			}
			//resetHeight();
			measureBodyUpdate();
		};
		
		var cancelBubble = function(event){
			var event = event || window.event;
			stopPropagation(event);
		};
		
		var bindRowEvent = function(tableRow){
			$(tableRow).bind($Options.rowSelectEvent,  function(event){// 双击/单击选中行事件
							if($Options.row_selectable){//单击行的任意位置，选中/反选当前行的开关，通过配置参数传入
								var event = event || window.event;
								var target = event.target || event.srcElement;
								var tr = $(target).closest("tr");
								var indexAttr = $Options.rownumberIndex;
								var index = $(tr).attr(indexAttr);
								var fixedtr = $HeaderCols[1].find("tr["+indexAttr+"='"+index+"']");
								var selected = $(fixedtr).find("[field='"+$ChkField+"']").find(":checkbox").attr("checked")==="checked";
								if($(fixedtr).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
									selectGroupRow(index, !selected);
								}else{
									selectRow(index, !selected);
								}
							}
						});
			$(tableRow).bind({
				"click": function(event){
					var event = event || window.event;
					var target = event.target || event.srcElement;
					var tr = $(target).closest("tr");
					var indexAttr = $Options.rownumberIndex;
					var index = $(tr).attr(indexAttr);
					var fixedRow = getFixedRow(index);
					var normalRow = getNormalRow(index);
					focusRow(index);
					$Element.trigger("row_click", [$.extend({}, serializeTableRow(normalRow), serializeTableRow(fixedRow))]);
				},
				
				"dblclick": function(event){
					var event = event || window.event;
					var target = event.target || event.srcElement;
					var tr = $(target).closest("tr");
					var indexAttr = $Options.rownumberIndex;
					var index = $(tr).attr(indexAttr);
					var fixedRow = getFixedRow(index);
					var normalRow = getNormalRow(index);
					focusRow(index);
					$Element.trigger("row_dblclick", [$.extend({}, serializeTableRow(normalRow), serializeTableRow(fixedRow))]);
				},
				"mouseover": function(event){//鼠标划过高亮
							if($Options.mouseoverHighlight){
								var event = event || window.event;
								var target = event.target || event.srcElement;
								var tr = $(target).closest("tr");
								highlightRow($(tr).attr($Options.rownumberIndex), true);
							}
						},
				"mouseout": function(event){//取消高亮
							if($Options.mouseoverHighlight){
								var event = event || window.event;
								var target = event.target || event.srcElement;
								var tr = $(target).closest("tr");
								highlightRow($(tr).attr($Options.rownumberIndex), false);
							}
						}
			});
			//subgrid事件绑定
			if($Options.isSubgrid){
				$(tableRow).children("td[field='"+$SubgridField+"']").find("."+$Options.subgridIconClass).bind({
					"click": function(event){
							cancelBubble(event);
							var event = event || window.event;
							var target = event.target || event.srcElement;
							var tr = $(target).closest("tr");
							//修改图标
							if($(target).hasClass($Options.subgridCollapseClass)){
								$(target).removeClass($Options.subgridCollapseClass);
								$(target).addClass($Options.subgridExpandClass);
								//隐藏子表querySubgridFieldName
								if($(tr).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW){
									showRow($(tr).next().attr($Options.rownumberIndex), false);
								}
							}else{
								$(target).removeClass($Options.subgridExpandClass);
								$(target).addClass($Options.subgridCollapseClass);
								//显示子表
								expandSubgrid($(tr).attr($Options.rownumberIndex));
							}
							
						}
				});
			}
		};
		
		var bindEvents = function(){
			scroll();	//绑定对应的滚动条事件
			/*全选反选*/
			$HeaderCols[0].find("th[field='"+$ChkField+"']").find(":checkbox").bind("click", function(event){
				if($Options.singleSelection){//单选模式下不响应
					$(this).removeAttr("checked");
					return;
				}
				var event = event || window.event;
				stopPropagation(event);
				var target = event.target || event.srcElement;
				var checked = $(target).attr("checked")==="checked";
				var row = $($HeaderCols[1]).find("tr");
				for(var i=0; i< row.length; i++){
					selectRow($(row[i]).attr($Options.rownumberIndex), checked);
				}
			});
			/*单行前面复选框选中单行*/
			$HeaderCols[1].find("td[field='"+$ChkField+"']").find(":checkbox").bind("click", function(event){
				var event = event || window.event;
				stopPropagation(event);
				var target = event.target || event.srcElement;
				var tr = $(target).closest("tr");
				var selected = $(tr).find("[field='"+$ChkField+"']").find(":checkbox").attr("checked")==="checked";
				if($(tr).attr("rowType")==rowTypeConstant.GROUP_HEADER_ROW){
					selectGroupRow($(tr).attr($Options.rownumberIndex), selected);
				}else{
					selectRow($(tr).attr($Options.rownumberIndex), selected);
				}
				
			});
			
			//固定区 行事件绑定
			bindRowEvent($HeaderCols[1].find("tr"));
			//主内容区 行事件绑定
			bindRowEvent($BodyCols[1].find("tr"));
			//列头事件绑定
			$HeaderCols[0].find("th").bind({
				"mouseover": function(event){
								if($Options.thMouseoverHighlight){
									$(this).addClass($Options.thhoverClass);
								}
							},
				"mouseout": function(event){
								if($Options.thMouseoverHighlight){
									$(this).removeClass($Options.thhoverClass);
								}
							},
				"click": function(event){
								var event = event || window.event;
								var target = event.target || event.srcElement;
								var colField = $(target).closest("th").attr("field");
								var cols = $FixedColumns;
								var targetColDefine;
								for(var i in cols){
									if(cols[i].field === colField){
										targetColDefine = cols[i];
										break;
									}
								}
								if(!targetColDefine){
									return;
								}
								for(var child in targetColDefine.children){
									if(targetColDefine.children[child].sortable){
										toggleSort(targetColDefine.children[child]["name"]);
										break;
									}
								}
							}
			});
			$BodyCols[0].find("th").bind({
				"mouseover": function(event){
								if($Options.thMouseoverHighlight){
									$(this).addClass($Options.thhoverClass);
								}
							},
				"mouseout": function(event){
								if($Options.thMouseoverHighlight){
									$(this).removeClass($Options.thhoverClass);
								}
							},
				"click": function(event){
								var event = event || window.event;
								var target = event.target || event.srcElement;
								var colField = $(target).closest("th").attr("field");
								var cols = $NormalColumns;
								var targetColDefine;
								for(var i in cols){
									if(cols[i].field === colField){
										targetColDefine = cols[i];
										break;
									}
								}
								if(!targetColDefine){
									return;
								}
								for(var child in targetColDefine.children){
									if(targetColDefine.children[child].sortable){
										toggleSort(targetColDefine.children[child]["name"]);
										break;
									}
								}
							},
					"contextmenu": function(event){
								var event = event || window.event;
								stopPropagation(event);
								$(this).gridColumnMenu(event, {specialMode: false, grid:$Instance, column:$(this).attr("field")});
								return false;
							}
			});
			//group header field事件绑定
			for(var i in $GroupProps){
				if($ColumnPropsMap[$GroupProps[i]["groupField"]]["colIndex"] < $Options.colDefine.fixedColumns.length){
					//分组列位于固定区
					$HeaderCols[1].find("tr[rowType='"+rowTypeConstant.GROUP_HEADER_ROW+"']").each(function(){
						$(this).find("[name='"+$GroupProps[i]["groupName"]+"']").bind("click", function(event){
							if($(this).hasClass($Options.groupExpandedClass)){
								collapseGroup($(this).closest("tr").attr("tablerowindex"));
							}else{
								expandGroup($(this).closest("tr").attr("tablerowindex"));
							}
						});
					});
				}else{
					$BodyCols[1].find("tr[rowType='"+rowTypeConstant.GROUP_HEADER_ROW+"']").each(function(){
						$(this).find("[name='"+$GroupProps[i]["groupName"]+"']").bind("click", function(event){
							if($(this).hasClass($Options.groupExpandedClass)){
								collapseGroup($(this).closest("tr").attr("tablerowindex"));
							}else{
								expandGroup($(this).closest("tr").attr("tablerowindex"));
							}
						});
					});
				}
			}
			//拖拽功能绑定
			setBodyColResizable($BodyPane, $Options.colResizable);
			$(window).resize(function(){
				setTimeout(function(){
					try{
						updateSize();
					} catch(e) {}
				},100); 
			});
			//新增/删除行重新计算小计
			if($StatsField.length>0){
				$Element.on({
					"addRowEvent": function(){
							for(var i=0,len=$StatsField.length;i<len;i++){
								statsColumn($StatsField[i]);
							}
							
						},
					"deleteRowEvent": function(){
						for(var i=0,len=$StatsField.length;i<len;i++){
							statsColumn($StatsField[i]);
						}
					}
				});
			}
			//方向键
			$(document).keydown(function(e){ //键盘上下、回车键控制
				e = e || window.event;
				var currKey = e.keyCode || e.which || e.charCode;
				var target = e.srcElement || e.target;
				if($(target).parents("."+$Options.bodyPane).length<=0){ //判断不在表格内部
					return;
				}
				var srcTD = $(target).closest("td");
				var  srcTR = $(srcTD).closest("tr");
				var index = srcTD.index();
				var rowIndex = $(srcTR).index();
				try{
					switch(currKey){
						case 13: //回车键，新增一行
				//			if(!$(srcTD).next()[0]){ //是最后一列
				//				addRow(null, rowIndex+1);
					//TODO:: focus
				//			}
							break;
						case 38: //方向键上
							$(srcTR).prev().find('td:eq('+index+')').find("input").focus();
							break;
						case 40: //方向键下
							$(srcTR).next().find('td:eq('+index+')').find("input").focus();
							break;
					}
				}catch(e){}
				
			});
		};
		//生成subgrid行的固定列
		var createSubgridFixedTrContent = function(index, columnsDef){
			var html = "<tr "+$Options.rownumberIndex+"='"+index+"' rowType='"+rowTypeConstant.SUBGRID_ROW+"' >";
			var rowH = $Options.subgridRowHeight;
			for(col in columnsDef){
				var tempObj = columnsDef[col];
				var cls = (tempObj.className && tempObj.className.length>0) ? "class='"+tempObj.className+"'" : "";
				var td = "", fieldProp = $ColumnPropsMap[tempObj.field];
				var w = fieldProp["width"] || fieldProp["unscaledWidth"];
				w = w - fieldProp.borderWidth - fieldProp.paddingWidth;
				var displayStyle = fieldProp["hidden"] ? "display:none;" : "";
				td = "<td "+cls+" field='"+tempObj.field
							+"' style='"+displayStyle+"'><div "
							+" style='width:"+w+"px; height:"+rowH+"px;'></div></td>";
				html += td;
			}
			html += "</tr>";
			return html;
		};
		//新增一行子表行
		var addSubgridRow = function(subgrid, parentRowIndex){
			var fixedRow = getFixedRow(parentRowIndex);
			var normalRow = getNormalRow(parentRowIndex);
			//生成固定行
			var str = createSubgridFixedTrContent($RowIndex+1, $Options.colDefine.fixedColumns);
			//生成数据行
			var colspan = $Options.colDefine.columns.length;
			var html = "<tr "+$Options.rownumberIndex+"='"+($RowIndex+1)+"' rowType='"+rowTypeConstant.SUBGRID_ROW+"' ><td colSpan='"
					+colspan+"'><div style='height:"+$Options.subgridRowHeight+"px;'>"+subgrid+"</div></td></tr>";
			$(fixedRow).after(str);
			$(normalRow).after(html);
			$RowIndex++;
			resetStyle();
		};
		/**
		*展开rowIndex行的子表行
		**/
		var expandSubgrid = function(rowIndex){
			var fixedRow = getFixedRow(rowIndex);
			if($(fixedRow).next() && $(fixedRow).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW){
				showRow($(fixedRow).next().attr($Options.rownumberIndex), true);
			}else{
				//加载子表
				var normal = getNormalRow(rowIndex);
				var rowData = $.extend({}, serializeTableRow(normal), serializeTableRow(fixedRow));
				var param = {};
				param[$Options.querySubgridFieldName] = rowData[$Options.querySubgridFieldName];
/**================???????????===========*/				
		/*		$.ajax({
					url:$Options.subgridUrl,
					data:rowData,
					cache:false,
					async:false,
					success:function(resp){
						addSubgridRow(resp, rowIndex);
					}
				}); */
				addSubgridRow(JSON.stringify(rowData), rowIndex);
			}
			
		};
		var gridContent = "<table><tr><th>第一列</th><th>第二列</th><th>第三列</th></tr><tr><td>1</td><td>2</td><td>2</td></tr><tr><td>11</td><td>22</td><td>33</td></tr></table>";
		/**
		*显示/隐藏行序号为rowIndex的行
		**/
		var showRow = function(rowIndex, show){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			if(fixedRow){
				show ? $(fixedRow).show() : $(fixedRow).hide();
			}
			if(normalRow){
				show ? $(normalRow).show() : $(normalRow).hide();
			}
			resetStyle();
		};
		/**
		* @rowIndex 目标行行号
		* @highlight true高亮，false取消高亮
		**/
		var highlightRow = function(rowIndex, highlight){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			if(highlight){
				isIE7Le ? $(fixedRow).find('td').addClass($Options.hoverClass) : $(fixedRow).addClass($Options.hoverClass);
				isIE7Le ? $(normalRow).find('td').addClass($Options.hoverClass) : $(normalRow).addClass($Options.hoverClass);
			}else{
				isIE7Le ? $(fixedRow).find('td').removeClass($Options.hoverClass) : $(fixedRow).removeClass($Options.hoverClass);
				isIE7Le ? $(normalRow).find('td').removeClass($Options.hoverClass) : $(normalRow).removeClass($Options.hoverClass);
			}
		};
		/**
		* @rowIndex 目标行行号
		* @select true选中，false取消选中
		**/
		var selectRow = function(rowIndex, select){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			var data = $.extend({}, serializeTableRow(normalRow), serializeTableRow(fixedRow));
			if(select==true){
				if($Options.singleSelection && $SelectedRowIndex!=-1){//取消选中已选中的行
					selectRow($SelectedRowIndex, false);
				}
				$(fixedRow).find("td[field='"+$ChkField+"']").find(":checkbox").attr("checked", "checked");
				isIE7Le ? $(fixedRow).find('td').addClass($Options.row_selectedClass) : $(fixedRow).addClass($Options.row_selectedClass);
				isIE7Le ? $(normalRow).find('td').addClass($Options.row_selectedClass) : $(normalRow).addClass($Options.row_selectedClass);
				$SelectedRowIndex = rowIndex;
				$($Element).trigger("select", [data]);
			}else{
				$(fixedRow).find("td[field='"+$ChkField+"']").find(":checkbox").removeAttr("checked");
				isIE7Le ? $(fixedRow).find('td').removeClass($Options.row_selectedClass) : $(fixedRow).removeClass($Options.row_selectedClass);
				isIE7Le ? $(normalRow).find('td').removeClass($Options.row_selectedClass) : $(normalRow).removeClass($Options.row_selectedClass);
				$SelectedRowIndex = -1;
				$($Element).trigger("unSelect", [data]);
			}
		};
		/**
		* 选中groupRow及改分组下的子行
		* @rowIndex 目标行行号
		* @select true选中，false取消选中
		***/
		var selectGroupRow = function(rowIndex, select){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			var depth = parseInt($(fixedRow).attr("depth"));
			var targetFixed=fixedRow, targetNormal=normalRow;
			if(select==true){
				do{
					$(targetFixed).find("td[field='"+$ChkField+"']").find(":checkbox").attr("checked", "checked");
					if(isIE7Le){
						$(targetFixed).find('td').addClass($Options.row_selectedClass);
						$(targetNormal).find('td').addClass($Options.row_selectedClass);
					}else{
						$(targetFixed).addClass($Options.row_selectedClass);
						$(targetNormal).addClass($Options.row_selectedClass)
					}
					targetFixed = $(targetFixed).next();
					targetNormal = $(targetNormal).next(); 
				}while(targetFixed[0] && (!$(targetFixed).attr("depth") || parseInt($(targetFixed).attr("depth"))>depth));
			}else{
				do{
					$(targetFixed).find("td[field='"+$ChkField+"']").find(":checkbox").removeAttr("checked");
					if(isIE7Le){
						$(targetFixed).find('td').removeClass($Options.row_selectedClass);
						$(targetNormal).find('td').removeClass($Options.row_selectedClass);
					}else{
						$(targetFixed).removeClass($Options.row_selectedClass);
						$(targetNormal).removeClass($Options.row_selectedClass)
					}
					targetFixed = $(targetFixed).next();
					targetNormal = $(targetNormal).next();
				}while(targetFixed[0] && (!$(targetFixed).attr("depth") || parseInt($(targetFixed).attr("depth"))>depth));
			}
		};
		
		var focusRow = function(rowIndex){
			var fixedRow = getFixedRow(rowIndex),
				normalRow = getNormalRow(rowIndex),
				oldFocusRow = getFixedRow($FocusRowIndex),
				oldNormalRow = getNormalRow($FocusRowIndex);
			if(isIE7Le){
				if(oldFocusRow){
					$(oldFocusRow).find('td').removeClass($Options.focusRowClass);
				}
				if(oldNormalRow){
					$(oldNormalRow).find('td').removeClass($Options.focusRowClass);
				}
				$(fixedRow).find('t').addClass($Options.focusRowClass);
				$(normalRow).find('td').addClass($Options.focusRowClass);
			}else{
				if(oldFocusRow){
					$(oldFocusRow).removeClass($Options.focusRowClass);
				}
				if(oldNormalRow){
					$(oldNormalRow).removeClass($Options.focusRowClass);
				}
				$(fixedRow).addClass($Options.focusRowClass);
				$(normalRow).addClass($Options.focusRowClass);
			}
			$FocusRowIndex = rowIndex;
			$Element.trigger("focusRowEvent", [$.extend({}, serializeTableRow(fixedRow), serializeTableRow(normalRow))]);
		};
		
		/**
		* 通过rowIndex获取行
		**/
		var getFixedRow = function(rowIndex){
			return $($HeaderCols[1]).find("tr["+$Options.rownumberIndex+"='"+rowIndex+"']:first");
		};
		var getNormalRow = function(rowIndex){
			return $($BodyCols[1]).find("tr["+$Options.rownumberIndex+"='"+rowIndex+"']:first");
		};
		/**
		* 缓存删除行数据
		**/
		var cacheDeletedRow = function(rowIndex){
			if($AddedRows[rowIndex]){
				delete $AddedRows[rowIndex];
			}else if($UpdatedRows[rowIndex]){
				delete $UpdatedRows[rowIndex];
				var fixed = getFixedRow(rowIndex);
				var normal = getNormalRow(rowIndex);
				var rowData = $.extend({}, serializeTableRow(normal), serializeTableRow(fixed));
				$DeletedRows[rowIndex]=rowData;
			}else{
				var fixed = getFixedRow(rowIndex);
				var normal = getNormalRow(rowIndex);
				var rowData = $.extend({}, serializeTableRow(normal), serializeTableRow(fixed));
				$DeletedRows[rowIndex]=rowData;
			}
		};
		/**
		*@cond:过滤刷选的条件{key:value, ...}
		*返回满足条件的行{fixed:fixedrow, body:bodyrow, rowIndex}数组
		**/
		var filterData = function(cond){
			var bodyRows = $BodyCols[1].children("table").children("tbody").children("tr");
			var fixedRows = $HeaderCols[1].children("table").children("tbody").children("tr");
			var result = [];
			for(var i=0; i < bodyRows.length; i++){
				var rowData = $.extend({}, serializeTableRow(bodyRows[i]), serializeTableRow(fixedRows[i]));
				var rowMatch = true;
				for(var j in cond){
					var cellMatch = false;
					loop:
					for(var k in rowData){
						if(j===k){//key和value都匹配
							var condvalue = cond[j];
							if(typeof condvalue === "object") {
								for(var x in condvalue) {
									if(condvalue[x] === rowData[k]) {
										cellMatch = true;
										break loop;
									}
								}
							} else {
								var condvalue = cond[j];
								if(condvalue.indexOf("@") != -1) {
									var condArr = condvalue.split("@");
									for(var t in condArr) {
										if(condArr[t] === rowData[k]) {
											cellMatch = true;
											break loop;
										}
									}
								} else {
									if(cond[j]===rowData[k]) {
										cellMatch = true;
										break loop;
									}
								}
							}
						}
					}
					if(!cellMatch){
						rowMatch = false;
						break;
					}
				}
				if(rowMatch){
					result.push({fixed: fixedRows[i], body: bodyRows[i], rowIndex: $(fixedRows[i]).attr($Options.rownumberIndex)});
				}
			}
			return result;
		};
		
		/**
		*@cond:过滤刷选的条件{key:value, ...}
		*返回不满足满足条件的行{fixed:fixedrow, body:bodyrow, rowIndex}数组
		**/
		var rejectData = function(cond){
			var bodyRows = $BodyCols[1].children("table").children("tbody").children("tr");
			var fixedRows = $HeaderCols[1].children("table").children("tbody").children("tr");
			var result = [];
			for(var i=0; i < bodyRows.length; i++){
				var rowData = $.extend({}, serializeTableRow(bodyRows[i]), serializeTableRow(fixedRows[i]));
				var rowMatch = true;
				for(var j in cond){
					var cellMatch = false;
					loop:
					for(var k in rowData){
						if(j===k){//key和value都匹配
							var condvalue = cond[j];
							if(typeof condvalue === "object") {
								for(var x in condvalue) {
									if(condvalue[x] === rowData[k]) {
										cellMatch = true;
										break loop;
									}
								}
							} else {
								if(cond[j]===rowData[k]) {
									cellMatch = true;
									break loop;
								}
							}
						}
					}
					if(!cellMatch){
						rowMatch = false;
						break;
					}
				}
				if(!rowMatch){
					result.push({fixed: fixedRows[i], body: bodyRows[i], rowIndex: $(fixedRows[i]).attr($Options.rownumberIndex)});
				}
			}
			return result;
		};
		
		//create 
		var create = function(){
			$FixedTHs = new Array(), $BodyTHs = new Array();
			//表头添加属性
			$($HeaderPane[0]).find('th[field]').each(function(){
				$FixedTHs.push(this);
				var fieldName = $(this).attr("field");
				try{
					//列宽固定的表头单元格设置width
					if(fieldName && $ColumnPropsMap[fieldName] && $ColumnPropsMap[fieldName]["define"]["fixedWidth"]){
						$(this).css("width", $ColumnPropsMap[fieldName]["define"]["fixedWidth"]+"px");
					}
				}catch(e){}
			});
			$($BodyPane[0]).find('th[field]').each(function(){
				$BodyTHs.push(this);
				var fieldName = $(this).attr("field");
				try{
					//列宽固定的表头单元格设置width
					if(fieldName && $ColumnPropsMap[fieldName] && $ColumnPropsMap[fieldName]["define"]["fixedWidth"]){
						$(this).css("width", $ColumnPropsMap[fieldName]["define"]["fixedWidth"]+"px");
					}
				}catch(e){}
			});	
		};
		var create1 = function() {	
			var grids,
				element = $Element,
				clone = element.children().clone();
						
			//debug add <DIV> tag
			grids = $.merge($HeaderPane.find('th, td'), $BodyPane.find('th, td'));
			//如果包含的单元格为空时返回，否则使用<div>包装内容
			if ( grids.length < 1 || grids.find('div').hasClass('table_datagrid') ) { 
				return;
			} else {
				$.each(grids, function() {
					//给包含文本内容的，添加<div>和'title'属性
					var titleText = $(this).text(),
						titleHtml = titleText.length > 0 ? 'title="' + $.trim(titleText) + '"': '';
					//表体数据单元格外加一个span, 用于序列化
					var fieldName = $(this).attr("field"),
						sortSpan = ($(this).is("th") && !$(this).find("span.sort")[0] && fieldName && $ColumnPropsMap[fieldName] && $ColumnPropsMap[fieldName]["define"]["type"]===columnTypeConstant.DATA_COLUMN && $ColumnPropsMap[fieldName]["define"]["children"][0]["sortable"]) ? "<span class=\"sort\"></span>" : "",
						spanHtml = ($(this).is("td") && fieldName && $ColumnPropsMap[fieldName] && $ColumnPropsMap[fieldName]["define"]["type"]===columnTypeConstant.DATA_COLUMN && $(this).find("[name]").length == 0) ? "<span name='"+fieldName+"'></span>":"";
					$(this).wrapInner('<div class="table_datagrid"'+ titleHtml + '>'+spanHtml+'</div>');
					$(this).find("div.table_datagrid").append(sortSpan);	//排序图标
				});		
				$($BodyPane[0]).find('th').each(function(){
					var fieldName = $(this).attr("field");
					try{
						if(fieldName && $ColumnPropsMap[fieldName] && $ColumnPropsMap[fieldName]["define"]["fixedWidth"]){
							$(this).css("width", $ColumnPropsMap[fieldName]["define"]["fixedWidth"]+"px");
						}
					}catch(e){}
				});	
				$($HeaderPane[0]).find('th').each(function(){
					var fieldName = $(this).attr("field");
					try{
						if(fieldName && $ColumnPropsMap[fieldName] && $ColumnPropsMap[fieldName]["define"]["fixedWidth"]){
							$(this).css("width", $ColumnPropsMap[fieldName]["define"]["fixedWidth"]+"px");
						}
					}catch(e){}
				});		
			}//end debug added
		};//end
		/**
		*获得表头各单元格无压缩的宽度并缓存。
		**/
		var initSize = function(){
			//固定区
		//	var thgrids = getThGrids($HeaderCols),
			var thgrids = $HeaderCols[0].find("th[field]"),
				status = getGridWidth(thgrids),	//获取单元格参照状态对象				
				arrayWth = status.width;	 //参照宽度数组				
			$.each(thgrids, function(i){
				var paddingW = parseInt($(this).css('padding-left')) || 0;
				paddingW = paddingW + parseInt($(this).css('padding-right')) || 0;
				var borderW = 0;
				if($(this).css('border-right-style') != "none"){
					borderW = borderW + (parseInt($(this).css('border-right-width')) || 0);
				}
				if($(this).css('border-left-style') != "none"){
					borderW = borderW + (parseInt($(this).css('border-left-width')) || 0);
				}
				$ColumnPropsMap[$(this).attr("field")] = $.extend({}, 
						$ColumnPropsMap[$(this).attr("field")], 
						{width: arrayWth[i], 
							unscaledWidth:arrayWth[i], 
							paddingWidth : paddingW,
							borderWidth : borderW});
			});
			//主数据区
			var fixedCols = thgrids.length;//固定区总列数
			thgrids =$BodyCols[0].find("th[field]");
			status = getGridWidth(thgrids);		//获取单元格参照状态对象				
			arrayWth = status.width;			//参照宽度数组				
			$.each(thgrids, function(i){
				var paddingW = parseInt($(this).css('padding-left')) || 0;
				paddingW = paddingW + parseInt($(this).css('padding-right')) || 0;
				var borderW = 0;
				if($(this).css('border-right-style') != "none"){
					borderW = borderW + (parseInt($(this).css('border-right-width')) || 0);
				}
				if($(this).css('border-left-style') != "none"){
					borderW = borderW + (parseInt($(this).css('border-left-width')) || 0);
				}
				$ColumnPropsMap[$(this).attr("field")] = $.extend({}, 
						$ColumnPropsMap[$(this).attr("field")], 
						{unscaledWidth: arrayWth[i], 
							paddingWidth : paddingW,
							borderWidth : borderW});
			});
		};

		/**
		 * 插入滚动条结构
		 * @ newadd 7th January 2013
		**/	
		/*		
		var insertScrollbar = function(scrollbarClass, scrollbarContent) {
			var fragment = document.createDocumentFragment(),
				scrollbar = document.createElement('div'),
				element = $Element[0],
				footer = $FooterPane[0],
				htmlStr = '<div class="' + scrollbarContent + '"></div>';

			scrollbar.className = scrollbarClass;
			scrollbar.style.visibility = 'hidden';
			scrollbar.style.left = -99999 + 'px';
			scrollbar.innerHTML = htmlStr;
			fragment.appendChild(scrollbar);
			element.insertBefore(fragment.cloneNode(true), footer);
		};
		*/
		var insertScrollbar = function(scrollbarClass, scrollbarContent) {
			var htmlStr = '<div class="' 
						+ scrollbarClass
						+ '" style="visibility:hidden; left:-99999px;">'
						+ '<div class="' 
						+ scrollbarContent 
						+ '"></div></div>',
				scrollbar = $(htmlStr);		
			$BodyPane.after(scrollbar);
		};

		/**
		 * 自适应尺寸调用的方法
		 * 计算右边主数据区各列的宽度，左边各个table外层div的高度==右边对应div的高度
		 * @ edit 7th January 2013
		**/
		var measureBodyUpdate = function() {			
			var bodyW = $Element.innerWidth() - $HeaderPane.outerWidth(),//右边数据区的宽度				
				left = $HeaderPane.outerWidth();

			//body的横向偏移量和宽度
			$BodyPane.css({"left" : left + 'px', "width" : bodyW + 'px'});	

			var scrollSize = $Options.scrollWidth,//滚动条的尺寸
				totalH = $Element.innerHeight(),//pane高度
				titleH = $($BodyCols[0]).outerHeight(),
				footerH = $($FooterPane).outerHeight(),
				summaryH = $BodyCols[2] ? $($BodyCols[2]).outerHeight() : 0,//summary height
				middleH = totalH - titleH - footerH - summaryH,//中间div的高度
				bodyTableH = $($BodyCols[1]).find("table").height(),//主数据表的高度
				tableClientW,//div内部table的可视宽度
				tableTotalWidth,//表格总宽度
				vScrollbarSize,
				scrollLeft, //存储滚动条的位置
				vScrollbar = $Element.find('.' + $Options.vScrollbarClass),	
				hScrollbar = $Element.find('.' + $Options.hScrollbarClass);
			
			//如果垂直滚动不存在，插入垂直滚动条，并且更新vScrollbar的元素集合列表
			if (!vScrollbar.length > 0) {		
				insertScrollbar($Options.vScrollbarClass, $Options.vScrollbarContentClass);
				vScrollbar = $Element.find('.' + $Options.vScrollbarClass);
			}	
			//如果水平滚动不存在，插入水平滚动条，并且更新hScrollbar的元素集合列表
			if (!hScrollbar.length > 0) {	
				insertScrollbar($Options.hScrollbarClass, $Options.hScrollbarContentClass);
				hScrollbar = $Element.find('.' + $Options.hScrollbarClass);
			}					
			//当主数据表的高度大于容器高度，显示垂直滚动条
			if( bodyTableH > middleH) {
				$VerticalScroll = true;
				//表格容器的宽度，用来遮罩滚动的部分
				tableClientW = bodyW - scrollSize;
				vScrollbarSize = scrollSize;
				//设置列宽
				tableTotalWidth = calculateBodyColumnsWidth(tableClientW);	
				//显示垂直滚动条
				//设置滚动条容器的状态
				vScrollbar.css({
					top: titleH + 'px',
					left: 'auto',
					right: 0,
					height: middleH + 'px',
					visibility: 'visible'
				});	
				//填充滚动条内容
				vScrollbar.children().css({
					height: bodyTableH + 'px',
					width: scrollSize + 'px'
				});	
			} else {
				$VerticalScroll = false;		
				vScrollbarSize = 0;		
				//设置table宽度=div宽度，设置列宽
				tableClientW = bodyW;
				tableTotalWidth = calculateBodyColumnsWidth(tableClientW);
				//移出垂直滚动条
				if (vScrollbar.length > 0) { 
					vScrollbar.css({
						 visibility: 'hidden',
						 left: -99999 + 'px'
					}); 
				}
			}	
			//当表格显示区域的宽度小于数据表格的实际宽度
			//显示水平滚动条，
			if (tableClientW < tableTotalWidth) {
				$HoriScroll = true;
				//当水平滚动条存在，重新设置垂直滚动条的高度
				middleH = middleH - scrollSize; 	
				vScrollbar.css('height', middleH + 'px');	 
				//显示水平滚动条
				//设置滚动条容器的状态
				hScrollbar.css({
					left: left + 'px',
					bottom: footerH + 'px',
					width: tableClientW + 'px',
					visibility: 'visible'
				});	
				//填充滚动条内容
				hScrollbar.children().css({
					width: tableTotalWidth + 'px',
					height: scrollSize + 'px'
				});	
				
				//如果滚动条位置存在属性存在
				//重新调整需要滚动的容器位置
				if (hScrollbar.data('scrollX')) {
					scrollLeft = hScrollbar.data('scrollX');
					$BodyCols[1].scrollLeft(scrollLeft);
					if ($BodyCols[2]) {
						$BodyCols[2].scrollLeft(scrollLeft);
					}
				}	
			} else {
				$HoriScroll = false;
				//移出水平滚动条
				if (hScrollbar.length > 0) { 					
					hScrollbar.css({
						 visibility: 'hidden',
						 left: -99999 + 'px'
					}); 
				}
			}

			try {
				//宽度设置
				//table上层的div的宽度
				var tableDivWidth = $VerticalScroll || $HoriScroll ? tableTotalWidth + scrollSize : tableTotalWidth;
				//$BodyPane.css({"width" : tableClientW + 'px'});	
				$($BodyCols[0]).css("width", tableClientW + "px");
				$($BodyCols[1]).parent().css("width", tableClientW + "px");
				$($BodyCols[1]).css("width", tableClientW + vScrollbarSize + "px");
				//$($BodyCols[1]).parent().parent().css("width", bodyW+"px");
				//$($BodyCols[1]).css("width", tableClientW + "px");
				//$($BodyCols[2]).css("width", tableClientW + "px");
				//table 宽度设置
				$($BodyCols[0]).children().css("width", tableTotalWidth+"px");
				$($BodyCols[1]).children().css("width", tableTotalWidth+"px");
				$($BodyCols[2]).children().css("width", tableTotalWidth+"px");
				processGrid($BodyCols);
				//高度设置
				$($HeaderPane).css("height", (totalH-footerH)+"px");
				$($HeaderCols[0]).css("height", titleH+"px");
				$HeaderCols[0].find("table").css("height", titleH+"px");
				$($BodyPane).css("height", (totalH-footerH)+"px");
				$($BodyCols[1]).css("height", middleH + "px");
				$($HeaderCols[1]).css("height", middleH + "px");
			} catch(e) {}				
		};

		/**
		* 自适应尺寸调用的方法
		* 计算右边主数据区各列的宽度，左边各个table外层div的高度==右边对应div的高度
		**/
		var measureBody = function(){
			var bodyW = $Element.innerWidth() - $HeaderPane.outerWidth();//右边数据区的宽度
			var scrollSize = $Options.scrollWidth;
			//body的横向偏移量和宽度
			$BodyPane.css({"left" : $HeaderPane.outerWidth() + 'px', "width" : bodyW + 'px'});
			//body
			var totalH = $Element.innerHeight();
			//计算中间可滚动区div的高度
			var titleH = $($BodyCols[0]).outerHeight();
			var footerH = $($FooterPane).outerHeight();
			var summaryH = $BodyCols[2] ? $($BodyCols[2]).outerHeight() : 0;
			var middleH = totalH - titleH - footerH - summaryH;//中间div的高度
			var tableClientW;//div内部table的可视宽度
			if($($BodyCols[1]).find("table").height() > middleH){
			//出现纵向滚动条
				$VerticalScroll = true;
				//调整table宽度=div.width - scrollwidth
				tableClientW = bodyW - scrollSize;
				//设置列宽
				var tableTotalWidth = calculateBodyColumnsWidth(tableClientW);
				var showHorScroll = tableClientW < tableTotalWidth;
				//判断是否出现横向滚动条，如果出现横向滚动条，调整中间div的高度（减去横滚高度）。
				if(showHorScroll){
					middleH = middleH - scrollSize;			
					$HoriScroll = true;
				}else{
					$HoriScroll = false;
				}
			}else{
				$VerticalScroll = false;
				//设置table宽度=div宽度，设置列宽
				tableClientW = bodyW;
				var tableTotalWidth = calculateBodyColumnsWidth(tableClientW);
				var showHorScroll = tableClientW < tableTotalWidth;
				//判断是否出现横向滚动条，如果出现横向滚动条，调整中间div的高度（减去横滚高度）。
				if(showHorScroll){
					$HoriScroll = true;
					//如果导致纵滚出现, 调整table宽度=div.width-scrollheight,以及列宽
					middleH = middleH - scrollSize;
					if($($BodyCols[1]).find("table").height() > middleH){
						$VerticalScroll = true;
						tableClientW = tableClientW - scrollSize;
						//重新计算列宽
						tableTotalWidth = calculateBodyColumnsWidth(tableClientW);
					}else{
						$VerticalScroll = false;
					}
				}else{
					$HoriScroll = false;
				}
			}
			try{
				//宽度设置
				//table上层的div的宽度
				var tableDivWidth = $VerticalScroll ? tableTotalWidth+scrollSize : tableTotalWidth;
				$($BodyCols[0]).css("width", tableDivWidth+"px");
				$($BodyCols[1]).parent().parent().css("width", bodyW+"px");
				$($BodyCols[1]).css("width", tableDivWidth+"px");
				$($BodyCols[2]).css("width", tableDivWidth+"px");
				//table 宽度设置
				$($BodyCols[0]).children().css("width", tableTotalWidth+"px");
				$($BodyCols[1]).children().css("width", tableTotalWidth+"px");
				$($BodyCols[2]).children().css("width", tableTotalWidth+"px");
				processGrid($BodyCols);
				//高度设置
				$($HeaderPane).css("height", (totalH-footerH)+"px");
				$($HeaderCols[0]).css("height", titleH+"px");
				$HeaderCols[0].find("table").css("height", titleH+"px");
				$($BodyPane).css("height", (totalH-footerH)+"px");
				$($BodyCols[1]).css("height", middleH+"px");
				$($HeaderCols[1]).css("height", middleH+"px");
			}catch(e){}
		};
		
		var totalTableBodyWidth = function(){
			var tableWidth = 0;
			var thgrids = getThGrids($BodyCols);
			for(var i=0, len=thgrids.length; i< len; i++){
				var fieldName = $(thgrids[i]).attr("field");
				if($ColumnPropsMap[fieldName].hidden===false){
					tableWidth += $ColumnPropsMap[fieldName].width || $ColumnPropsMap[fieldName].unscaledWidth || $Options.colMinWidth;
				}
			}
			return tableWidth;
		}
		/**
		 * 不需要做自适应调用的方法。
		 * 计算并设置table外出div的尺寸
		 */
		var measureContainerSize = function(){
			var bodyW = $Element.innerWidth() - $HeaderPane.outerWidth();//右边数据区的宽度
			var scrollSize = $Options.scrollWidth;
			//body的横向偏移量和宽度
			$BodyPane.css({"left" : $HeaderPane.outerWidth() + 'px', "width" : bodyW + 'px'});
			//body
			var totalH = $Element.innerHeight();
			//计算中间可滚动区div的高度
			var titleH = $($BodyCols[0]).outerHeight();
			var footerH = $($FooterPane).outerHeight();
			var summaryH = $BodyCols[2] ? $($BodyCols[2]).outerHeight() : 0;
			var middleH = totalH - titleH - footerH - summaryH;//中间div的高度
			var tableClientW;//div内部table的可视宽度
			if($($BodyCols[1]).find("table").height() > middleH){
			//出现纵向滚动条
				$VerticalScroll = true;
				//调整table宽度=div.width - scrollwidth
				tableClientW = bodyW - scrollSize;
				//设置列宽
				var tableTotalWidth = totalTableBodyWidth();//?????????????==========
				var showHorScroll = tableClientW < tableTotalWidth;
				//判断是否出现横向滚动条，如果出现横向滚动条，调整中间div的高度（减去横滚高度）。
				if(showHorScroll){
					middleH = middleH - scrollSize;
					$HoriScroll = true;
				}else{
					$HoriScroll = false;
				}
			}else{
				$VerticalScroll = false,
				//设置table宽度=div宽度，设置列宽
				tableClientW = bodyW;
				var tableTotalWidth = totalTableBodyWidth();//?????????????==========
				var showHorScroll = tableClientW < tableTotalWidth;
				//判断是否出现横向滚动条，如果出现横向滚动条，调整中间div的高度（减去横滚高度）。
				if(showHorScroll){
					$HoriScroll = true;
					//如果导致纵滚出现, 调整table宽度=div.width-scrollheight,以及列宽
					middleH = middleH - scrollSize;
					if($($BodyCols[1]).find("table").height() > middleH){
						$VerticalScroll = true;
						tableClientW = tableClientW - scrollSize;
					}else{
						$VerticalScroll = false;
					}
				}else{
					$HoriScroll = false;
				}
			}
			try{
				//宽度设置
				//table上层的div的宽度
				var tableDivWidth = $VerticalScroll ? Math.max(tableTotalWidth+scrollSize, bodyW) : Math.max(tableTotalWidth, bodyW);
				$($BodyCols[0]).css("width", tableDivWidth+"px");
				$($BodyCols[1]).parent().parent().css("width", bodyW+"px");
				$($BodyCols[1]).css("width", tableDivWidth+"px");
				$($BodyCols[2]).css("width", tableDivWidth+"px");
				//table 宽度设置
				$($BodyCols[0]).children().css("width", tableTotalWidth+"px");
				$($BodyCols[1]).children().css("width", tableTotalWidth+"px");
				$($BodyCols[2]).children().css("width", tableTotalWidth+"px");
				//高度设置
				$($HeaderPane).css("height", (totalH-footerH)+"px");
				$($HeaderCols[0]).css("height", titleH+"px");
				$HeaderCols[0].find("table").css("height", titleH+"px");
				$($BodyPane).css("height", (totalH-footerH)+"px");
				$($BodyCols[1]).css("height", middleH+"px");
				$($HeaderCols[1]).css("height", middleH+"px");
			}catch(e){}
		};
		
		var updateSize = function(){
//			window.console.log("update size "+$Element.parent().attr("id"));
			if($Options.sizeAdaptable){//尺寸自适应，设置各个单元格div的宽度，table及外出div的尺寸
				//fix width
				processGrid($HeaderCols);
				measureBodyUpdate();
			}else{
				measureContainerSize();
			}
		};
		
		/**
		*计算表格宽高，列宽，中间区域div的高度，滚动条
		**/
		var measureSize = function(){
			initSize();
			updateSize();
		};
		var resetHeight = function(){
			var scrollSize = $Options.scrollWidth;
			var totalH = $Element.innerHeight();
			//计算中间可滚动区div的高度
			var titleH = $($BodyCols[0]).outerHeight();
			var footerH = $($FooterPane).outerHeight();
			var summaryH = $BodyCols[2] ? $($BodyCols[2]).outerHeight() : 0;
			var middleH = totalH - titleH - footerH - summaryH;//中间div的高度
			//重设表格外框（除掉footer的区域）的高度
			$($HeaderPane).css("height", (totalH-footerH)+"px");
			$($BodyPane).css("height", (totalH-footerH)+"px");
			if($HoriScroll){
				middleH = middleH - scrollSize;
			}
			if($VerticalScroll){//原本有纵向滚动条
				if($($BodyCols[1]).find("table").height() <= middleH){
					//纵向滚动条需要消失
					$VerticalScroll = false;
					//重设表格外部div的宽度
					var bodyW = $Element.innerWidth() - $HeaderPane.outerWidth();//右边数据区的宽度
					var tableTotalWidth = calculateBodyColumnsWidth(bodyW);
					try{
						//table外围div的宽度设置
						$($BodyCols[0]).css("width", tableTotalWidth+"px");
						$($BodyCols[1]).parent().parent().css("width", bodyW+"px");
						$($BodyCols[1]).css("width", tableTotalWidth+"px");
						//table宽度设置
						$($BodyCols[0]).children().css("width", tableTotalWidth+"px");
						$($BodyCols[1]).children().css("width", tableTotalWidth+"px");
						$($BodyCols[2]).children().css("width", tableTotalWidth+"px");
						var showHorScroll = bodyW < tableTotalWidth;
						if($HoriScroll){//横滚本来就存在
							//判断是否需要出现横向滚动条
							if(!showHorScroll){
								//横滚消失, 滚动条高度加到div的高度上
								$HoriScroll = false;
								middleH = middleH + scrollSize;
							}
						}	
						processGrid($BodyCols);	
					}catch(e){}
				}
			}else{//原本没有纵向滚动条
				if($($BodyCols[1]).find("table").height() > middleH){
					//需要出现纵滚
					$VerticalScroll = true;
					var bodyW = $Element.innerWidth() - $HeaderPane.outerWidth() - scrollSize;//右边数据区的宽度
					var tableTotalWidth = calculateBodyColumnsWidth(bodyW);
					try{
						//table外围div的宽度设置
						$($BodyCols[0]).css("width", tableTotalWidth+scrollSize+"px");
						$($BodyCols[1]).parent().parent().css("width", (bodyW+scrollSize)+"px");
						$($BodyCols[1]).css("width", tableTotalWidth+scrollSize+"px");
						//table宽度设置
						$($BodyCols[0]).children().css("width", tableTotalWidth+"px");
						$($BodyCols[1]).children().css("width", tableTotalWidth+"px");
						$($BodyCols[2]).children().css("width", tableTotalWidth+"px");
						processGrid($BodyCols);	
					}catch(e){}
				}
			}
			$($BodyCols[1]).css("height", middleH+"px");
			$($HeaderCols[1]).css("height", middleH+"px");
		};		
	
		//初始化
		var init = function() {				
			if(!$Options.colDefine){
				$Options.colDefine = buildColDefine();
			}
			$Element.css("height", $Options.height || parseInt($Element.css("height")) || $Options.defaultHeight);
			initProps();
			create();
			setRowIndexAttr();			//设置行索引
			rowBgcolor(getAllRows(1));
			measureSize();
			var fixedCol = $Options.colDefine.fixedColumns;
			var normalCol = $Options.colDefine.columns;
			$FixedColumns = new Array();
			$NormalColumns = new Array();	
			for(var i=0; i<fixedCol.length;i++){
				if(fixedCol[i].type == columnTypeConstant.DATA_COLUMN){
					$FixedColumns.push(fixedCol[i]);
				}
			}
			for(var i=0; i<normalCol.length;i++){
				if(normalCol[i].type == columnTypeConstant.DATA_COLUMN){
					$NormalColumns.push(normalCol[i]);
				}
			}
			//绑定事件
			bindEvents();
		};// end
		/**
		*为没有定义列信息的表格生成列的定义
		**/
		var buildColDefine = function(){
			var define = {fixedColumns:[], columns:[]};
			$($HeaderCols[0]).find("th,td").each(function(){
				if($(this).attr("field")){
					var type;
					if($(this).attr("colType")){
						type=$(this).attr("colType");
					}else{
						type = $(this).attr("field")==="ck" ? columnTypeConstant.CHECKBOX_COLUMN : 
							$(this).attr("field")==="rowNumber" ? columnTypeConstant.ROW_NUMBER_COLUMN:
							$(this).attr("field")==="subgrid" ? columnTypeConstant.SUBGRID_ICON_COLUMN: 
							columnTypeConstant.DATA_COLUMN;
					}
					var tempConfig = $.extend({}, columnConfig, {type: type, field: $(this).attr("field")});
					if(type != columnTypeConstant.CHECKBOX_COLUMN || type != columnTypeConstant.ROW_NUMBER_COLUMN || type != columnTypeConstant.SUBGRID_ICON_COLUMN){
						var sortable = $(this).find("span.sort")[0];
						tempConfig.children = [$.extend({}, fieldConfig, {name : $(this).attr("field"), sortable: sortable})];
					}
					if(type==columnTypeConstant.GROUP_COLUMN){
						tempConfig.children[0]["depth"]=$(this).attr("depth");
					}
					if($(this).attr("isRowIndexField")=="true"){
						tempConfig.children[0]["isRowIndexField"]=true;
					}
					if($(this).attr("isPrimaryKey")=="true"){
						tempConfig.children[0]["isPrimaryKey"]=true;
					}
					
					if($(this).is(":hidden")){//根据表头的显示隐藏属性来控制整个列的显隐
						tempConfig["hidden"] = true;
					}
					define.fixedColumns.push(tempConfig);
				}
			});
			$($BodyCols[0]).find("th,td").each(function(){
				if($(this).attr("field")){
					var tempConfig = $.extend({}, columnConfig, {field: $(this).attr("field")});
					var sortable = $(this).find("span.sort")[0];
					tempConfig.children = [$.extend({}, fieldConfig, {name : $(this).attr("field"), sortable: sortable})];
					if($(this).attr("colType") && $(this).attr("colType")==columnTypeConstant.GROUP_COLUMN){
						tempConfig.type= columnTypeConstant.GROUP_COLUMN;
						tempConfig.children[0]["depth"]=$(this).attr("depth");
					}
					if($(this).attr("isRowIndexField")=="true"){
						tempConfig.children[0]["isRowIndexField"]=true;
					}
					if($(this).attr("isPrimaryKey")=="true"){
						tempConfig.children[0]["isPrimaryKey"]=true;
					}
					if($(this).is(":hidden")){//根据表头的显示隐藏属性来控制整个列的显隐
						tempConfig["hidden"] = true;
					}
					define.columns.push(tempConfig);
				}
			});
			return define;
		};
		
		/**
		 * 初始化$ColumnPropsMap，$GroupField, $IndexField, $PrimaryFields
		 * $ColumnPropsMap：根据表格列定义生成类似map结构的一个列定义对象。{field: {define：columnDef, hidden: false,...}, ...}
		 * $GroupField：组合分组属性。{depth:fieldName,...}
		 * $IndexField：序号列，业务特殊要求
		 * $PrimaryFields：主键列数组，业务特殊要求
		 */
		var initProps = function(){
			if($Element.attr("self_adapting")=="false"){
				$Options.sizeAdaptable = false;
			}
			if($Element.attr("single_selection")=="true"){
				$Options.singleSelection = true;
			}
			
			var headerSortResult = sortComplexTableHeader();
			for(var i=0, len=$Options.colDefine.fixedColumns.length; i<len;i++){
				var colProp = $Options.colDefine.fixedColumns[i];
				$ColumnPropsMap[colProp["field"]] = {define: colProp, hidden: colProp["hidden"], colIndex: headerSortResult[colProp["field"]]["index"], title:headerSortResult[colProp["field"]]["title"], isFixed:true};
				if(colProp["type"]==columnTypeConstant.GROUP_COLUMN){
					var obj={};
					obj[colProp["children"][0]["depth"]] = {groupField:colProp["field"], groupName:colProp["children"][0]["name"]};
					$.extend($GroupProps, obj);
				}else if(colProp["type"]==columnTypeConstant.CHECKBOX_COLUMN){//选中checkbox列
					$ChkField = colProp["field"];
				}else if(colProp["type"]==columnTypeConstant.ROW_NUMBER_COLUMN){//自然序号列
					$NumberField = colProp["field"];
				}else if(colProp["type"]==columnTypeConstant.SUBGRID_ICON_COLUMN){
					$SubgridField = colProp["field"];
				}
				if(colProp["children"] && colProp["children"][0]["isPrimaryKey"]){
					$PrimaryFields.push(colProp["field"]);
				}
				if(colProp["children"] && colProp["children"][0]["pageStatType"]){
					$StatsField.push(colProp["field"]);
				}
				if(colProp["children"] && colProp["children"][0]["isRowIndexField"]){
					$IndexField = colProp["field"];
					$IndexName = colProp["children"][0]["name"];
				}
			}
			for(var i=0, len=$Options.colDefine.columns.length; i<len;i++){
				var colProp = $Options.colDefine.columns[i];
				$ColumnPropsMap[colProp["field"]] = {define: colProp, hidden: colProp["hidden"], colIndex: headerSortResult[colProp["field"]]["index"], title:headerSortResult[colProp["field"]]["title"], isFixed:false};
				if(colProp["type"]==columnTypeConstant.GROUP_COLUMN){
					var obj={};
					obj[colProp["children"][0]["depth"]] = {groupField:colProp["field"], groupName:colProp["children"][0]["name"]};
					$.extend($GroupProps, obj);
				}else if(colProp["type"]==columnTypeConstant.CHECKBOX_COLUMN){//选中checkbox列
					$ChkField = colProp["field"];
				}else if(colProp["type"]==columnTypeConstant.ROW_NUMBER_COLUMN){//自然序号列
					$NumberField = colProp["field"];
				}else if(colProp["type"]==columnTypeConstant.SUBGRID_ICON_COLUMN){
					$SubgridField = colProp["field"];
				}
				if(colProp["children"] && colProp["children"][0]["isPrimaryKey"]){
					$PrimaryFields.push(colProp["field"]);
				}
				if(colProp["children"] && colProp["children"][0]["pageStatType"]){
					$StatsField.push(colProp["field"]);
				}
				if(colProp["children"] && colProp["children"][0]["isRowIndexField"]){
					$IndexField = colProp["field"];
					$IndexName = colProp["children"][0]["name"];
				}
			}
		};
		
		/**
		* 
		* 将表头的最后一行的单元格（位于最后一行或者是合并到最后一行的单元格）按照从左到右的顺序排序
		* 返回obj{field:colindex,...}
		**/
	  	var sortComplexTableHeader = function(){//sortComplexTableHeader
			var result1 = [],//fixed column
				result2 = [], // normal column
				fixedHeaderRows = $($HeaderCols[0]).find("table:first").find("tr").clone(),
				normalHeaderRows = $($BodyCols[0]).find("table:first").find("tr").clone();
			try{	
				while($(fixedHeaderRows[0]).children().length>0){
					sortRow(fixedHeaderRows, 0, result1);
				}
			}catch(e){
			}
			try{	
				while($(normalHeaderRows[0]).children().length>0){
					sortRow(normalHeaderRows, 0, result2);
				}
			}catch(e){
			}
			var obj={}, 
				len1=result1.length, 
				len2=result2.length;
			for(var i=0;i<len1;i++){
				obj[result1[i]["field"]] = {index:i, title:result1[i]["title"]};
			}
			for(var i=0; i<len2;i++){
				obj[result2[i]["field"]] = {index:i+len1, title:result2[i]["title"]};
			}
			return obj;
		};
		
		/** 
		* rows: tr数组
		* currRowIndex: 当前处理的单元格所在行在rows的序号
		* result: 结果集
		**/
		var sortRow = function(rows,currRowIndex,result){
			var oldLen = result.length;
			var currTd = $(rows[currRowIndex]).children()[0];
			while(!currTd && $(rows[currRowIndex+1])){
				currRowIndex++;
				currTd = $(rows[currRowIndex]).children()[0];
			}
			if(!currTd){
				return;
			}
			var totalRowCount = rows.length, colSpan=currTd.colSpan;
			if(currTd.rowSpan+currRowIndex<totalRowCount){
				$(currTd).remove();
				sortRow(rows, currRowIndex+1, result);
				if(oldLen+colSpan > result.length){
					do{
						sortRow(rows.slice(1), currRowIndex, result);
					}while(oldLen+colSpan > result.length);
				}
			}else{
				result.push({field:$(currTd).attr("field"), title:$(currTd).children("div").attr("title")});//{fieldName,title}
				$(currTd).remove();
				return;
			}
		};
		
		/**
		*获取field==currColField列的前一个可视列的属性集
		**/
		var getPrevVisibleColProps = function(currColField){
			var currentIndex = $ColumnPropsMap[currColField]["colIndex"];
			var prev = getFieldPropsByIndex(currentIndex-1);
			if(!prev){
				return null;
			}
			if(!prev.fieldProp.hidden){
				return prev.fieldProp;
			}else{
				return getPrevVisibleColProps(prev.fieldName);
			}
		};
		/**
		*获取field==currColField列的后一个可视列的属性集
		**/
		var getNextVisibleColProps = function(currColField){
			var currentIndex = $ColumnPropsMap[currColField]["colIndex"];
			var next = getFieldPropsByIndex(currentIndex+1);
			if(!next){
				return null;
			}
			if(!next.fieldProp.hidden){
				return next.fieldProp;
			}else{
				return getNextVisibleColProps(next.fieldName);
			}
		};
		/**
		*通过colindex获取列的属性集
		**/
		var getFieldPropsByIndex = function(colIndex){
			if(colIndex>=0){
				for(var field in $ColumnPropsMap){
					if($ColumnPropsMap[field]["colIndex"] === colIndex){
						return {fieldName: field, fieldProp: $ColumnPropsMap[field]};
					}
				}
			}
			return null;
		};
		
		/**
		 * 反序列化一个字段
		 * @fieldDom：序列化和反序列化作用的dom节点
		 * @value: 新值
		 */
		var deserializeField = function(fieldDom, value){
			if($(fieldDom).is("span")){//文本标签
				$(fieldDom).html(value);
			}else if($(fieldDom).is(":checkbox[isBoolean='true']")){//是非复选框表单标签
				if(value == $(fieldDom).attr("checkedValue")){
					$(fieldDom).attr("checked", "checked");
				}else{
					$(fieldDom).removeAttr("checked"); 
				}
			}else{//其他普通表单标签
				$(fieldDom).val(value);
			}
		};
		
		/**
		 * 反序列化一行
		 * @fixedRow：行的左边固定区的tr dom
		 * @normalRow: 行的右边数据区的tr dom
		 * @data：新的行数据
		 * @ignoreNull：true:对空值的字段不做反序列化
		 */
		var deserializeRow = function(fixedRow, normalRow, data, ignoreNull){
			for(var i in data){
				if(!ignoreNull || (ignoreNull && (!data[i] || data[i]!=""))){
					$(normalRow).find("[name='"+i+"']").each(function(){
						deserializeField(this, data[i]);
						$(this).trigger("change");
					});
					$(fixedRow).find("[name='"+i+"']").each(function(){
						deserializeField(this, data[i]);
						$(this).trigger("change");
					});
				}
			}
		};
		
		/**
		*更新指定行的行数据
		**/
		var updateRowData = function(rowIndex, data, ignoreNull){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			if(!normalRow || normalRow.length==0){//rowindex行不存在
				return;
			}
			deserializeRow(fixedRow, normalRow, data, ignoreNull);
		};
		
		/**
		 * 设置单元格cell内控件的可用性
		 */
		var setTableCellEnable = function(cell, enable){
			$(cell).find("input, select, textarea").attr("disabled", !enable);
		};

/**
*=======================public Datagrid实例可以调用的方法=====================================
**/		
		/**
		*删除选中状态的所有行
		**/
		this.deleteSelectedRows = function(){
			var rows = getSelectedRows();
			$.each(rows, function(i, row){
				//删除子表行
				cacheDeletedRow($(row.fixed).attr($Options.rownumberIndex));
				if($(row.fixed).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW && $Options.isSubgrid){
					$(row.fixed).next().remove();
					$(row.data).next().remove();
				}
				$(row.fixed).remove();
				$(row.data).remove();
			});
			if(rows.length>0){
				$Element.trigger("deleteRowEvent");
			}
			resetStyle();
			//resetHeight();
			measureBodyUpdate();
		};
		/**
		*删除指定行
		**/
		this.deleteRow = function(rowIndex){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			//删除子表行
			cacheDeletedRow(rowIndex);
			if($(fixedRow).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW && $Options.isSubgrid){
				$(fixedRow).next().remove();
				$(normalRow).next().remove();
			}
			if(fixedRow){
				$(fixedRow).remove();
			}
			if(normalRow){
				$(normalRow).remove();
				$Element.trigger("deleteRowEvent");
			}
			
			resetStyle();
			//resetHeight();
			measureBodyUpdate();

		};
		/**
		* 删除满足条件的行
		* @data:过滤刷选的条件{key:value, ...}
		**/
		this.deleteRowByData = function(data){
			var rows = filterData(data);
			$.each(rows, function(i, row){
				//删除子表行
				cacheDeletedRow($(row.fixed).attr($Options.rownumberIndex));
				if($(row.fixed).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW && $Options.isSubgrid){
					$(row.fixed).next().remove();
					$(row.body).next().remove();
				}
				$(row.fixed).remove();
				$(row.body).remove();
			});
			if(rows.length>0){
				$Element.trigger("deleteRowEvent");
			}
			resetStyle();
			//resetHeight();
			measureBodyUpdate();
		};
		
		/**
		 * 选中/取消选中包含数据data的行
		 * @data {key1:value1, key2:value2, ...}。用于筛选行的数据
		 * @select true/false, true:选中包含数据data的行，false:取消选中
		 */
		this.selectRowByData = function(data, select){
			var rows = filterData(data);
			if($Options.singleSelection){//单选模式只取第一个
				rows = [rows[0]];
			}
			
			$.each(rows, function(i, row){
				selectRow(row.rowIndex, select);
			});
		};
		/**
		* 上移选中行
		**/
		this.upSelectedRows = function(){
			var rows = getSelectedRows();
			for(var i=0,len=rows.length;i<len;i++){
				var prev = $(rows[i].fixed).prev();
				if(prev[0] && $(prev).attr("rowType")===rowTypeConstant.SUBGRID_ROW){
				//上一行是subgrid行,取上上一行
					prev = $(prev[0]).prev();
				}
				var prevIndex = $(prev).attr($Options.rownumberIndex),
					subRowIndex = null;
				if($(rows[i].fixed).next() && $(rows[i].fixed).next().attr("rowType")===rowTypeConstant.SUBGRID_ROW){
					subRowIndex = $(rows[i].fixed).next().attr($Options.rownumberIndex);
				}
				if(prev[0] 
					&& $(prev).find("td[field='"+$ChkField+"']").find(":checkbox").attr("checked")!="checked"){
					$(prev).before($(rows[i].fixed));
					getNormalRow(prevIndex).before($(rows[i].data));
					if(subRowIndex){
						$(prev).before(getFixedRow(subRowIndex));
						getNormalRow(prevIndex).before(getNormalRow(subRowIndex));
					}
				}
			}   
			resetStyle();
		};
		/**
		* 下移选中行
		**/
		this.downSelectedRows = function(){
			var rows = getSelectedRows();
			for(var i=rows.length-1; i >=0; i--){
				var next = $(rows[i].fixed).next(), 
					currSubRowIndex = null;
				//当前行的下一行是subgrid行，则需要将当前行和subgrid行同时往下移动
				if(next[0] && $(next).attr("rowType")===rowTypeConstant.SUBGRID_ROW){
					currSubRowIndex = $(next).attr($Options.rownumberIndex);
					next = $(next).next();
					var temp = $(next).next();
					if(temp[0] && $(temp).attr("rowType")===rowTypeConstant.SUBGRID_ROW){
						next = temp;
					}
				}
				var nextIndex = $(next).attr($Options.rownumberIndex);
				
				if(next[0] 
					&& $(next).find("td[field='"+$ChkField+"']").find(":checkbox").attr("checked")!="checked"){
					if(currSubRowIndex){
						$(next).after(getFixedRow(currSubRowIndex));
						getNormalRow(nextIndex).after(getNormalRow(currSubRowIndex));
					}
					$(next).after($(rows[i].fixed));
					getNormalRow(nextIndex).after($(rows[i].data));
				}
			}
			resetStyle();
		};
		this.getAddedRowsData = function(){
			var result = new Array();
			for(var index in $AddedRows){
				var fixed = getFixedRow(index);
				var normal = getNormalRow(index);
				var rowData = $.extend({}, serializeTableRow(normal), serializeTableRow(fixed));
				var i = $(fixed).index()+1;
				result.push({index:i, data: rowData});
			}
			//对行数据按照该行（tr）在table中的序号做排序
			result.sort(function(a,b){
				return a.index>b.index ? 1 : -1;
			});
			var dataArray = [];
			if($IndexField){
				for(var i=0,len=result.length;i<len;i++){
					result[i].data[$IndexField]=result[i].index;
					dataArray.push(result[i].data);
				}
			}else{
				for(var i=0,len=result.length;i<len;i++){
					dataArray.push(result[i].data);
				}
			}
			return dataArray;
		};
		/**
		 * 获取修改行整行数据
		 */
		this.getUpdatedRowsAllData = function(){
			var result = new Array();
			for(var rowIndex in $UpdatedRows){
				var fixedRow = getFixedRow(rowIndex);
				var normalRow = getNormalRow(rowIndex);
				var obj = $.extend({}, serializeTableRow(normalRow), serializeTableRow(fixedRow));
				result.push($.extend({}, obj, $UpdatedRows[rowIndex]));
			}
			return result;
		};
		/**
		 * 只返回行中被修改的数据
		 */
		this.getUpdatedRowsData = function(){
			if(!$PrimaryFields || $PrimaryFields.length==0 || !$IndexField){//没有主键字段或者没有行号字段
				return this.getUpdatedRowsAllData();
			}else{
				var result = new Array();
				//表格内全局比对行号，把行号前后不一致的加入到修改数据数组中
				var fixedRows = $HeaderCols[1].find("table").find("tr"),
					normalRows = $BodyCols[1].find("table").find("tr");
				//自然行序号所在的tr的数组
				var numberFieldContainer = $ColumnPropsMap[$NumberField]["isFixed"] ? fixedRows : normalRows,
					//数据库行号所在tr的数组
					rowIndexContainer = $ColumnPropsMap[$IndexField]["isFixed"] ? fixedRows : normalRows;
				var fixedPrimaryFields = [], normalPrimaryFields = [];
				for(var i=0,len=$PrimaryFields.length;i<len;i++){
					if($ColumnPropsMap[$PrimaryFields[i]]["isFixed"]){
						fixedPrimaryFields.push($PrimaryFields[i]);
					}else{
						normalPrimaryFields.push($PrimaryFields[i]);
					}
				}
				//遍历表格所有行
				for(var i=0,len=numberFieldContainer.length;i<len;i++){
					//自然行号
					var number = $(numberFieldContainer[i]).find("td[field='"+$NumberField+"']").children("div").html();
					//数据库行号
					var index = serializeTableCell($(rowIndexContainer[i]).find("td[field='"+$IndexField+"']"))[$IndexName];
					//绑定在tr的tablerowIndex属性值，唯一标示一行的属性
					var tableRowIndex = $(numberFieldContainer[i]).attr($Options.rownumberIndex);
					if(index && index!="" && number!=index){//index==""代表是新增行
						//行号被修改
						var data = {};
						data[$IndexName] = number;
							$.extend(data, 
								serializeAssignedField(fixedRows[i], fixedPrimaryFields), 
								serializeAssignedField(normalRows[i], normalPrimaryFields));
						if($UpdatedRows[tableRowIndex]){//该行有数据被修改
							$.extend(data, $UpdatedRows[tableRowIndex]);
						}
						result.push(data);
					}else if($UpdatedRows[tableRowIndex]){//该行有数据被修改
						result.push($.extend($UpdatedRows[tableRowIndex], 
								serializeAssignedField(fixedRows[i], fixedPrimaryFields), 
								serializeAssignedField(normalRows[i], normalPrimaryFields)));
					}
				}
				return result;
			}
			
		};

		this.getDeleteRows = function(){
			var result = new Array();
			for(var index in $DeletedRows){
				result.push($DeletedRows[index]);
			}
			return result;
		};
		
		/**
		*获得选中行数据
		**/
		this.getSelectedRowsData = function(){
			var rows = getSelectedRows();
			var result = [];
			$.each(rows, function(i, row){
				result.push($.extend({}, serializeTableRow(row.fixed), serializeTableRow(row.data)));
			});
			return result;
		};
		/**
		* 在表格末尾新增行
		* @data :[{"itemid1" : "label1", "itemid2" : "label2","itemid3" : "value2"},{...},...]
		* @isInit: true/false, true:添加的行作为表格的初始数据，不作为新增行数据处理
		**/
		this.appendRow = function(data, isInit){
			var startIndex = $RowIndex==-1 ? 0 : $RowIndex+1;
			if($.isArray(data)){//参数是数组
				for(var i=0; i<data.length; i++){
					addRow(data[i]);
				}
				i=null;
			}else{//参数是对象
				addRow(data);
			}
			resetStyle();
			//resetHeight();
			measureBodyUpdate();
			if(!isInit){
				var endIndex = $RowIndex;
				for(var i = startIndex; i<= endIndex; i++){
					$AddedRows[i]={};
				}
				i=null;
			}
		};
		this.prependRow = function(data, isInit){
			var startIndex = $RowIndex==-1 ? 0 : $RowIndex+1;
			if($.isArray(data)){//参数是数组
				for(var i=data.length-1; i >=0; i--){
					addRow(data[i], 0);
				}
			}else{//参数是对象
				addRow(data, 0);
			}
			resetStyle();
			//resetHeight();
			measureBodyUpdate();
			if(!isInit){
				var endIndex = $RowIndex;
				for(var i = startIndex; i<= endIndex; i++){
					$AddedRows[i]={};
				}
			}
		};
		//在指定位置新增一行
		this.insertRow = function(data, rowIndex, isInit){
			var startIndex = $RowIndex==-1 ? 0 : $RowIndex+1;
			if($.isArray(data)){//参数是数组
				for(var i=data.length-1; i >=0; i--){
					addRow(data[i], rowIndex);
				}
			}else{//参数是对象
				addRow(data, rowIndex);
			}
			resetStyle();
			//resetHeight();
			measureBodyUpdate();
			if(!isInit){
				var endIndex = $RowIndex;
				for(var i = startIndex; i<= endIndex; i++){
					$AddedRows[i]={};//缓存新增行的rowIndex
				}
			}
		};
		/*序列化表格。行数据带出了行序号。不建议用此方法获得的数据与后台做交互*/
		this.serialize = function(){
			var result = new Array();
			var fixedRow = $HeaderCols[1].find("tbody").children("tr");
			var dataRow = $BodyCols[1].find("tbody").children("tr");
			var i = 0;
			var len = dataRow.length;
			while(i<len){
				result.push($.extend({tablerowindex: $(dataRow[i]).attr($Options.rownumberIndex)}, serializeTableRow(dataRow[i]), serializeTableRow(fixedRow[i])));
				i = i+1;
			}
			delete i;
			return result;
		};
		
		/**
		 * @param name: 字段名
		 * @returns 返回一个数组
		 */
		this.getColumnData = function(fieldName){
			var trArray, result=[];
			if($ColumnPropsMap[fieldName]["colIndex"] < $Options.colDefine.fixedColumns.length){
				//该列在固定区
				trArray = $HeaderCols[1].find("tbody").children("tr");
			}else{
				trArray = $BodyCols[1].find("tbody").children("tr");
			}
			var index = $(trArray[0]).find("td[field='"+fieldName+"']").index();
			for(var i=0,len=trArray.length; i<len; i++){
				var obj = serializeTableCell($(trArray[i]).children().eq(index));
				if(obj[fieldName]){
					result.push(obj[fieldName]);
				}
			}
			return result;
		};
		
		/**
		*获得当前表格的数据行数
		**/
		this.getRowCount = function(){
			return $HeaderCols[1].find("tbody").children("tr").length;
		};
		
		/**
		*清空数据
		**/
		this.clear = function(){
			$HeaderCols[1].find("table").children().remove();
			$BodyCols[1].find("table").children().remove();
			$RowIndex=-1;
			$AddedRows = new Object(),//{rowindex:{"name1":"value1", ...}, ...}
			$UpdatedRows = new Object(), //{rowIndex:{"name1":"value1", ...}, ...}
			$DeletedRows = new Object();//{rowIndex:{"name1":"value1", ...}, ...}
		}
		
		this.resize = function(){
			updateSize();
		}
		
		this.setWidth = function(w){
			$($BodyPane).css("width", w - $HeaderPane.width()+"px");
			updateSize();
		}
		this.setHeight = function(h){
			$Element.css("height", h+"px");
			updateSize();
		}
		this.setSize = function(w, h){
			$($BodyPane).css("width", w - $HeaderPane.width()+"px");
			$Element.css("height", h+"px");
			updateSize();
		}
		/**
		*返回获得焦点的行号
		**/
		this.getFocusRowIndex = function(){
			return $FocusRowIndex;
		};
		/**
		* 反序列化指定的行数据，指定行号和行数据
		* @rowIndex 行号
		* @dataArray 行数据数组
		* @ignoreNull 可选参数。true:对null和""值不做反序列化。
		**/
		this.deserializeRows = function(rowIndex, dataArray, ignoreNull){
			updateRowData(rowIndex, dataArray[0], ignoreNull);
			var index = getFixedRow(rowIndex).index(), indexArray=new Array();
			indexArray.push(rowIndex);
			if(dataArray.length>1){
				var oldIndex = $RowIndex;
				this.insertRow(dataArray.slice(1), index+1);
				for(var i=oldIndex+1;i<=$RowIndex;i++){
					indexArray.push(indexArray);
				}
			}
			$Element.trigger("deserializeRowsEvent",[{rowIndexs: indexArray}]);
		};
		/**
		*获得第一行（可视）的数据
		**/
		this.getFirstRowData = function(){
			return $.extend({}, serializeTableRow($($HeaderCols[1]).find("tr:visible:first")), serializeTableRow($($BodyCols[1]).find("tr:visible:first")));
		};
		
		/**
		 * 获取指定行号的行数据。
		 * @rowIndex: 该行号是作为tr的tableRowIndex属性值，唯一标识一行。与表格前面显示的行号不同
		 */
		this.getRowData = function(rowIndex){
			var fixedRow = getFixedRow(rowIndex);
			var normalRow = getNormalRow(rowIndex);
			return $.extend({}, serializeTableRow(fixedRow), serializeTableRow(normalRow));
		};
		
		/**
		 * 获取最后被修改过的行的行号
		 */
		this.getChangeRowIndex = function(){
			return $UpdatedRowIndex;
		};
		
		/**
		 * 获取指定行号的DOM。是个数组[左边tr,右边tr]
		 * @rowIndex: 该行号是作为tr的tableRowIndex属性值，唯一标识一行。与表格前面显示的行号不同
		 */
		this.getRowDom = function(rowIndex){
			return [getFixedRow(rowIndex)[0], getNormalRow(rowIndex)[0]];
		};
		/**
		 * 按条件更新行数据
		 * @cond 匹配行的条件{fieldname:value,...}
		 * @data 行数据{fieldname:value,...}
		 */
		this.updateRowsDataByCond = function(cond, data){
			var rows = filterData(cond);
			$.each(rows, function(i, row){
				deserializeRow(row.fixed, row.body, data);
			});
		};
		
		/**
		 * 获取新增行的行序号数组
		 */
		this.getAddedRowsIndex = function(){
			var result = new Array();
			for(var i in $AddedRows){
				result.push(i);
			}
			return result;
		};
		
		/**
		 * 不满足条件的行都隐藏，满足条件的行状态不变（如果原来是隐藏的还是隐藏）。不会重写行号
		 * @cond 匹配行的条件{fieldname:value,...}
		 */
		this.filterRows = function(cond){
			//获取不满足条件的行，隐藏
			var rows = rejectData(cond);
			$.each(rows, function(i, row){
				$(row.fixed).hide();
				$(row.body).hide();
			});
			resetStyle();
			updateSize();
		}
		/**
		 * 按条件隐藏行，不会重写行号
		 * @cond 匹配行的条件{fieldname:value,...}
		 */
		this.hideRows = function(cond){
			var rows = filterData(cond);
			$.each(rows, function(i, row){
				$(row.fixed).hide();
				$(row.body).hide();
			});
			resetStyle();
			updateSize();
		};
		/**
		 * 按条件显示行，不会重写行号
		 * @cond 匹配行的条件{fieldname:value,...}
		 */
		this.showRows = function(cond){
			var rows = filterData(cond);
			$.each(rows, function(i, row){
				$(row.fixed).show();
				$(row.body).show();
			});
			resetStyle();
			updateSize();
		};
		
		//隐藏列
		this.hideColumn = function(field){
			if(!$ColumnPropsMap[field]["hidden"]){
				if($HeaderCols[0].find("[field='"+field+"']")[0]){//属于固定区
					$($HeaderPane).find("table tr").children("[field='"+field+"']").hide();
				}else{//属于主数据区
					$($BodyPane).find("table tr").children("[field='"+field+"']").hide();
				}
				$ColumnPropsMap[field]["hidden"]=true;
				//TODO:: resize table
				updateSize();
			}
		};
		
		this.showColumn = function(field){
			if($ColumnPropsMap[field]["hidden"]){
				if($HeaderCols[0].find("[field='"+field+"']")[0]){//属于固定区
					$($HeaderPane).find("table tr").children("[field='"+field+"']").show();
				}else{//属于主数据区
					$($BodyPane).find("table tr").children("[field='"+field+"']").show();
				}
				$ColumnPropsMap[field]["hidden"]=false;
				//TODO:: resize table
				updateSize();
			}
		};
		
		/**
		 * [{text:"", value:""},...]
		 */
		this.getHiddenColumns = function(){
			var result=new Array();
			$HeaderPane[0].find("th[field]:hidden").each(function(){
				result.push({text:$(this).children("div").html(), value: $(this).attr("field")});
			});
			$BodyPane[0].find("th[field]:hidden").each(function(){
				result.push({text:$(this).children("div").html(), value: $(this).attr("field")});
			});
			return result;
		};
		
		this.getGroupFields = function(){
			var array = new Array(), result = new Array();
			//对group column按照depth做排序
			for(var i in $GroupProps){
				array[parseInt(i)] = $GroupProps[i].groupName;
			}
			for(var i=0,len=array.length;i<len;i++){
				if(array[i]){
					result.push(array[i]);
				}
			}
			return result;
		};
		
		this.isGroupColumn = function(field){
			for(var i in $GroupProps){
				if($GroupProps[i].groupName == field){
					return true;
				}
			}
			return false;
		};
		/**
		 * 获取列信息：为列的菜单项显示/隐藏列提供数据
		 */
		this.getDataColumns = function(){
			var columns = new Array(),
				result = new Array();
			for(var field in $ColumnPropsMap){
				columns[$ColumnPropsMap[field]["colIndex"]] = {name:field, text:$ColumnPropsMap[field]["title"], colType:$ColumnPropsMap[field].define.type, hidden:$ColumnPropsMap[field].hidden};
			}
			for(var i=0,len=columns.length;i<len;i++){
				if(columns[i].colType==columnTypeConstant.DATA_COLUMN){
					result.push(columns[i]);
				}
			}
			return result;
		};
		
		this.sortColumn = function(fieldName, desc){
			sort(fieldName, desc);
		};
		
		this.getSortTypeOfColumn = function(fieldName){
			return getSortType(fieldName);
		};
		this.getSortableOfColumn = function(fieldName){
			var result;
			try{
				result = $ColumnPropsMap[fieldName]["define"]["children"][0]["sortable"];
			}catch(e){
				
			}
			return result;
		};
		
		/**
		 * 设置列可用/不可以
		 */
		this.setColumnEnable = function(fieldName, enable){
			var fieldProp = $ColumnPropsMap[fieldName];
			if(typeof(fieldProp) != "undefined" && fieldProp["define"]["children"][0]["enable"]!=enable){
				fieldProp["define"]["children"][0]["enable"] = enable;
				if(fieldProp["isFixed"]==true){
					$HeaderCols[1].find("tr").each(function(){
						setTableCellEnable($(this).children("[field='"+fieldName+"']"), enable);
					});
				}else{
					$BodyCols[1].find("tr").each(function(){
						setTableCellEnable($(this).children("[field='"+fieldName+"']"), enable);
					});
				}
			}
		};
		/**
		 * 固化
		 */
		this.freezeColumn = function(fieldName){
			var fieldProp = $ColumnPropsMap[fieldName];
			if(typeof(fieldProp) == "undefined" || fieldProp["isFixed"]){
				return;
			}
			//dom迁移
			$BodyCols[0].find("th[field='"+fieldName+"']").insertAfter($HeaderCols[0].find("tr").children().last());
			var fixedRows = $HeaderCols[1].find("table:first").find("tr");
			$BodyCols[1].find("table:first").find("tr").each(function(index){
				$(this).find("td[field='"+fieldName+"']").insertAfter($(fixedRows[index]).children().last());
			});
			if($BodyCols[2] && $BodyCols[2].length>0){
				var fixedTotal = $HeaderCols[2].find("table:first").find("tr");
				$BodyCols[2].find("table:first").find("tr").each(function(index){
					$(this).find("td[field='"+fieldName+"']").insertAfter($(fixedTotal[index]).children().last());
				});
			}
			$ColumnPropsMap[fieldName]["isFixed"] = true;
			var headerSortResult = sortComplexTableHeader();
			for(var field in $ColumnPropsMap){
				if(headerSortResult[field]){
					$ColumnPropsMap[field]["colIndex"] = headerSortResult[field]["index"];
				}
			}
			//resize
			updateSize();
		};
		/**
		 * 解固
		 */
		this.unfreezeColumn = function(fieldName){
			var fieldProp = $ColumnPropsMap[fieldName];
			if(typeof(fieldProp) == "undefined" || !fieldProp["isFixed"]){
				return;
			}
			//dom迁移
			$HeaderCols[0].find("th[field='"+fieldName+"']").insertAfter($BodyCols[0].find("tr:first").children().last());
			var rows = $BodyCols[1].find("table:first").find("tr");
			$HeaderCols[1].find("table:first").find("tr").each(function(index){
				$(this).find("td[field='"+fieldName+"']").insertAfter($(rows[index]).children().last());
			});
			if($HeaderCols[2] && $HeaderCols[2].length>0){
				var total = $BodyCols[2].find("table:first").find("tr");
				$HeaderCols[2].find("table:first").find("tr").each(function(index){
					$(this).find("td[field='"+fieldName+"']").insertAfter($(total[index]).children().last());
				});
			}
			$ColumnPropsMap[fieldName]["isFixed"] = false;
			var headerSortResult = sortComplexTableHeader();
			for(var field in $ColumnPropsMap){
				if(headerSortResult[field]){
					$ColumnPropsMap[field]["colIndex"] = headerSortResult[field]["index"];
				}
			}
			//resize
			updateSize();
		};
		
		this.getElement = function(){
			return $Element;
		};
		/**
		 * 返回当前最后新增行的行号
		 */
		this.getInsertRowIndex = function(){
			return $RowIndex;
		};
		
		/**
		 * 组合多个table的内容到一个table, 
		 * 返回table的html文本
		 */
		this.toSimpleTable = function(){
			var tableStr = "<table><tr>";
			//header row
			tableStr += $HeaderCols[0].find("table").find("tr").html();
			tableStr += $BodyCols[0].find("table").find("tr").html();
			tableStr += "</tr>";
			//body rows 
			var leftRows = $HeaderCols[1].find("table:first").find("tr"), rightRows = $BodyCols[1].find("table:first").find("tr");
			for(var i=0,len=leftRows.length; i<len; i++){
				tableStr += "<tr>";
				tableStr += $.trim($(leftRows[i]).html()) + $.trim($(rightRows[i]).html());
				tableStr += "</tr>";
			}
			//total row
			if($HeaderCols[2]){
				leftRows = $HeaderCols[2].find("table:first").find("tr");
				rightRows = $BodyCols[2].find("table:first").find("tr");
				for(var i=0,len=leftRows.length; i<len; i++){
					tableStr += "<tr>";
					tableStr += $.trim($(leftRows[i]).html()) + $.trim($(rightRows[i]).html());
					tableStr += "</tr>";
				}
			}
			//footer row
			footerrow = $FooterPane.find("table:first").find("tr");
			for(var i=0,len=footerrow.length;i<len;i++){
				tableStr += "<tr>";
				tableStr += $.trim($(footerrow[i]).html());
				tableStr += "</tr>";
			}
			tableStr += "</table>";
			return tableStr;
		};
		
/**
*=================Datagrid全局变量声明=====================================
**/		
		var isIE7Le = $.isIE7Le();
		var $Element = $(element),	
		$Instance = this,
		$Options = expendConfig(options),
		$BodyPane = $Element.children($Options.bodyPane),	//主列 DIV pane
		$HeaderPane = $BodyPane.prev(),							//固定列 DIV pane		
		$FooterPane = $BodyPane.next(),							//表格底部状态 DIV pane	
		$HeaderCols = getHeaderColumn(),						//固定列的表格容器包装集
		$BodyCols = getBodyColumn(),							//主列的表格容器包装集
		$RowIndex = -1,
		$FixedColumns = [],
		$NormalColumns = [],
		$HoriScroll = false,
		$VerticalScroll = false,
		$FocusRowIndex = -1, //获取焦点的行序号
		$UpdatedRowIndex = -1, //当前最后被修改过的行的行号
		$SelectedRowIndex = -1,//当前最后被选中的行的行号
		$FixedTHs, 
		$BodyTHs,
		
		$SubgridField = null,
		$ChkField = null,								//选中行操作的复选框列的field值
		$NumberField = null,  //左边固定列的自然行号 td field属性值
		$ColumnPropsMap = {},  //{fieldName: {define: {colDefine}, width: 20, unscaledWidth:100, colIndex:0, hidden:false,...}, ...}
		$GroupProps = {}, //{depth:{groupField:"", groupName:""},...}. eg:{"0":{groupField: "item1", groupName:"item1"}, "1":{groupField: "item2", groupName:"item2"}}
		$StatsField = [],
		$IndexField = null, //包含数据库中的行号的单元格td的field属性值
		$IndexName = null, //数据库行号的字段名
		$PrimaryFields = [],
		
		$AddedRows = new Object(),//{rowindex:{"name1":"value1", ...}, ...}
		$UpdatedRows = new Object(), //{rowIndex:{"name1":"value1", ...}, ...}
		$DeletedRows = new Object();//{rowIndex:{"name1":"value1", ...}, ...}
		
		/**
		 *  拖拽调整列宽的控制器
		 *  状态标志，控制只有在鼠标按下并出现拖拽指示线的情况下(isMouseDown==true)，
		 *  才会控制拖拽指示线跟着鼠标移动直到鼠标释放是isMouseDown置为false;
		*/
		var isMouseDown = false;
		init();
	};
	

	$.fn.datagrid = function(options){
		var grid = new Datagrid(this[0], options);
		$.data(this[0], "datagrid", grid);
		return grid; 
	};
	
})( jQuery );