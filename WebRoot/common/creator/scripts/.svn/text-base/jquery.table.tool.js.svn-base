		(function($){
			$.fn.coollf={
				tableToolInnerMethod:{
					init:function(thisObj,options){
							var defaults={
								onTrClick: null, //表格行单击事件
								onTrDbClick: null, //表格行双击事件
								
								oddRowBackground:'', //单行背景
								evenRowBackground:'', //偶数行背景 c_className 可以加类样式  默认是颜色
								
								oddColBackground: '', //奇数列背景
								evenColBackground: '',//偶数列背景
								
								onTrMouseout:'',  //鼠标移出行
								onTrMouseover: '', //鼠标移入行
								drag: false,  //拖动
								sort:false,    //表格排序
								onTdMouseout: '', //鼠标移出的单元格
								onTdMouseover: '', //鼠标进入单元格
								specialBackground:null,  //特殊单元格背景颜色配置 [{row:0,col:2,background:'read'},{row:5,col:2,background:'green'}]
								specialEvent:null//{row:0,col:2,events:[{event:'click',fn:hi},{event:'dblclick',fn:his}]},{row:5,col:2,events:[{event:'click',fn:hi},{event:'dblclick',fn:his}]}
							};
							var options = $.extend(defaults, options);
							/**处理背景色*/
							if(options.oddRowBackground!=''){		
								var $target=$(thisObj).find('.table_body').find('tr:odd');
								$.fn.coollf.tableToolInnerMethod.util.processCss($target,options.oddRowBackground)
							}
							if(options.evenRowBackground!=''){
								var $target=$(thisObj).find('.table_body').find('tr:even');
								$.fn.coollf.tableToolInnerMethod.util.processCss($target,options.evenRowBackground);
							}
							/**处理列背景颜色**/
							if(options.oddColBackground!=''){
								var $target = $(thisObj).find('.table_body tr').find('td:odd');
								$.fn.coollf.tableToolInnerMethod.util.processCss($target,options.oddColBackground)
							}
							if(options.evenColBackground!=''){
								$target=$(thisObj).find('.table_body tr').find('td:even');
								$.fn.coollf.tableToolInnerMethod.util.processCss($target,options.evenColBackground);
							}
							/***处理单击事件*/
							if(options.onTrClick){
								$(thisObj).find('.table_body tr').click(options.onTrClick);
							}
							/**处理双击事件*/
							if(options.onTrDbClick){
								$(thisObj).find('.table_body tr').dblclick(options.onTrDbClick);
							}
							/**处理列单击事件**/
							if(options.onTdClick){
								$(thisObj).find('.table_body td').click(options.onTdClick);
							}
							/**处理TD双击事件**/
							if(options.onTdDbClick){
								$(thisObj).find('.table_body td').dblclick(options.onTdDbClick);
							}
							
							/**处理鼠标移入行**/		
							if(options.onTrMouseover){
								$(thisObj).find('.table_body tr').mouseover(options.onTrMouseover);
							}
							if(options.onTrMouseOut){
								$(thisObj).find('.table_body tr').mouseout(options.onTrMouseOut);
							}
							if(options.onTdMouseover){
								$(thisObj).find('.table_body td').mouseover(options.onTdMouseover);
							}
							if(options.onTdMouseout){
								$(thisObj).find('.table_body td').mouseout(options.onTdMouseout);
							}
							/**处理排序**/
							if(options.sort){
								$(thisObj).find('.table_header tr').find('th').toggle($.fn.coollf.tableToolInnerMethod.sortDesc,$.fn.coollf.tableToolInnerMethod.sortAsc);		
							}
							/**处理特殊列背景**/
							if(options.specialBackground){
								for(var i=0,leng= options.specialBackground.length;i<leng;i++){
									$(thisObj).find('.table_body').find('table tbody').find('tr:eq('+options.specialBackground[i].row+')').find('td:eq('+options.specialBackground[i].col+')').css('background',options.specialBackground[i].background);
								}
							}
							/**处理单元格事件**/
							if(options.specialEvent){
								var spe=options.specialEvent;
								for(var i=0,leng=spe.length;i<leng;i++){
									var $t= $(thisObj).find('.table_body').find('tr:eq('+spe[i].row+')').find('td:eq('+spe[i].col+')');
									var evs=spe[i].events;
									$(evs).each(function(){
										$t.bind(this.event,this.fn);				
									})
								}
							}		
					},
					init0:function(thisObj,options){
						var defaults={
							selectMode:'checkbox', //checkbox //radio // attr  匹配模式 checkbox: 行弄有选中的复选框, 
													//radio :行中有选中的有效的单选框 ,attr 在行上有特殊的属性
							colNumber: null,  //checkbox 或 radio 所在的列的位置 从0开始
							selectKey: null,   //选择的属性值(对于attr模式)如'[select=selected]' 
							returnValMode: 'key' // key , all  key:返回行的主键值 即checkbox或radio的值 all: 该行所有的数据 
						}
						options=$.extend(defaults, options);
						if(options.selectMode==='checkbox'){//复选匹配模式
							var index=0;
							var date=null;
							if(options.colNumber){ //非第一列
								index=options.colNumber;
							}
							var $boxs=null;
							if($(thisObj).find('.table_body')[0]){
								$boxs= $(thisObj).find('.table_body tr').find('td:eq('+index+')').find(':checkbox:checked');
							}else{						
								$boxs= $(thisObj).find('tr').find('td:eq('+index+')').find(':checkbox:checked'); //非标准调用即只有一个表格结构
							}					
							return $.fn.coollf.tableToolInnerMethod.getSelectDateByInputTag($boxs,options.returnValMode);	//调用方法获取选中表格数据	
						}
						
						if(options.selectMode==='radio'){//单选匹配模式
							var index=0;
							var date=null;
							if(options.colNumber){ //非第一列
								index=options.colNumber;
							}
							var $boxs=null;
							if($(thisObj).find('.table_body')[0]){
								$boxs= $(thisObj).find('.table_body tr').find('td:eq('+index+')').find(':radio:checked');
							}else{
								$boxs= $(thisObj).find('tr').find('td:eq('+index+')').find(':radio:checked'); //非标准调用即只有一个表格结构
							}					
							return $.fn.coollf.tableToolInnerMethod.getSelectDateByInputTag($boxs,options.returnValMode);	//调用方法获取选中表格数据	
						}
						
						if(options.selectMode==='attr'){//行属性匹配模式
							var index=0;
							var date=null;
							if(options.colNumber){ //非第一列
								index=options.colNumber;
							}
							var $trs=null;
							var key='[selected]'; //如果默认tr有 selected属性 即是选中的 如:<tr selected='wo'><td></td></tr> 
							if(options.selectKey){
								key=options.selectKey;
							}
							if($(thisObj).find('.table_body')[0]){
								$trs= $(thisObj).find('.table_body tr'+key);
							}else{
								$trs= $(thisObj).find('tr'+key);  //非标准调用即只有一个表格结构
							}
							return $.fn.coollf.tableToolInnerMethod.getSelectDataByTr($trs,options.returnValMode);
						}
						return ;
					},
					init1:function(thisObj,options){
						var defaults={
							selectMode:'checkbox', //checkbox //radio // attr  匹配模式 checkbox: 行弄有选中的复选框, 
													//radio :行中有选中的有效的单选框 ,attr 在行上有特殊的属性
							colNumber: null,  //checkbox 或 radio 所在的列的位置 从0开始
							selectKey: null   //选择的属性值(对于attr模式)如'[select=selected]' 
						}
						options=$.extend(defaults, options);
						if(options.selectMode==='attr'){//行属性匹配模式
							var index=0;
							var date=null;
							if(options.colNumber){ //非第一列
								index=options.colNumber;
							}
							var $trs=null;
							var key='[selected]'; //如果默认tr有 selected属性 即是选中的 如:<tr selected='wo'><td></td></tr> 
							if(options.selectKey){
								key=options.selectKey;
							}
							if($(thisObj).find('.table_body')[0]){
								$trs= $(thisObj).find('.table_body tr'+key);
							}else{
								$trs= $(thisObj).find('tr'+key);  //非标准调用即只有一个表格结构
							}
							return $trs;
						}
						if(options.selectMode==='checkbox'){//复选匹配模式
							var index=0;
							var date=null;
							if(options.colNumber){ //非第一列
								index=options.colNumber;
							}
							var $boxs=null;
							if($(thisObj).find('.table_body')[0]){
								$boxs= $(thisObj).find('.table_body tr').find('td:eq('+index+')').find(':checkbox:checked');
							}else{						
								$boxs= $(thisObj).find('tr').find('td:eq('+index+')').find(':checkbox:checked'); //非标准调用即只有一个表格结构
							}					
							return 	$boxs.parents('tr');//调用方法获取选中表格数据	
						}						
						if(options.selectMode==='radio'){//单选匹配模式
							var index=0;
							var date=null;
							if(options.colNumber){ //非第一列
								index=options.colNumber;
							}
							var $boxs=null;
							if($(thisObj).find('.table_body')[0]){
								$boxs= $(thisObj).find('.table_body tr').find('td:eq('+index+')').find(':radio:checked');
							}else{
								$boxs= $(thisObj).find('tr').find('td:eq('+index+')').find(':radio:checked'); //非标准调用即只有一个表格结构
							}					
							return $boxs.parents('tr');	//调用方法获取选中表格数据	
						}
						return ;
					},
					getSelectDataByTr:function($trs,$returnValMode){
						var arr=new Array();
							if($returnValMode==='key'){
								$trs.each(function(i){
									var obj=$(this).find('td:eq(0)');							
									arr[i]=$.fn.coollf.tableToolInnerMethod.util.getTdVal(obj);		
								});	
							}else{
								$trs.each(function(i){
									var  _row=new Array();
									$(this).find('td').each(function(i,obj){										
										_row[i]=$.fn.coollf.tableToolInnerMethod.util.getTdVal(obj);
									});									
									arr[i]=_row;
								});
							}
						return arr;		
					},
					util:{
						getSelectVal:function($sel){
							//alert($sel[0].value);
							if(!$sel[0]){
								return '';
							}				
							var t=$sel.val();
							if(!t){
							   t='NaN';	 
							}
							return  t;
						},
						getTdVal:function(obj){//表格单元格内容		 			
							var _colVal='';
							if(_colVal===''&&$(obj).find('select').length>0){
								_colVal=$.fn.coollf.tableToolInnerMethod.util.getSelectVal($(obj).find('select'));
							}
							if(_colVal===''){
								_colVal=$(obj).text().replace(/^\s+|\s+$/g,''); //去除两端空白
								if(_colVal==''&&$(obj).find('input').length>0){//单元格中有表单 只处理一个input的对象  2012-04-01 修改bug
									_colVal=$(obj).find('input').val().replace(/^\s+|\s+$/g,'');					
								}
							}
							return _colVal;
						},
						processCss: function($target,bginfo){//处理背景
							if(/c_*/.test(bginfo)){//当成CSS 的class处理
								$target.addClass(bginfo.substr(2,bginfo.length));
							}else{
								$target.css('background-color',bginfo);
							}					
						}
						
					},
					getSelectDateByInputTag:function($boxs,$returnValMode){//通过选择td 内部的表单标签获取选中的表格数据
						var arr=new Array();
							if($returnValMode==='key'){
								$boxs.each(function(i){
									arr[i]=$(this).val();						
								});	
							}else{
								$boxs.each(function(i){
									var  _row=new Array();
									$(this).parent().parent().find('td').each(function(i,obj){
										_row[i]=$.fn.coollf.tableToolInnerMethod.util.getTdVal(obj);
									});									
									arr[i]=_row;
								});
							}
						return arr;			
					},
					sortDesc:function(){
						$.fn.coollf.tableToolInnerMethod.tableSort(this,'desc');
					},
					sortAsc:function(){		
						$.fn.coollf.tableToolInnerMethod.tableSort(this,'asc');
					},
					tableSort:function(head,type){
						var $tables_panel=$(head).parents('.tables_panel');
						if(!$tables_panel[0]) //无法取得父容器
							return ;
						var $ths=$tables_panel.find('th');
						var index=-1;
						$ths.each(function(i){
							if(this===head){
								index=i;
								return ;
							}
						});
						var keys='td:eq('+index+')';
						//var old=new Date();
						var $sortTds=$tables_panel.find('.table_body tr').find(keys);
						//alert('获取排序列:'+ (new Date()-old));			
						//缓存数据
						//old=new Date();
						$.each($sortTds,function(index,td){
							var dat=$.fn.coollf.tableToolInnerMethod.util.getTdVal(td);
							//$(td).text().toUpperCase();					
							if(!isNaN(dat)){
								dat=new Number(dat);
							}else{				
								if(/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/.test(dat)||/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/.test(dat)){
									dat=new Date(dat.replace(/-/g,"/")); //IE bug safair bug
								}
							}			
							$(td).data('sortKey',dat);		
						});
						//alert('缓存数据:'+(new Date()-old));
						
						//old=new Date();
						$sortTds.sort(function(a,b){	
							if(type=='asc'){
								if ($(a).data('sortKey') < $(b).data('sortKey'))
									return -1;
								if ($(a).data('sortKey') > $(b).data('sortKey'))
									return 1;
								return 0;
							}else{
								if ($(a).data('sortKey') > $(b).data('sortKey'))
									return -1;
								if ($(a).data('sortKey') < $(b).data('sortKey'))
									return 1;
								return 0;
							}	
						})				
						$.each($sortTds,function(i){
							$tables_panel.find('.table_body table tbody').append($(this).parent());
						});
						//alert('dd');
						//alert('插入时间:'+(new Date()-old));
						$sortTds=null;
					}
				}	
			};	
			/**
			*表格工具 绑定事件 行列背景 表格排序
			*/
			$.fn.tableTool=function(options){
				$.fn.coollf.tableToolInnerMethod.init(this,options);
			};	
			
			/**
			* 获取表格数据
			*/
			$.fn.getSelectRowDate=function(options){
				var dats=$.fn.coollf.tableToolInnerMethod.init0(this,options);
				return dats;
			};
			/*****
			*获取选择的表格行
			*/
			$.fn.getSelectRow=function(options){
				var rows=$.fn.coollf.tableToolInnerMethod.init1(this,options);
				return rows;
			}
		})(jQuery);