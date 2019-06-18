/**
 *常用JS汇总。
 *1.展示子页面
 *2.返回到主页面
 *3.打开模式窗口
 *4.关闭easyui的模式窗口
 *5.清空查询条件
 *6.两次编码，用于解决乱码问题
 *7.提交新增或修改单表到通用控制层
 *8.主从结构的提交
 *9.table排序
 *10.获得选中的check 的value  
 *11.主从表数据回传 
 *12.单表数据回传 
 *13.通用删除
 *14.转跳页面(新增.修改)以及绑定返回事件 
 *15.通用更新,跳转到更新页面 
 *16.导出excel
 */


/**
 * 1.展示子页面。参数为对象options。
 * options包含属性：
 * container：必填，主页面容器。
 * url：必填，请求子页面地址。
 * params：请求子页面传递的参数，为Object。
 * loadSuccess：请求子页面成功后，调用的方法。
 * add by Leon 2012年5月17日 18:30:09
 */
function gotoChildren(options){
	var defaults = {
		container:"",
		url:"",
		params:null,
		loadSuccess:null
	};
	var options = $.extend(defaults, options);
	$(options.container).hide();
	var childDiv = "<div id='div_child_onlyone'></div>";
	$(document.body).append($(childDiv));
	$("#div_child_onlyone").load(options.url,options.params,function(){
		if(typeof options.loadSuccess == "function"){
			options.loadSuccess();
		}
	});
}
/**
 * 2.返回到主页面。参数为对象options。
 * options包含以下属性：
 * container：主页面的容器。
 */
function goBack(options){
	var defaults = {
		container:"",
		backSuccess:null
	};
	var options = $.extend(defaults, options);
	$("#div_child_onlyone").remove();
	$(options.container).show("fast", function(){
		if(typeof options.backSuccess == "function"){
			options.backSuccess();
		}
	});
}


/***============start page style =========================*/
var easylist_warpper_layout;
//两个列表的缩放效果
function layout(){
	$('body').layout({
		center:{
			paneSelector : ".div_contentor"
		}
	});
	$(".div_contentor").layout({
		north:{
			paneSelector : "#div_toolbar",
			size : $("#div_toolbar").outerHeight(),
			spacing_open: 0,
			spacing_closed: 0
		},
		center:{
			paneSelector : ".easylist_contanier",
			contentSelector: ".easylist_wrapper"
		}
	});
	easylist_warpper_layout = $('.easylist_wrapper').layout({
		north:{
				paneSelector : "#div_list",
				innerAdaptable : true,
				size : $("#div_list").height()
		},
		center:{
				paneSelector : "#div_childrenList",
				closable : true,
				fxName_close:'none',
				innerAdaptable : true,
				unionPanel: "north"
		}
	});
}


//列表加载完后的方法。
//在此提供一个默认的列表样式js调用,上下 结构列表

function validateLayout(){
	if(!easylist_warpper_layout){
		layout();
	}else{
		easylist_warpper_layout.resizeAll();
	}
}




/***============end page style =========================*/

/**
* 得tr中的data值，取Data中的属性ID
* dataId 对应数据库的字段ID，注意 大写,例如：getRowId("TECHNICS_XH");
* getDataGridSelectedRowsData 方法中参数为页面DOM无素
* 返加选中数据的ID值 
*/

function getRowId(dataId){
	var rowDateId="";
	var jsonString=getDataGridSelectedRowsData($("#div_table")[0]);
	var jsonObj = JSON.parse("["+jsonString+"]");
	for(var i = 0;i<jsonObj.length;i++){
		var  objectlist=jsonObj[i];
		if(i==(jsonObj.length-1)){
					rowDateId+=objectlist[dataId];
				}else{
					rowDateId+=objectlist[dataId]+",";
				}
		
	}
	return rowDateId;
}

/**
*
* 判断是否选中一行
* 
*/
function getSelectSize(rowDataId){
		var rowId=rowDataId;
		var valObj =getRowId(rowId);
		var idnumber=valObj.split(',');
		var leng=idnumber.length;
		var firstdata=idnumber[0];
	if(firstdata!=""){
		return true;	
	}else{
		return false;
	}
};

/**
*
* 判断是否只选中了一行
* 
*/
function getSelectOne(rowDataId){
		var rowId=rowDataId;
		var valObj =getRowId(rowId);
		var idnumber=valObj.split(',');
		var leng=idnumber.length;
		var firstdata=idnumber[0];
		if(leng==1 && firstdata!=""){
			return firstdata;
		}else{
			return "";
		}
};



