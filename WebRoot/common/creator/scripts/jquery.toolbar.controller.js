/**
 * 单据按钮状态常量
 */
var STATES_CONSTANT = {
		VERIFY_STATE : {
			DRAFT: "1",
			COMMIT: "2",
			VERIFIED: "3",
			REJECTED: "4"
		},
		DISPOSE_STATE: {
			UNDISPOSED:"0",
			DISPOSING:"1",
			DISPOSED:"2"
		},
		FREEZE_STATE: {
			UNFREEZE:"0",
			FREEZED:"1"
		},
		TALLY_STATE: {
			UNTALLY:"0",
			TALLY:"1"
		},
		CLOSE_STATE: {
			OPENED:"0",
			CLOSED:"1"
		}
};
/**
 * 编辑模式常量
 */
var MODEL_CONSTANT = {
		ADD:"0",
		EDIT:"1",
		VIEW:"2"
};
/**
 * 按钮状态规则
 */
var compare_rule = {
		btn_filter : {//按钮id
			label: "高级查询",//按钮显示文本
			necessary_condition:[//按钮可用必须满足的条件。数组对象之间是或的关系
				{
					model: [MODEL_CONSTANT.VIEW],//按钮可用的编辑模式
					states:{//按钮可用必须满足的状态条件，必须全部满足
					}
				}
			]
		},
		btn_add : {
			label: "新增",
			necessary_condition:[
				{
					model:[MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{
					}
				}
			]
		},
		btn_delete : {
			label: "删除",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{//各状态必须满足的条件，必须全部满足
						verify_state: [STATES_CONSTANT.VERIFY_STATE.DRAFT, STATES_CONSTANT.VERIFY_STATE.REJECTED],
						freeze_state: [STATES_CONSTANT.FREEZE_STATE.UNFREEZE]
					}
				}
			]
		},
		btn_modify : {
			label: "修改",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{
						verify_state: [STATES_CONSTANT.VERIFY_STATE.DRAFT, STATES_CONSTANT.VERIFY_STATE.REJECTED],
						freeze_state: [STATES_CONSTANT.FREEZE_STATE.UNFREEZE]
					}
				}
			]
		},
		btn_open : {
			label: "打开",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{
					}
				}
			]
		},
		btn_save : {
			label: "保存",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.ADD, MODEL_CONSTANT.EDIT],
					states:{
						verify_state: [STATES_CONSTANT.VERIFY_STATE.DRAFT, STATES_CONSTANT.VERIFY_STATE.REJECTED],
						freeze_state : [STATES_CONSTANT.FREEZE_STATE.UNFREEZE],
						close_state : [STATES_CONSTANT.CLOSE_STATE.OPENED]
					}
				}
			]
		},
		btn_abort : {
			label: "取消",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.EDIT,MODEL_CONSTANT.ADD],
					states:{
						freeze_state : [STATES_CONSTANT.FREEZE_STATE.UNFREEZE],
						close_state : [STATES_CONSTANT.CLOSE_STATE.OPENED]
					}
				}
			]
		},
		btn_copy: {
			label: "复制",
			necessary_condition:[
				{
					model:[MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{
					}
				}
			]
		},
		btn_send: {
			label: "送审",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{
						verify_state: [STATES_CONSTANT.VERIFY_STATE.DRAFT, STATES_CONSTANT.VERIFY_STATE.REJECTED],
						freeze_state : [STATES_CONSTANT.FREEZE_STATE.UNFREEZE]
					}
				}
			]
		},
		btn_audit : {
			label: "审核",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{
						verify_state: [STATES_CONSTANT.VERIFY_STATE.COMMIT,STATES_CONSTANT.VERIFY_STATE.VERIFIED],
						freeze_state : [STATES_CONSTANT.FREEZE_STATE.UNFREEZE]
					}
				}
			]
		},	
		btn_account : {
			label: "记账",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{
						verify_state: [STATES_CONSTANT.VERIFY_STATE.VERIFIED],
						freeze_state : [STATES_CONSTANT.FREEZE_STATE.UNFREEZE],
						tally_state: [STATES_CONSTANT.TALLY_STATE.UNTALLY]
					}
				}
			]
		},
		btn_print : {
			label: "打印",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.ADD,MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{
					}
				}
			]
		},
		btn_export : {
			label: "导出",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{
					}
				}
			]
		},
		btn_cancel : {
			label: "返回",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.ADD,MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{
					}
				}
			]
		},
		btn_addrow : {
			label: "新增行",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.ADD,MODEL_CONSTANT.EDIT],
					states:{
						//verify_state: [STATES_CONSTANT.VERIFY_STATE.DRAFT, STATES_CONSTANT.VERIFY_STATE.REJECTED],
						//freeze_state: [STATES_CONSTANT.FREEZE_STATE.UNFREEZE]
					}
				}
			]
		},
		btn_deleterow : {
			label: "删除行",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.ADD,MODEL_CONSTANT.EDIT],
					states:{
						//verify_state: [STATES_CONSTANT.VERIFY_STATE.DRAFT, STATES_CONSTANT.VERIFY_STATE.REJECTED],
						//freeze_state: [STATES_CONSTANT.FREEZE_STATE.UNFREEZE]
					}
				}
			]
		},
		
		//<--[胡亚辉添加的]-->
		btn_beforepage : {
			label: "前翻",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{}
				}
			]
		},
		btn_afterpage : {
			label: "后翻",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.EDIT,MODEL_CONSTANT.VIEW],
					states:{}
				}
			]
		},
		btn_before : {
			label: "前续",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{}
				}
			]
		},
		btn_after : {
			label: "后续",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{}
				}
			]
		},
		btn_transform : {
			label: "转单",
			necessary_condition:[
				{
					model: [MODEL_CONSTANT.VIEW],
					states:{}
				}
			]
		}
};
/**
 * 未选中数据是有效按钮(特殊滴)(Coollf)
 */
