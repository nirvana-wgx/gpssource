/**
 * 反序列化container
 * @param container：表单容器
 * @param data：
 * @param initGrid：如果遇到需要反序列化表格时，initGrid=true插入的数据行作为表格的初始行（不作为新增行）
 */

function deserialize(container, data, initGrid){
	$(container).find("[container_type]").each(function(){
		switch($(this).attr("container_type")){
		case "form":
			deserializeForm(this, data);
			break;
		case "grid":
			deserializeDatagrid(this, data, initGrid);
			break;
		}
	});
};

/**
 * 反序列化container内部的表格
 * @param container
 * @param data
 * @param initGrid
 */
function deserializeDatagrid(container, data, initGrid){
	$(container).find(".datagrid_pane").each(function(){
		var prevName = $(this).attr("docket_prev");//表格序列化用的单据前缀
		var gridData = eval("data."+prevName);
		if(!$.isArray(gridData)){
			window.console.log("用于反序列化表格的数据不是数组！不能反序列化");
			return;
		}
		if($(this).data("datagrid")){
			$(this).data("datagrid").clear();
			$(this).data("datagrid").appendRow(gridData, initGrid);
		}else{
			var gridInst = $(this).datagrid();
			gridInst.appendRow(gridData, initGrid);
		}
	});
};

/**
 * 反序列化普通的表单
 * @param container：包含表单控件的容器
 * @param data
 */
function deserializeForm(container, data){
	var prevName = $(container).attr("docket_prev");//容器内的所有表单控件可以共用一个单据前缀
	if(prevName){
		data = eval("data."+prevName);
	}
	$(container).find(":input,select,textarea").not(":checkbox,:radio,[unfillback='true']").each(function(){
		var name = $(this).attr("deserialize_expr") || $(this).attr("name");
		if(name != "undefined"){
			$(this).val(Calculator.parse(name, data));
		}
	});
	$(container).find(":radio").not("[unfillback='true']").each(function(){
		var name = $(this).attr("deserialize_expr") || $(this).attr("name");
		if(name != "undefined"){
			if($(this).attr("value") == Calculator.parse(name, data)){
				$(this).attr("checked",true);
			}
		}
		name = null;
	});
	$(container).find(":checkbox").not("[unfillback='true']").each(function(){
		var name = $(this).attr("deserialize_expr") || $(this).attr("name");
		if(name != "undefined"){
			var value = Calculator.parse(name, data);
			if($.isArray(value)){
				if(isInArray($(this).val(), value)){
					$(this).attr("checked", true);
				}else{
					$(this).removeAttr("checked");
				}
			}else{
				if(isInArray($(this).val(), value.toString().split(","))){
					$(this).attr("checked", true);
				}else{
					$(this).removeAttr("checked");
				}
			}
		}
	});
};

/**
 * 表单控件获取值的方法（反格式化）
 */
$.fn.getValue = function(){
	var value = $(this).val();
	var formatType = $(this).attr("ds_data_type");
	if(formatType){
		try{
			var formatPattern = $(this).attr("formatter");
			switch(formatType){
			case "number":
				value = toNumber(value, formatPattern);
				break;
			case "date":
				var df =  new DateFormat();
				value = df.parseDate(value, formatPattern);
				break;
			}
		}catch(e){
			window.console.log($(this) + " toData is wrong!");
		}
	}
	return value;
};

/**
 * 序列化容器内的表单控件
 * @param container
 * @returns {___anonymous3585_3586}
 */
function serialize(container){
	var result={};
	$(container).find("[container_type]").each(function(){
		switch($(this).attr("container_type")){
		case "form":
			$.extend(true, result, getFormValue(this));
			break;
		case "grid":
			$.extend(true, result, serializeGrid(this));
			break;
		}
	});
	//重新变量表单，根据序列化表达式serialize_expr计算结果。
	var resultCopy = $.extend({}, result);
	$(container).find("[container_type='form']").each(function(){
		var prev=typeof($(this).attr("docket_prev"))=="undefined" ? "" : $(this).attr("docket_prev");
		$(this).find("[serialize_expr]").each(function(){
			var expr = $(this).attr("serialize_expr");
			var field = $(this).attr("bind_field");
			var value = Calculator.parse(expr, resultCopy);
			eval("result."+field+"=value");
		});
	});
	return result;
};
/**
 * 获取普通表单的值
 * @param container
 * @returns {___anonymous3996_3997}
 */