/**================get datagrid selected row data============*/
/**
*datagrid 表格
**/
function getDataGridSelectedRowsData(datagrid){
	var grid = $.data( datagrid, 'datagrid');
	return grid.getSelectedRowsData();
}
/**
*获取表格行数据
**/
function getDataGridRowData(datagrid, rowIndex){
	var grid = $.data( datagrid, 'datagrid');
	return grid.getRowData(rowIndex);
}

/**================end get datagrid selected row data============*/

/**
 * 3.打开模式窗口.
 * id:窗口的id.
 * title:窗口的标题.
 * url:资源地址.
 */
function openModelWindow(id,title,url,width,height){
	$("body").focus();//防止点击按钮通过键盘的Enter或空格键继续触发.
	var divobj = "<div id='"+id+"'>" +
			"<iframe id='"+id+"' name='"+id+"' width='100%' height='100%' " +
			"scrolling='no' frameborder='0' src='"+
			url+"'></iframe></div>";
	$(document.body).append(divobj);
	$("#"+id+"").window({
		title: title,
		width: width,
		modal: true,
		collapsible: false,
		shadow: false,
		closed: false,
		height: height,
		async:false,
		maximizable: false,
		resizable: false,
		minimizable: false,
		draggable: true,
		onClose:function(){
			$("#"+id+"").remove();
		}
	});
}
function openModelWindowDialog(_id,_title,_url,_width,_height){
	$("body").focus();//防止点击按钮通过键盘的Enter或空格键继续触发.
	var divobj = "<div id='"+_id+"' width='"+_width+"' height='"+_height+"'></div>";
	$.dialog({ 
	    id: _id, 
	    lock: true, 
	    title: _title, 
	    content: divobj, 	
	    width: _width, 
	    height: _height,
	    min: false
	});
	
	$("body").find("div.ui_content").load(_url);
	
}


/**
 * 4.关闭easyui的模式窗口
 * id:窗口的id
 */
function closeModelWindow(id){
	$("#"+id+"").window("close");
	$("#"+id+"").remove();
	//$("body").find("table.ui_border").parent().remove();
	//$("body").find("div#ldg_lockmask").remove();
	//$.dialog.list[id].close();
}

function closeModelWindowDialog(id){
	$.dialog.list[id].close();
}

/**
 * 5.清空查询条件
 */
function toClear(){
	$("#queryForm").find(":text,:password,textarea").val("");
	$("#queryForm").find("select").each(function(){
		$(this).find("option").first().attr("selected",true);
	});
	$("#queryForm").find(":radio").attr("checked",false);
	$("#queryForm").find(":checkbox").attr("checked",false);
}
/**
 * 6. 两次编码，用于解决乱码问题，by Leon 2012年5月30日 11:11:53
 * 相应的后台需要进行两次解码，例如：String file = URLDecoder.decode(URLDecoder.decode(request.getParameter("title"), "UTF-8"),"UTF-8");
 */
function twiEncode(str){
	if(typeof str == "string" && $.trim(str) != ""){
		return encodeURIComponent(encodeURIComponent(str));
	}else{
		return "";
	}
}
/**
 * 设置按钮为不可用 2012年6月11日 17:38:29 by Leon
 * @param jqBtn
 * @return
 */
function disableBtn(jqBtn){
	 //设置按钮的样式。
	jqBtn.removeClass("link_button");
	jqBtn.addClass("link_button_inactive");
	//通过href指定的方法不再被执行。
	jqBtn.attr("href","javascript:void(0)");
	//解除绑定事件。
	jqBtn.unbind("click");
}
/**
 * 设置按钮为可用 2012年6月11日 17:38:37 by Leon
 * @param jqBtn
 * @return
 */
function enableBtn(jqBtn){
	jqBtn.removeClass("link_button_inactive");
	jqBtn.addClass("link_button");
}
/**
 * 7. 提交新增或修改单表到通用控制层 
 * formname	:表单id , 
 * approot_	:项目地址.<%=request.getcontextpath()%>或者${pageContext.request.contextPath} 
 * by xin.huang 2012-05-30
 */
function sub_FromByName(formname, approot_) {
	$.ajax({url:approot_ + "/common/control/executeAJAX.page", type:"POST", data:{jsonStr:$("#" + formname).serialAll("serial")},async:false,cacahe:false,dataType:"text",success:function (resp) {
		if (resp && (resp.indexOf("true") != -1)) {
			alert("数据处理成功!");
			goBack({container:".toolbar_contanier", backSuccess:function () {
				toQuery();
			}});
		}
	}, error:function (err) {
		alert("数据处理失败!");
	}});
}