var NO_DATA_AVAILABLE_BUTTONS=[
           'btn_search','btn_add','btn_filter','btn_export'
    ];

/**
 *状态中文值映射表 
 */
var $STATE_MAPPING={
	'草稿': "1",
	'已提交': "2",
	'已审核': "3",
	'已驳回': "4",
	'未处理':"0",
	'处理中':"1",
	'已处理':"2",
	'未冻结':"0",
	'已冻结':"1",
	'未记账':"0",
	'已记账':"1",
	'未关闭':"0",
	'已关闭':"1"
};

/**
 * 传入按钮的模式和各状态，与按钮状态规则做比较，返回按钮是否可用。MODEL_CONSTANT.VIEW
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
	//return true;//暂时全部返回true，待页面提供了编辑模式和状态值再开放此方法。
	
	var rule = compare_rule[btn];//按钮的规则
	if(!rule){//没有定义规则的全部默认可用
		return true;
	}
	var conds = rule.necessary_condition;
	for(var i=0,len=conds.length;i<len;i++){//遍历规则的条件
		var cond = conds[i];
		if(isInArray(model, cond["model"])){//编辑模式匹配
			for(var stateName in states){
				if(typeof(cond["states"][stateName])=="undefined"){
					break;
				}
				if(!isInArray(states[stateName], cond["states"][stateName])){//规则中对此状态的限制与按钮的状态不相等
				//if(cond["states"][stateName] !== states[stateName]){//规则中对此状态的限制与按钮的状态不相等
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
 * 设置按钮可以/不可以的样式
 * @param btn
 * @param enable
 */
function setBtnEnable(btn, enable){
	if(!enable){
		$(btn).addClass("inactive");
		$(btn).setReadOnly(true);
	}else{
		$(btn).removeClass("inactive");
		$(btn).setReadOnly(false);
	}
}

