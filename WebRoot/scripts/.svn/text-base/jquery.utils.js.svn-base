/**
* 通用js集合
**/

/**
 * 判断IE浏览器版本
 */
//IE7以下包括IE7
$.isIE7Le = function() {
//变量为IE6、IE7
	return $.browser.msie && 
							 ($.browser.version == 6 || $.browser.version == 7);
};

//IE8以下包括IE8
$.isIE8Le = function() {
//变量为IE6、IE7
	return $.browser.msie && 
							 ($.browser.version == 6 || $.browser.version == 7 || $.browser.version == 8);
};

//IE9以下，只包括IE8、IE9
$.isIE9Le = function() {
//变量为IE8、IE9
	return $.browser.msie && 
							 ($.browser.version == 8 || $.browser.version == 9);
};

/**
 * 格式化后的数字字符串类型转数字型
 */
$.string2Number = function(str){
	var result = str.replace(",", "");
	return parseFloat(result);
};

/**
 * 兼容各浏览器的阻止事件冒泡的方法
 * @param event
 */
function stopPropagation(event){
	if(event.stopPropagation){
		event.stopPropagation();
	}else{
		event.cancelBubble = true;
	}
}

/**
 * 兼容各浏览器的阻止默认操作方法
 * @param event
 */
function preventDefault(event) {	
	if (event.preventDefault) {
		event.preventDefault();
	} else {
		event.returnValue = false;
	}
};

/**
 * 判断obj是一个空的object {}
 * @param obj
 * @returns {Boolean}
 */
function isEmptyObject( obj ) { 
	for ( var name in obj ) { 
		return false; 
	} 
	return true; 
} 

/**
 * 判断obj是数组array的成员
 * @param obj
 * @param array
 */
function isInArray(obj, array){
	for(var i=0,len=array.length;i<len;i++){
		if(array[i]===obj){
			return true;
		}
	}
	return false;
}
/**
 * 按钮状态规则
 */
var compare_rule = {
	btn_filter : {
		label: "高级查询",
		necessary_condition:[
			{
				model: ["view"],
				states:{
				}
			}
		]
	},
	btn_add : {
		label: "新增",
		necessary_condition:[
			{
				model:["view"],
				states:{
				}
			}
		]
	},
	btn_remove : {
		label: "删除",
		necessary_condition:[
			{
				model: ["view"],
				states:{//各状态必须满足的条件
					verify_state: ["draft", "rejected"],
					freeze_state: ["unfreeze"]
				}
			}
		]
	},
	btn_modify : {
		label: "修改",
		necessary_condition:[
			{
				model: ["view"],
				states:{
					verify_state: ["draft", "rejected"],
					freeze_state: ["unfreeze"]
				}
			}
		]
	},
	btn_open : {
		label: "打开",
		necessary_condition:[
			{
				model: ["view"],
				states:{
				}
			}
		]
	},
	btn_save : {
		label: "保存",
		necessary_condition:[
			{
				model: ["add", "edit"],
				states:{
					freeze_state : ["unfreeze"],
					close_state : ["opened"]
				}
			}
		]
	},
	btn_cancel : {
		label: "取消",
		necessary_condition:[
			{
				model: ["edit"],
				states:{
					freeze_state : ["unfreeze"],
					close_state : ["opened"]
				}
			}
		]
	},
	btn_copy: {
		label: "复制",
		necessary_condition:[
			{
				model: ["view"],
				states:{
				}
			}
		]
	},
	btn_send: {
		label: "送审",
		necessary_condition:[
			{
				model: ["view"],
				states:{
					verify_state: ["draft", "reject"],
					freeze_state : ["unfreeze"]
				}
			}
		]
	},
	btn_approve : {
		label: "审核",
		necessary_condition:[
			{
				model: ["view"],
				states:{
					verify_state: ["commit"],
					freeze_state : ["unfreeze"]
				}
			}
		]
	}
};
/**
 * 传入按钮的模式和各状态，与按钮状态规则做比较，返回按钮是否可用。
 * {
	 btn:"...",
	 model:"add"|"edit"|"view",
	 states:{
	     verify_state : "draft"|"commit"|"verified"|"rejected",
	     dispose_state : "undisposed"|"disposing"|"disposed",
	     freeze_state : "unfreeze"|"freezed",
	     tally_state : "untally"|"tally",
	     close_state : "opened"|"closed"
	 }
	}
 * @param btn: btnid
 * @param model
 * @param states
 */
function isEnabled(btn, model, states){
	var rule = compare_rule[btn];//按钮的规则
	if(!rule){//没有定义规则的全部默认可用
		return true;
	}
	var conds = rule.necessary_condition;
	for(var i=0,len=conds.length;i<len;i++){//遍历规则的条件
		var cond = conds[i];
		if(isInArray(model, cond["model"])){//编辑模式匹配
			for(var stateName in states){
				if(cond["states"][stateName] !== states[stateName]){//规则中对此状态的限制与按钮的状态不相等
					return false;
				}
			}
		}else{
			return false;
		}
	}
	return true;
}
/**
 * 
 * @param btn
 * @param enable
 */
function setBtnEnable(btn, enable){
	if(enable && $(btn).hasClass("inactive")){
		$(btn).removeClass("inactive");
	}else{
		$(btn).addClass("inactive");
	}
}
/**
 * 控制工具条按钮状态
 */
function dealToolbarState(model, states){
//	var model = getModel();
//	var states = getStates();
	$(".toolbar").each(function(){
		$(this).children("a").each(function(){
			setBtnEnable(this, isEnabled($(this).attr("id"), model, states));
		});
	});
}