/**
 * 8. 主从结构的提交
 *  master_id:	主table的id,
 *  table_id:	为从table的id, 
 *  approot_:	项目地址.<%=request.getcontextpath()%>或者${pageContext.request.contextPath} 
 * by xin.huang 2012-05-30
 */
function save_table(master_id, table_id, approot_) {
	var obj = $("#" + master_id).serialAll("object"); //主数据
	var tableData = new Array();
	$("#" + table_id).find("tr").each(function () {
		tableData.push($(this).serialAll("object")); //子表数据
	});
	obj.sub_map_list = tableData;
	if("undefined"==obj.sub_map_list||""==obj.sub_map_list||null==obj.sub_map_list){
		alert("请添加详细数据");
		return;
	}
	var dat = JSON.stringify(obj);
	$.ajax({type:"POST", url:approot_ + "/common/control/executeAJAX.page", data:{jsonStr:dat}, 
	dataType:"text",
	cache:false, 
	success:function (msg) {
		if (msg.indexOf("true") != "-1") {
			alert("数据处理成功!");
			goBack({container:".toolbar_contanier", backSuccess:function () {
				toQuery();
			}});
		} else {
			alert("数据处理失败:"+ msg);
		}
	}, error:function (err) {
		alert("数据处理失败!");
	}});
}

//div_dress_tab
function save_table_tabs(master_id, table_id, approot_) {
	var obj = $("#" + master_id).serialAll("object"); //主数据
	var tableData = new Array();
	tableData.push($("#"+table_id).serialAll("object")); //子表数据
	obj.sub_map_list = tableData;
	if("undefined"==obj.sub_map_list||""==obj.sub_map_list||null==obj.sub_map_list){
		alert("请添加详细数据");
		return;
	}
	var dat = JSON.stringify(obj);
	$.ajax({type:"POST", url:approot_ + "/common/control/executeAJAX.page", data:{jsonStr:dat}, 
	dataType:"text",
	cache:false, 
	success:function (msg) {
		if (msg.indexOf("true") != "-1") {
			alert("数据处理成功!");
			goBack({container:".toolbar_contanier", backSuccess:function () {
				toQuery();
			}});
		} else {
			alert("数据处理失败:"+ msg);
		}
	}, error:function (err) {
		alert("数据处理失败!");
	}});
}

/**
 * 9.table排序 
 * tableid 
 * xhid为序号需要写入的input的ID 
 * by xin.huang 2012-05-30
 */
function setRowIndex1(tableid, xhid) {//显示序号和排序的方法。
	$("#"+tableid).find("tr").each(function (i) {
		$(this).find("td").find("#"+xhid).val(i + 1);
	});
}
/**
 * 10.获得选中的check 的value  
 * amount为操作方式 1为仅能选一个 -1为可多选 
 * by xin.huang 2012-05-30
 */
function getCheckIds1(checkid, amount) {
	var cks = checkSelCheckItem(checkid, amount);
	var type_ids = "";
	if (cks && cks.length > 0) {
		type_ids = type_ids + cks.eq(0).val();
		for (var i = 1; i < cks.length && amount == -1; ++i) {
			type_ids = type_ids + "," + cks.eq(i).val();
		}
	}
	return type_ids;
}


/**
 * 11.主从表数据回传 
 * tableid 为需要回传数据写入的主table的id,
 * type操作类型.insert等. 
 * key:主表主键列名,
 * pid:主表主键列值,
 * approot_项目地址.<%=request.getcontextpath()%>或者${pageContext.request.contextPath} ,
 * tabledivid为table所在div的class 
 * by xin.huang 2012-05-30
 */
function updateQuery(tableid, type, docketid, key, pid, approot_) {
	$.ajax({url:approot_ + "/common/control/executeAJAX.page?jsonStr=[{\"_myType\":\"" + type + "\",\"_myDocketId\":\"" + docketid + "\",\"" + key + "\":\"" + pid + "\"}]",
	 	type:"POST",
	 	async:false, 
	 	cacahe:false,
	 	dataType:"text", 
	 	success:function (respData) {
		var jsonArray = eval("(" + respData + ")");
		$("#" + tableid).serialAll("load", jsonArray);
		var arrayObj = jsonArray.sub_map_list;
		if(arrayObj=="undefined"||arrayObj==""||arrayObj==null||arrayObj==undefined){
			return;
		}
		$.fn.creatorTable("addRow",arrayObj);
		$('.table_body').tableScrollWidth();
	}});
}
function updateQuery1(tableid,divid, type, docketid, key, pid, approot_) {
	$.ajax({url:approot_ + "/common/control/executeAJAX.page?jsonStr=[{\"_myType\":\"" + type + "\",\"_myDocketId\":\"" + docketid + "\",\"" + key + "\":\"" + pid + "\"}]",
	 	type:"POST",
	 	async:false, 
	 	cacahe:false,
	 	dataType:"text", 
	 	success:function (respData) {
		var jsonArray = eval("(" + respData + ")");
		$("#" + tableid).serialAll("load", jsonArray);
		var arrayObj = jsonArray.sub_map_list;
		if(arrayObj=="undefined"||arrayObj==""||arrayObj==null||arrayObj==undefined){
			return;
		}
		$("#"+divid).serialAll("load", arrayObj[0]);
		
	}});
}

