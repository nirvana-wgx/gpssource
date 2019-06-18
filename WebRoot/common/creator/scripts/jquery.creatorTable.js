
(function($){

	$.fn.creatorTable = function(opts){
		
		var init = function(paramObj){
			var defaults = {
				showIndex:false,//是否显示每行序号的属性，默认为true。
				indexContainer:".row_index",//每行序号的容器。
				cacheContainer:"",//新增行的模版容器。
				trHtml:"",//新增行的内容html。
				titleContainer:"",//表头的容器。
				bodyContainer:""//表数据内容的容器。
			};
			//合并默认值和传递的参数。
			options = $.extend(defaults, paramObj);
			var tempDate = new Date();
			options.jqId = "jq"+tempDate.getTime();
			//设置缓存。
			if(options.cacheContainer != ""){//如果使用隐藏域取表格的行。
				innerMethord.setCache(options.jqId,$(self).find(options.cacheContainer).find("table tbody").html());
			}else{//否则将trHtml放到缓存中。
				innerMethord.setCache(options.jqId,options.trHtml);
			}
			if(options.showIndex){//如果是显示序号。
				innerMethord.setRowIndex(options);
			}
			innerMethord.bindKeyEvent();
			
		};
		
		var innerMethord = {
			setCache:function(key,value){//设置缓存数据。
				$.data(self,key,value);
			},
			getCache:function(key){//从缓存中获取数据。
				return $.data(self,key);
			},
			setRowIndex:function(params){//显示序号和排序的方法。
				$(self).find(params.bodyContainer).find("tbody tr").each(function(i){
					if($(this).find("td").find(params.indexContainer)[0]){
						$(this).find("td").find(params.indexContainer).html(i+1);
					}else{
						var indexClass = params.indexContainer.substring(1);
						var indexSpan = "<span class='"+indexClass+"'>"+(i+1)+"</span>";
						$(this).find("td").first().append(indexSpan);
					}
				});
			},
			addRows:function(params, cacheData){//添加行。
				if(params && typeof params == "object"){//如果参数传递的是数组类型的对象。
					$.each(params, function(){
						//alert(JSON.stringify(this));
						var trObj = $(innerMethord.getCache(options.jqId));
						trObj.serialAll("load",this);
						$(self).find(options.bodyContainer).children("table").append(trObj);
						if(cacheData){
							$.data(trObj[0], "data", this);
						}
					});
				}else{
					$(self).find(options.bodyContainer).children("table").append(innerMethord.getCache(options.jqId));
				}
				//排序
				if(options.showIndex){
					innerMethord.setRowIndex(options);
				}
			},
			deleteRow:function(){//删除行。
				$(self).find(options.bodyContainer).children("table").find("tbody tr").each(function(){
					if($(this).find(":checkbox:first").attr("checked")=="checked"){
						$(this).remove();
					}
				});
				//排序
				if(options.showIndex){
					innerMethord.setRowIndex(options);
				}
			},
			deleteRowByCondition: function(cond){//按条件cond删除行
				$(self).find(options.bodyContainer).children("table").find("tbody tr").each(function(){
					if($(this).find(cond).length>0){
						$(this).remove();
					}
				});
				if(options.showIndex){
					innerMethord.setRowIndex(options);
				}
			},
			clearBody : function(){//清除内容区所有内容
				$(self).find(options.bodyContainer).children("table").find("tbody").children().remove();
			},
			selectRowByCondition: function(cond){//按条件cond选中行
				$(self).find(options.bodyContainer).children("table").find("tbody tr").each(function(){
					if($(this).find(cond).length>0){
						$(this).find(":checkbox:first").attr("checked", "checked");
					}
				});
			},
			selectAll:function(params){//全选和全不选。
				if(params=="checked"){
					$(self).find(options.bodyContainer).children("table").find("tbody tr").each(function(){
						$(this).find(":checkbox:first").attr("checked", "checked");
					});
				}else{
					$(self).find(options.bodyContainer).children("table").find("tbody tr").each(function(){
						$(this).find(":checkbox:first").removeAttr("checked");
					});
				}
			},
			upRowIndex:function(){//向上移动行。
				$(self).find(options.bodyContainer).children("table").find("tbody tr").each(function(rowIndex){
					if($(this).find(":checkbox:first").attr("checked")=="checked"){ //行被选中
						if(rowIndex > 0){//第一行不能往上移
							if($(this).prev().find(":checkbox:first").attr("checked")!="checked"){ //如果上一行也被选，此行不往上移
								$(this).prev().before(this);
							}
						}
					}
				}); 
				//排序
				if(options.showIndex){
					innerMethord.setRowIndex(options);
				}
			},
			downRowIndex:function(){//向下移动行。
				var allRows = $(self).find(options.bodyContainer).children("table").find("tbody tr");
				var rowCount = $(allRows).length;
				//从下往上开始处理，最后一行不处理
				for(var rowIndex=rowCount-2; rowIndex>=0; rowIndex=rowIndex-1){
					var currentRow = allRows[rowIndex];
					if($(currentRow).find(":checkbox:first").attr("checked")=="checked"){
						if($(currentRow).next().find(":checkbox:first").attr("checked")!="checked"){ //如果下一行也被选，此行不下移
							$(currentRow).before($(currentRow).next());
						}
					}
				}
				//排序
				if(options.showIndex){
					innerMethord.setRowIndex(options);
				}
			},
			getAllDatas: function(){//获得表格内容的所有值，返回为数组对象。
				var tableData = new Array();
				$(self).find(options.bodyContainer).find("tbody tr").each(function(){
					var initData={};
					if($.data(this, "data")){//保证不丢失本来有的数据
						initData = $.data(this, "data")
					}	
					var rowData = $.extend({}, initData, $(this).serialAll("object", "noarray"));
					if(!jQuery.isEmptyObject(rowData)){//如果不是空的对象。
						tableData.push(rowData);
					}
				});
				return tableData;
			},
			getSelections:function(){//获得选中的数据。
				var tableData = new Array();
				$(self).find(options.bodyContainer).find("tbody tr").each(function(){
					if($(this).find(":checked")[0]){
						var initData={};
						if($.data(this, "data")){//保证不丢失本来有的数据
							initData = $.data(this, "data")
						}	
						var rowData = $.extend({}, initData, $(this).serialAll("object"));
						if(!jQuery.isEmptyObject(rowData)){//如果不是空的对象。
							tableData.push(rowData);
						}
					}
				});
				return tableData;
			},
			queryRow: function(queryCondition){//返回满足条件的行
				var rows = new Array();
				$(self).find(options.bodyContainer).find("tbody tr").each(function(){
					if($(this).find(queryCondition)[0]){
						rows.push(this);
					}
				});
				return rows;
			},
			
			bindKeyEvent : function(){
				$(document).keydown(function(e){ //键盘上下、回车键控制
					e = e || window.event;
					var currKey = e.keyCode || e.which || e.charCode;
					var target = e.srcElement || e.target;
					if($(target).parents(options.bodyContainer).length<=0){ //判断不在表格内部
						return;
					}
					var srcTD = $(target).parent();
					var index = srcTD.index();
					switch(currKey){
						case 13: //回车键，新增一行
							if(!$(srcTD).next()[0]){ //是最后一列
								innerMethord.addRows();
							}
							if(options.showIndex){
								$(srcTD).parent().next().find('td:eq(1)').children().focus();
							}else{
								$(srcTD).parent().next().find('td:first').children().focus();
							}
							break;
						case 38: //方向键上
							$(srcTD).parent().prev().find('td:eq('+index+')').children().focus();
							break;
						case 40: //方向键下
							$(srcTD).parent().next().find('td:eq('+index+')').children().focus();
							break;
					}
				});
			}
		}
		var options = opts;
		var self = this;
		init(opts);
		
		return {
			addRow : innerMethord.addRows,
			delRows : innerMethord.deleteRow,
			getAllDatas : innerMethord.getAllDatas,
			getSelections : innerMethord.getSelections,
			selectAll : innerMethord.selectAll,
			upRow : innerMethord.upRowIndex,
			downRow : innerMethord.downRowIndex,
			deleteRowByCondition : innerMethord.deleteRowByCondition,
			selectRowByCondition : innerMethord.selectRowByCondition,
			queryRow : innerMethord.queryRow,
			clearBody : innerMethord.clearBody
		};
	};
	
})(jQuery);