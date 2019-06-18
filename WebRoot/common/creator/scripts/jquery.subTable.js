(function($){
	
	$.fn.subTable = function(methodName, param){
		if(typeof methodName != "string"){//判断传递的第一个参数的类型。
			return;
		}
		if(methodName == "init"){
			$.fn.subTable.innerMethord.init(param);
		}else if(methodName == "getExpandedItems"){//返回当前是展开状态的行
			return $.fn.subTable.innerMethord.getExpandedItems();
		}else if(methodName == "expandItems"){//展开指定的行
			$.fn.subTable.innerMethord.expandItems(param);
		}else if(methodName == "expandAll"){
			$.fn.subTable.innerMethord.expandAll();
		}else if(methodName == "closeAll"){
			$.fn.subTable.innerMethord.closeAll();
		}
	};
	$.fn.subTable.innerMethord = {
		//缓存所有加载过的子表数据
		setCache:function(key,value){//设置缓存数据。
			$.data(document.body,key,value);
		},
		getCache:function(key){//从缓存中获取数据。
			return $.data(document.body,key);
		},
		init:function(options){
			var defaults = {
				titleContainer:".table_header",
				bodyContainer:".table_body",
				toExpandIcon : "", //控制图片的路径
				toCloseIcon : "",
				controlColIndex:0,//放置控制图片的列序号。方案二需要的值
				colWidth : 20, //新增第一列的宽度。方案一需要的值
				queryID : "", //用于查询子表数据的列名
				colIndexOfValue: 0,//用于查询子表数据的条件值的来源
				startColIndex:0,//子表在父表中的列序号
				colSpan:-1,//子表占据父表空间的列数。-1表示占据父表后面所有的列
				url:""
			};
			var opts = $.extend(defaults, options);
			$(this).data('options', opts);
			
			var headerRow = $(opts.titleContainer).find('tr')[0];
			var body = $(opts.bodyContainer).find('table')[0];
			//方案一：控制列由插件动态生成
			//在表格左边增加一列
	/*		var w = opts.colWidth;
			$(headerRow).prepend("<th style='width:"+w+"px'></th>");
			$(body).find('tr').each(function(){
				var v = $(this).find('td').eq(opts.colIndexOfValue).html();
				$(this).prepend("<td class='menuCol' style='width:"
							+w+"px'><img class='triggerImg' src='"+opts.toExpandIcon+"'/>"
								+"<input name='"+opts.queryID+"' type='hidden' value='"+v+"'></td>");
			});
	*/		//方案二：控制列通过改造现有的某列生成
			$(body).find('tr').each(function(){
				var v = $(this).find('td').eq(opts.colIndexOfValue).html();
				var td = $(this).find('td').eq(opts.controlColIndex);
				$(td).empty();
				$(td).append("<img class='triggerImg' src='"+opts.toExpandIcon+"'/>"
								+"<input name='"+opts.queryID+"' type='hidden' value='"+v+"'></td>");
			});
	
			$(body).find('.triggerImg').live("click", function(){
				var nextObj = $(this).parents("tr").next().find("td[subtable]")[0];
				if(!nextObj){
					//调用获得子表的方法。
					$(this).attr("src",opts.toCloseIcon);
					expand($(this).parents("tr"), $(this).next().val(), opts);
				}else{
					$(this).parents("tr").next().remove();
					$(this).attr("src",opts.toExpandIcon);
				}
			});
		},
		expandAll:function(){//展开所有的子内容
			var opts = $(this).data('options');
			var body = $(opts.bodyContainer).find('table')[0];
			$(body).find('.triggerImg').each(function(){
				var nextObj = $(this).parents("tr").next().find("td[subtable]")[0];
				if(!nextObj){
					expand($(this).parents("tr"), $(this).next().val(), opts);
					$(this).attr("src",opts.toCloseIcon);
				}
			});
		},
		closeAll:function(){//隐藏所有的子内容
			var opts = $(this).data('options');
			var body = $(opts.bodyContainer).find('table')[0];
			$(body).find('.triggerImg').each(function(){
				var nextObj = $(this).parents("tr").next().find("td[subtable]")[0];
				if(nextObj){
					$(this).parents("tr").next().remove();
					$(this).attr("src",opts.toExpandIcon);
				}
			});
		},
		getExpandedItems:function(){ //返回当前所有处于展开状态的行
			var opts = $(this).data('options');
			var body = $(opts.bodyContainer).find('table')[0];
			var expandedItems = new Array();
			$(body).find('.triggerImg').each(function(){
				var nextObj = $(this).parents("tr").next().find("td[subtable]")[0];
				if(nextObj){
					expandedItems.push($(this).parents("tr"));//存储展开的行
				}
			});
			return expandedItems;
		},
		expandItems:function(items){ //展开指定行的子内容
			var opts = $(this).data('options');
			var body = $(opts.bodyContainer).find('table')[0];
			$(items).each(function(){
				var img = $(this).find('.triggerImg');
				expand($(this), $(img).next().val(), opts);
				$(img).attr("src",opts.toCloseIcon);
			});
		},
		closeItems:function(items) { //隐藏指定行的子内容
			var opts = $(this).data('options');
			var body = $(opts.bodyContainer).find('table')[0];
			$(items).each(function(){
				var nextObj = $(this).next().find("td[subtable]")[0];
				if(nextObj){
					$(this).next().remove();
					$(this).find('.triggerImg').attr("src",opts.toExpandIcon);
				}
			});
		}
	};
	//获取表格的总列数
	getColNum = function(opts){
		var headerRow = $(opts.titleContainer).find('tr')[0];
		var colNum = 0;//表格总列数
		$(headerRow).find('th').each(function(){
			colNum += parseInt($(this).attr("colSpan") || 1, 10); //在firefox中$(this).attr("colSpan")==undefined
		});
		return colNum;
	};
	
	expand = function(currentRow, value, opts){
		var subContext = $.fn.subTable.innerMethord.getCache(value);
		if(subContext){ //数据已加载
	/*		var str = "<tr subContainer='true'>";
			for(var i=0; i < opts.startColIndex; i++){
				str += "<td></td>";
			}
			str += "<td subContainer='true' colspan="+opts.colSpan+">"+subContext+"</td>"
			for(var i=opts.startColIndex+opts.colSpan; i <opts.colNum; i++){
				str += "<td></td>";
			}
			str += "</tr>";
			$(currentRow).after(str);
	*/
			$(currentRow).after(subContext);
		}else{ //数据尚未加载
			$.ajax({
				url:opts.url,
				data:opts.queryID+"="+value,
				cache:false,
				async:false,
				success:function(resp){
					var str = "<tr subContainer='true'>";
					for(var i=0; i < opts.startColIndex; i++){
						str += "<td></td>";
					}
					var colNum = getColNum(opts);
					var colSpan = opts.colSpan==-1 ? colNum-opts.startColIndex : opts.colSpan;
					str += "<td subtable='true' colspan="+colSpan+">"+resp+"</td>"
					for(var i=opts.startColIndex+colSpan; i <colNum; i++){
						str += "<td></td>";
					}
					str += "</tr>";
					//数据存入缓冲
					$.fn.subTable.innerMethord.setCache(value, str);
					$(currentRow).after(str);
				}
			});
		}
	};
	
})(jQuery);