//关闭弹出窗口 MYID为窗口ID
function closeDiv(myId){
	closeModelWindow(myId);
}

/**
 * 12.单表数据回传 
 * tableid 为需要回传数据写入的主table或者form或者div的id,
 * type操作类型.insert等. 
 * key:主表主键列名,
 * pid:主表主键列值,
 * approot_项目地址.<%=request.getcontextpath()%>或者${pageContext.request.contextPath} 
 * by xin.huang 2012-05-30
 */
function updateQueryIt(tableid, type, docketid, key, pid, approot_) {
	$.ajax({url:approot_ + "/common/control/executeAJAX.page?jsonStr=[{\"_myType\":\"" + type + "\",\"_myDocketId\":\"" + docketid + "\",\"" + key + "\":\"" + pid + "\"}]",
	   type:"POST",
	   async:false,
	   cacahe:false, 
	   dataType:"text",
	   success:function (respData) {
		var jsonArray = eval("(" + respData + ")");
		$("#" + tableid).serialAll("load", jsonArray);
	}});
}

/**
 * 13.通用删除
 * checkid:复选框id,
 * key:主表主键名,
 * type,
 * docketid ,
 * approot_项目地址.<%=request.getcontextpath()%>或者${pageContext.request.contextPath} 
 * by xin.huang 2012-05-30
 */
function deleteByCode(checkid,key,type,docketid,approot_) {
	var pids = getCheckIds1(checkid, -1);
	alert(pids);
	if ($.trim(pids) == "") {
		return;
	}
	$.ajax({url:approot_ + "/common/control/executeAJAX.page", async:false, type:"POST", data:{jsonStr:"{\"_myDocketId\":\"" + docketid + "\",\"_myType\":\"" + type + "\",\"" + key + "s\":\"" + pids + "\",\"deleteby\":\"" + key + "\"}"},
	 cacahe:false,
	 async:false,
	  success:function (resp) {
		if (resp && (resp.indexOf("true") != -1)) {
			alert("删除成功!");
		}
	}, error:function (err) {
		alert("删除失败!");
	}});
	toQuery();
}
/**
 * 14.转跳页面(新增.修改是会调用)以及绑定返回事件  
 * classname div的class,
 * urladd url地址,
 * btnid返回按钮的id
 * by xin.huang 2012-05-30
 */
function gotourl(classname, urladd, btnid) {
	gotoChildren({container:"." + classname, url:urladd, loadSuccess:function () {
			//alert("加载子页面成功！！！在此可以调用自己传递的方法！！！");
			//给子页面的"返回"按钮添加返回事件。
		$("#" + btnid).bind("click", function () {
				//alert(12);
			goBack({container:"." + classname, backSuccess:function () {
						//unlockall();
						toQuery();
						//alert("返回成功了，在此可以调用自己传递的方法，比如刷新！！！");
			}});
		});
	}});
}
/**
*
* 动态加载图表数据
*/
function loadfusion(divid,swfadd,xmls,width,heigh,refun,approot){
	$(divid).load(approot+"/common/FusionCharts/FusionChartsHTMLRenderer.jsp",{chartSWF: swfadd,strXML: xmls,chartId: "myNext",chartWidth: width,chartHeight: heigh,debugMode:false},refun);
}

/**
 * 弹出窗口  
 * wid:弹出框id,wtitle弹出框标题,弹出框url
 * by xin.huang 2012-06-06
 */
//
function selectsd(wid,wtitle,url,which,height){
  	openModelWindow(wid,wtitle,url,which,height);
}
/**
 * 回调函数必须为  ressd 参数只有json 
 * 该方法为父页面的回调函数调用的方法
 * wid为需要关闭的窗口 tabelid为父table的id
 * restype:0父子都覆盖,1只覆盖父,2只覆盖子
 * by xin.huang 2012-06-06
 */