/**
 * 控制工具条按钮状态
 * @param toolbar:工具条容器(js或jquery对象),
 * @param model:"add"|"edit"|"view",
 * @param states:{
 *	     verify_state : "draft"|"commit"|"verified"|"rejected",
 *	     dispose_state : "undisposed"|"disposing"|"disposed",
 *	     freeze_state : "unfreeze"|"freezed",
 *	     tally_state : "untally"|"tally",
 *	     close_state : "opened"|"closed"
 *	 }
 */
function controlToolbarState(toolbar, model, states){
	try{
		if(window.console && window.console.log){
			window.console.log('<--------------------[按钮控制 BEGIN]---------------->');
			window.console.log(toolbar);
			window.console.log(model);
			window.console.log(states);
			window.console.log('<--------------------[按钮控制 END  ]---------------->');
		}
	}catch(e){}
	
	$(toolbar).each(function(){
		$(this).children("a[controlstate='true']").each(function(){
			setBtnEnable(this, isEnabled($(this).attr("id"), model, states));
		});
	});
}

/******************************************************
 * 
 * @param toolbar 工具条
 * @param model  编辑模式
 * @param datas 选中的数据
 */
function controlListPageToolbarState(toolbar, model, datas){
	$(toolbar).each(function(){
		$(this).children("a").each(function(){
			if(!datas || !datas.length || datas.length==0){//没有选中行 ,只能显示高级查询和导出
				if(isInArray($(this).attr("id"),NO_DATA_AVAILABLE_BUTTONS)){//特殊情况
					setBtnEnable(this,true);
				}else{					
					setBtnEnable(this,false);
				}
			}
			if(datas && datas.length && datas.length==1){//选中一条数据的情况
				setBtnEnable(this, isEnabled($(this).attr("id"), model, getStatesByData(datas[0])));
			}
			if(datas && datas.length && datas.length>1){//选中多条记录.
				var key=true;
				var $_this=this;
				$.eche(datas,function(){
					key= key && isEnabled($($_this).attr("id"), model, getStatesByData(this));
				});
				setBtnEnable(this,key);
			}
		});
	});
}

/***
 * 获取单据状态..
 * @param data
 */
function getStatesByData(data){
	var sta={};
	var erg=/\d+$/; //匹配数字
	if(!data){
		return sta;
	}
	var verify_state=data['audit_state'];
	var dispose_state=data['deal_state'];
	var freeze_state=data['frozen_state'];
	var tally_state=data['tally_state'];
	var close_state=data['close_state'];
	if(verify_state && !erg.test(verify_state)){//状态是中文
		verify_state=$STATE_MAPPING[verify_state.trim()];
	}
	if(dispose_state && !erg.test(dispose_state)){//状态是中文
		dispose_state=$STATE_MAPPING[dispose_state.trim()];
	}
	if(freeze_state && !erg.test(freeze_state)){//状态是中文
		freeze_state=$STATE_MAPPING[freeze_state.trim()];
	}
	if(tally_state && !erg.test(tally_state)){//状态是中文
		tally_state=$STATE_MAPPING[tally_state.trim()];
	}
	if(close_state && !erg.test(close_state)){//状态是中文
		close_state=$STATE_MAPPING[close_state.trim()];
	}
	sta['verify_state']=verify_state;
	sta['dispose_state']=dispose_state;
	sta['freeze_state']=freeze_state;
	sta['tally_state']=tally_state;
	sta['close_state']=close_state;
	
	return sta;
}

function getEditModel(){
	return $("#edit_model").val();
}
function getPageStates(){
	return {
		verify_state : $("#audit_state").val(), //审核
		dispose_state: $("#deal_state").val(), //处理状态
		freeze_state: $("#frozen_state").val(), //冻结
		tally_state: $("#tally_state").val(), //记账帐
		close_state: $("#close_state").val() //关闭
	};
}