function getFormValue(container){
	var result = {}, objStr="result.";
	var prevName = $(container).attr("docket_prev");//容器内的所有表单控件可以共用一个单据前缀
	if(prevName){
		var ns = prevName.split(".");
		var expr = "";
		for(var i=0,len=ns.length;i<len;i++){
			expr += ns[i];
			if(typeof(eval("result."+expr))=="undefined"){
				eval("result."+expr+"={}");
			}
			expr += ".";
		}
		objStr += expr;
		ns = expr = null;
	}
	$(container).find(":text,:password,:radio,textarea,input:hidden,select").not("[unserial='true']").each(function(){
		var name = $(this).attr("bind_field") || $(this).attr("name");
		var ns = name.split(".");
		var expr = "";
		for(var i=0,len=ns.length-1;i<len;i++){
			expr += ns[i];
			if(typeof(eval(objStr+expr))=="undefined"){
				eval(objStr+expr+"={}");
			}
			expr += ".";
		}
		expr += ns[ns.length-1];
		eval(objStr+expr+"='"+$(this).val()+"'");
		name = ns = expr = null;
	});
	$(container).find(":checkbox").not("[unserial='true']").each(function(){
		var name = $(this).attr("bind_field") || $(this).attr("name");
		var value = $(this).val();
		var ns = name.split(".");
		var expr = "";
		for(var i=0,len=ns.length-1;i<len;i++){
			expr += ns[i];
			if(typeof(eval(objStr+expr))=="undefined"){
				eval(objStr+expr+"={}");
			}
			expr += ".";
		}
		expr += ns[ns.length-1];
		if($(this).attr("unselectvalue")){//是非复选框
			if(!$(this).attr("checked")){
				value = $(this).attr("unselectvalue");
			}
			eval(objStr+expr+"='"+value+"'");
		}else{//普通复选框
			if($(this).attr("checked")){
				var prevValue = eval(objStr+expr);
				if(typeof(eval(objStr+expr))=="undefined"){
					eval(objStr+expr+"=[]");
				}
				if($.isArray(eval(objStr+expr))){
					eval(objStr+expr+".push("+value+")");
				}
			}
		}
		name = value = ns = expr = null;
	});
	return result;
};

/**
 * 序列化表格
 * @param container
 * @returns {add:[], remove:[], modify:[]}
 */
function serializeGrid(grid){
	if(grid &&　$(grid).data("datagrid")){
		var result = {}, objStr="result";
		var prevName = $(grid).attr("docket_prev");//容器内的所有表单控件可以共用一个单据前缀
		grid = $(grid).data("datagrid");
		if(prevName){
			objStr += ".";
			var ns = prevName.split(".");
			for(var i=0,len=ns.length-1;i<len;i++){
				objStr += ns[i];
				if(typeof(eval(objStr))=="undefined"){
					eval(objStr+"={}");
				}
				objStr += ".";
			}
			objStr += ns[ns.length-1];
			eval(objStr+"={}");
			ns = null;
		}
		
		var delData=grid.getDeleteRows(); //删除数据
		var updataData=grid.getUpdatedRowsData(); //修改数据
		var addData=grid.getAddedRowsData(); //新增数据
		$.each(addData, function(i,_dat){//过滤新增数据中的空数据
			for(var key in _dat){
				if(!_dat[key]||_dat[key]==''){
					delete _dat[key];
				}
			}	
		});
		$.each(updataData,function(i,_dat){
			for(var key in _dat){
				if(!_dat[key]||_dat[key]==''){//修改数据中的空值置为“NA”
					_dat[key]="NA";
				}
			}	
		});
		eval(objStr+"={add: addData, remove: delData, modify: updataData}");
		return result;
	}else{
		return null;
	}
	
};