function ressdjson(json,wid,tableid,restype) {
	closeModelWindow(wid);
	var jsonArray = eval("(" + json + ")");
	if(restype==0){
		$("#"+tableid).serialAll("load", jsonArray);
		var arrayObj = jsonArray.sub_map_list;
		if(arrayObj=="undefined"||arrayObj==""||arrayObj==null||arrayObj==undefined){
			return;
		}
		$.fn.creatorTable("addRow",arrayObj);
		$('.table_body').tableScrollWidth();
	}else if(restype==1){
		$("#orderTable").serialAll("load", jsonArray);
		$('.table_body').tableScrollWidth();
	}else if(restype==2){
		var arrayObj = jsonArray.sub_map_list;
		if(arrayObj=="undefined"||arrayObj==""||arrayObj==null||arrayObj==undefined){
			return;
		}
		$.fn.creatorTable("addRow",arrayObj);
		$('.table_body').tableScrollWidth();
	}
}
/**
 * 选择列表页调用的方法.调用后台进行单据的json的装换,  
 * json为传递到后台的json串 包含参数等等
 * urladd为url地址
 * by xin.huang 2012-06-06
 */
function getsdjson(json,urladd){
	$.ajax({
		url: urladd+'?jsonStr='+json,
		type:"POST",
		//dataType:json,
		cacahe:false,
		dataType:"text",
		success:function(resp){
			parent.ressd(resp);
		},
		error:function(err){
			alert('操作出错!');
		}
	});
}


/**
 * 选择列表页调用的方法.调用后台进行单据的json的装换,   下推时使用
 * json为传递到后台的json串 包含参数等等
 * urladd为url地址
 * by xin.huang 2012-06-06
 */
function getlowjson(json,urladd){
	$.ajax({
		url: urladd+'?jsonStr='+json,
		type:"POST",
		//dataType:json,
		cacahe:false,
		dataType:"text",
		async:false,
		success:function(resp){
			ressd(resp);
		},
		error:function(err){
			alert('操作出错!');
		}
	});
}	

/**
 * 返回json  
 * json为传递到后台的json串 包含参数等等
 * urladd为url地址
 * by xin.huang 2012-06-06
 */
function getajson(json,urladd){
	$.ajax({
		url: urladd+'?jsonStr='+json,
		type:"POST",
		dataType:"text",
		cacahe:false,
		success:function(resp){
			getanalysxml(resp);
		},
		error:function(err){
			alert('操作出错!');
		}
	});
}	

/**
 * 锁定页面所有输入 去除指定标示的控件的触发事件
 * ids为var数组.里面存储控件的id或者class
 * doc为需要锁定控件最大容器
 * by xin.huang 2012-06-07 
 */
function lockall(doc,arr){
   	$(doc).find(":input").each(function(){
	     this.disabled=true;
	     //this.attr({readonly:'true'});
	   });
	$.each( arr, function(i){
		$(arr[i]).unbind();				
	});
}
function unlockall(){
	$(document).ready(function(){
   		$(":input").each(function(){
	     this.disabled=false;
	   });
	});
}
/**
 * 隐藏按钮
 * ids为var数组.里面存储控件的id或者class
 * doc为需要锁定控件最大容器
 * by bobo 2012-06-18 
 */
function hideall(doc,arr){
	$(doc).find(arr).each(function(){
		$(this).hide();				
	});
}

/**
 * 获取源单类型 构建select 
 * 参数说明:docId为docketid type:0为上游单据,1为下游单据
 * by xin.huang 2012-06-07
 */
function getSelectHtml(docId,approot,spanid,type,is_async){
		var jsondat = '{"_myDocketId":"'+docId+'","_businessFlowId":"kceam"}';
		var urladd="";
		if("0"==type){
			urladd = approot+"/common/control/getSourceBillList.page";
		}else if("1"==type){
			urladd = approot+"/common/control/getTargetBillList.page";
		}
		getSourceBillList(jsondat,urladd,spanid,is_async);
}

/**
 * 获取源单类型 构建select 
 *	同步无法获得数据
 * by xin.huang 2012-06-07
 * */
function getSourceBillList(jsondat,urladd,spanid,is_async){
	if(is_async==null||is_async=="null"||is_async==undefined||is_async=="undefined"){
		is_async=true;
	}
	$.ajax({
		type:"POST", 
		url: urladd,
		data:{jsonStr:jsondat}, 
		cache:false,
		dataType:"text",
		async:is_async,
		success:function (msg) {
			//alert(msg);
			$("#"+spanid).html(msg); 
		}, 
		error:function (err) {
		 	alert("加载单据出错");
		}
	});
}



/**
 * 15 通用更新,跳转到更新页面
 * @param checkid
 * @param key
 * @param url_
 * @return
 * 备注:把返回的容器改成了toolbar_contanier  因为用了toolbar
 */
function updateByCode(checkid,key,url_) {
	var pid=getCheckIds1(checkid,1);
	if ($.trim(pid) == "") {
		return;
	}
	gotourl("toolbar_contanier",url_+"?type=update&"+key+"="+pid,"btn_close");
}
/**
 * 16 导出excel
 * @return
 */
function dataTableToExcel(approot_){
	var title=twiEncode($("title").html());
	var url = approot_+"/commones/DynQuAction/exportExcel.page?title="+title; 
	  	 $('#queryForm').form('submit', {
	     "url": url,
	     onSubmit:function(){		    
	     },
	    success:function(responseText){	
    			    					    											
	    } 
	});
}

/**
 * 向body节点缓冲数据. by Leon 2012年6月7日 08:40:38
 * @param key
 * @param value
 * @return
 */
function setDataCache(key, value){
	if(typeof key == "string" && $.trim(key) != ""){
		$.data(document.body, key, value);
	}
}
/**
 * 想body节点获得缓冲数据. by Leon 2012年6月7日 08:44:35
 * @param key
 * @return
 */
function getDataCache(key){
	if(typeof key == "string" && $.trim(key) != ""){
		return $.data(document.body, key);
	}
}


/**
 * 停用按钮。 by Leon 2012年6月12日 10:16:11
 * @param buttonId
 * @return
 */
function disableButton(buttonId){
	if($("#"+buttonId+"_hidden")[0]){
		$("#"+buttonId).parent().hide();
		$("#"+buttonId+"_hidden").parent().show();
	}else{
		var btnHtml = $("#"+buttonId).parent().html()
			.replace(buttonId,buttonId+"_hidden")
			.replace("link_button","link_button_inactive");
		var cloneObj = $("#"+buttonId).parent().clone().html(btnHtml);
		$("#"+buttonId).parent().before(cloneObj);
		$("#"+buttonId).parent().hide();
	}
}
/**
 * 启用按钮。by Leon 2012年6月12日 10:16:35
 * @param buttonId
 * @return
 */
function enableButton(buttonId){
	$("#"+buttonId).parent().show();
	$("#"+buttonId+"_hidden").parent().hide();
}
/**
 * 锁住工作区页面，使其变为等待数据加载状态。
 * @return
 */
function blockUI(msgContent){
	if (!msgContent){
		msgContent = '正在处理，请稍候...';
	}
	$("<div class=\"datagrid-mask\"></div>").css({display:"block", width:"100%",height:$(window).height()}).appendTo("body");
	$("<div class=\"datagrid-mask-msg\"></div>").html(msgContent).appendTo("body").css({display:"block",left: ($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2}); 
}
/**
 * 释放工作区页面，由数据加载状态变为普通状态。
 * @return
 */
function unblockUI(){
	$(".datagrid-mask-msg").remove();
	$(".datagrid-mask").remove();
}

/**
 * 检查是否仅选择一个条目，返回一个已选checkbox的jquery数组对象
 * @param checkboxName 列表中checkbox的name
 * @param maxSelSize 最大允许选择的记录数，小于1表示不限制
 */
function checkSelCheckItem(checkboxName, maxSelSize){
	var cks = $("#ds_list input[name=" + checkboxName + "]").filter("input:checked");
	if (cks.length == 0){
		alert("提示信息：请选择一条记录!");
		return;
	}
	//如果所选个数超过最大允许个数
	if (maxSelSize > 0 && cks.length > maxSelSize){
		alert("提示信息：只允许选择" + maxSelSize + "条记录!");
		return;
	}
	return cks;
}



/**
 * 审核操作
 * @param myDocketId 单据id
 * @param myKey      主键key
 * @param auditFlag  更新的状态
 * @param _root_path 应用路径
 */
function auditBean(myDocketId,myKey,auditFlag,_root_path) {
	var pids=getCheckIds(-1);
	if($.trim(pids)==''){
		return ;
	}

	if(!confirm("确定要审核吗?")){
		return;
	}
				
	var sub_map_list = "[";
	var pidsArray=pids.split(",");
	if(pids.indexOf("审核")>=0){
		for(var i=0;i<pidsArray.length;){
			var pid = pidsArray[i];
			if(i!=pidsArray.length-1){
				sub_map_list+="{\""+myKey+"\":\""+pid+"\",\"audit_state\":\""+auditFlag+"\"},";
			}else{
				sub_map_list+="{\""+myKey+"\":\""+pid+"\",\"audit_state\":\""+auditFlag+"\"}";
			}
			i=i+2;
		}
		sub_map_list=sub_map_list.substring(0,sub_map_list.lastIndexOf(","))
		sub_map_list += "]";
		//alert("333"+pid);
	}else{
		for(var i=0;i<pidsArray.length;i++){
			var pid = pidsArray[i];
			if(i!=pidsArray.length-1){
				sub_map_list+="{\""+myKey+"\":\""+pid+"\",\"audit_state\":\""+auditFlag+"\"},";
			}else{
				sub_map_list+="{\""+myKey+"\":\""+pid+"\",\"audit_state\":\""+auditFlag+"\"}";
			}
		}
		sub_map_list += "]";
		//alert("66"+pid);
	}
	
	
	//alert(sub_map_list);
	$.ajax({
		url:_root_path+"/common/control/executeAJAX.page",
		async: false,
		type:"POST",
		data:{jsonStr:"{\"_myDocketId\":\""+myDocketId+"\",\"_myType\":\"send\",\"sub_map_list\":"+sub_map_list+"}"},
		cache:false,
		dataType:"text",
		success:function(resp){
			//alert(resp);
			if(resp && (resp.indexOf('true')>=0) ){
				alert("操作成功!");					
			}else {
				alert("操作失败!");
			}
		},
		error:function(err){
			alert('操作出错!');
		}
	});
	toQuery();
}
/**
 * 单据送审 审核
 * @param approot_
 * @param docket_id单据ID
 * @param sql_id	SQLID
 * @param idName	主键name
 * @param idValue	逐渐value
 * @param auditStatusName	状态name
 * @param auditStatusValue	状态value
 * @param auditUserName	送审/审核用户name
 * @param auditUserValue	送审/审核用户value
 * info	送审/审核
 */
function on_send(approot_,docket_id,sql_id,idName,idValue,auditStatusName,auditStatusValue,auditUserName,auditUserValue,info){
	var url_ = approot_ + "/common/control/executeAJAX.page";
	var jsonStr = '{"_myDocketId":"' + docket_id + '","_myType":"update","' + idName + 's":"' + idValue + '","updateby":"' + idName + '","'+auditStatusName+'":"'+auditStatusValue+'","'+auditUserName+'":"'+auditUserValue+'"}';
	$.ajax({
		 url:url_, 
		 async:false,
		 type:"POST", 
		 data:{jsonStr:jsonStr},
		 cacahe:false,
		 async:false,
		 success:function (resp) {
			 if (resp && (resp.indexOf("true") != -1)) {
					alert(info+"成功!");
					toQuery();
			 }
		 },
		 error:function (err) {
			alert(info+"失败!");
		 }
	});
}
/**
 * @author haibing.xiao
 * @see 已送审 2，已经审核 3 查询事件
 * @requires obj ,s_audit_state,arr1,arr2
 * 
 * */
function auditIsSendQuery(obj,audit_states,arr1,arr2){
	if(audit_states==''){
		return ;
	}
	if($(obj).attr("checked")){
		   // alert(1);
			var s_audit_states=parseInt(audit_states)+1;
			$("input[name=audit_state]").val(s_audit_states);
			if(audit_states=="1"){
				    for(var i=0;i<arr1.length;){
				        $("#"+arr1[i]).hide();
				    	i=i+1;
				    }
						//$("#btnId3").hide();
			} 
			for(var j=0;j<arr2.length;){
				$("#"+arr2[j]).hide();
				j=j+1;
			}
		 
	}else{
		//alert(2);
		$("input[name=audit_state]").val(audit_states);
		for(var i=0;i<arr1.length;){
	        $("#"+arr1[i]).show();
	    	i=i+1;
	    }
		for(var j=0;j<arr2.length;){
			$("#"+arr2[j]).show();
			j=j+1;
		}
	}
	 toQuery();
}

/*****************
 * 提交单据
 * @param url 请求地址
 * @param paramObj 参数对象
 * @param succback 成功后的回调函数
 */
function ajax_post(_url,paramObj,succback){
	var dat= JSON.stringify(paramObj);
	$.ajax({
		   type: "POST",
		   url:_url,
		   data: {jsonStr:dat},
		   success: succback,
		   error:function(err){
			  	alert('提交数据出现错误!['+err+']');
		   }
   });
}		
/****************************
 * ------------------
 * 弹出图片选择
 * @param popId,url,dialog_width,dialog_heigh 
 * callMenuTreeImages(image_path,image_id)
 * ---------------------------
 * */
function menuTreeImages(popId,url,dialog_width,dialog_heigh){
	var name = "图片选择列表";
	openModelWindow(popId,name,url,dialog_width,dialog_heigh);  
}
/***
 * easyList 列表导出-不分页导出
 * @param webapp ${pageContext.request.contextPath},_source_url 'kceam/purchase/orderForm/purchase_orderform_query_list.jsp',_isPagerList (1 分页/0 不分页)
 */
function export_toExcel(webapp,_source_url,_isPagerList){
	
	  var json =$("#queryForm").serialAll("object");
	  json.task='kcexport';
	  json.source_url=_source_url;
	  json.isPagerList="0";
      alert(JSON.stringify(json));
      var dat =JSON.stringify(json);
	  $.ajax({
			url:webapp+'/common/menucontrol/menuControl.page',
			type:'POST',
			dataType:'text',
			data:{jsonStr: dat},
			async:false,
			success:function(resp){
				alert(resp);
				window.location.href=resp;
			},
			error:function(err){
				alert(err);
		    }

		  });
}

/**
 * 可编辑表格操作。 by Leon 2012年10月17日 13:53:14
 */
//添加行 datas:增加行的值的数组对象。gridObj:DataGrid对象。
function addRows(datas, gridObj){
	gridObj.appendRow(datas);
}
//删除行
function delRows(gridObj){
	gridObj.deleteSelectedRows();
}
//上移行
function upRowIndex(gridObj){
	gridObj.upSelectedRows();
}
//下移行
function downRowIndex(gridObj){
	gridObj.downSelectedRows();
}

/**
 * 单据通用操作方法实现。2012年11月20日 17:27:38 by Leon
 */

//跳转到新增页面。
function toAdd(url){
	var rurl = "add.jsp";
	if(url){//如果传递了刷新的地址
		rurl = url;
	}
	api.data = null;
	api.reload(this,rurl);
}
//跳转到 修改 页面。
function toModify(url){
	var rurl = "modify.jsp";
	if(url){//如果传递了刷新的地址
		rurl = url;
	}
	var dockectObj = $("div[docket_code]").eq(0).serialAll("object");
	api.data = dockectObj;
	api.reload(this,rurl);
}
//删除，callBack:删除的回调方法。如果没有传递，就使用默认的回调方法
function doDelete(callBack){
	var docketid = $("div[docket_code]").eq(0).attr("docket_code");
	var dockectObj = [];
	dockectObj.push($("div[docket_code]").eq(0).serialAll("object"));
	//1:提示是否删除。
	jQuery.dialog({
		title:"确认是否继续",
		icon:"confirm.gif",
		content:"确认是否继续该操作？",
		cancelVal: "关闭",
		cancel: true,
		ok:function(){
			var obj={};
			obj._docket = docketid;
			obj.delDate = dockectObj;
			try{
				if(callBack){//如果传递了回调方法。
					$.saveDocket('remove',callBack,obj);
				}else{
					$.saveDocket('remove',deleteResult,obj);
				}
			}catch(eee){}
			return true;
		},
		lock:true
	});
}
//删除的回调方法。
function deleteResult(data){
	if(data.state == true || data.state == "true"){
		jQuery.dialog({
			title:"提示信息：",
			icon: "success.gif",
			content: data.message,
			cancelVal: "关闭",
			cancel: function(){
				toAdd();//跳转到新增页面。
			},
			lock:true
		});
		W.toQuery();//刷新父页面
	}else{
		jQuery.dialog({
			title:"提示信息：",
			icon: "error.gif",
			content: data.message,
			cancelVal: "关闭",
			cancel: true,
			lock:true
		});
	}
}
//禁用ToolBar按钮。
function disableBtns(params){
	$.each(params.split(","),function(){
		$(".toolbar").toolBar("disable",this);
	});
}
//启用ToolBar按钮
function enableBtns(params){
	$.each(params.split(","),function(){
		$(".toolbar").toolBar("enable",this);
	});
}
function exportData(){
	var href = window.location.href+"";
		href = href.substr (0,href.lastIndexOf("."));
		href = href +"_export.jsp";
		var defValue = "";
		var param = "?1=1";
		var colName = ""; 
		//获取搜索框的值
		$(".dropdownlist_normal ul li").each(function(){  
			 if($(this).find(".menuItem_icon_selected").parent().html() && $(this).find(".menuItem_icon_selected").parent().html() != null){
				 defValue = $(this).find(".menu_label_normal").html() ;
			 }
		});
		$(".toolbar_searchbox :input").each(function(){
			if($(this).val()){ //有title 
				if($(this).val() != defValue){
					colName = $(this).attr("name");
					param += "&"+$(this).attr("name")+"="+encodeURIComponent (encodeURIComponent ( $(this).val()));
				}
			} 
		});
	
		$("#ul_conditions_center :input").each(function(){
			if( colName != $(this).attr("name")){
				param += "&"+$(this).attr("name")+"="+encodeURIComponent (encodeURIComponent ( $(this).val()));
			}
			
		}); 
	window.location.href= href+param;
}