/**
*表单控制流转按钮事件调用
*/
(function($){
	var MODEL_CONSTANT = {/*编辑模式*/
		ADD:"0",
		EDIT:"1",
		VIEW:"2"
	};

	var def={
		'add':{/*新增*/
			'id':'btn_add',
			'listeners':[toAddDocket]
		},
		
		'edit':{/*编辑*/
			'id':'btn_modify',
			'listeners':[toEdit]
		},

		'remove':{/*删除*/
			'id':'btn_delete',
			'listeners':[deleteDocket]
		},
		'save':{/*保存*/
			'id':'btn_save',
			'listeners':[]
		},
		'giveup':{/*取消*/
			'id':'btn_abort',
			 'listeners':[giveup]
		},
		'copy':{/*复制*/
			 'id':'btn_copy',
			 'listeners':[copy]
		},
		'send':{/*送审*/
			 'id':'btn_send',
			 'listeners':[]
		},
		'audit':{/*审核*/
			 'id':'btn_audit',
			 'listeners':[]
		}
	};
	$.fn.innerControlMethods={
		init:function(toolbarObj){
			for(var key in def){
				var button_config = $(def).attr(key);
				if(button_config.id!=''){
					var btn = toolbarObj.find('#'+button_config.id);
					$.each(button_config.listeners,function(i,obj){
						btn.bind("click",obj);//绑定监听 
						//console.log(btn);
					});
				};
			}
		}
	};
	$.fn.controlInit=function(toolbarObj,setting){
		$.extend(def,setting);//重载
		$.fn.innerControlMethods.init(toolbarObj);
	};
	$.fn.control=function(setting){		
		$.fn.controlInit(this,setting);
	};


	
	/***
	 * 点击修改时调用
	 */
    function toEdit(aut_key){
    	if((!api) || (!W)){
    		return ;
    	}
    	var edit_model=getEditModel();//获取当前编辑模式
    	if(!aut_key && edit_model!=MODEL_CONSTANT.VIEW ){
			return;
		}
    	W.$(W.document.body).data('toolbar_treasure',$.getPageDocket());   	
    	$(W.document).find('#btn_modify').click();
    	api.close();//把自己干掉    	
    } 	
	
	/**
	 * 点击新增时调用
	 */
	function toAddDocket(){		
		if((!api)||(!W)){
			return false;
		}
		var edit_model=getEditModel();//获取当前编辑模式
		//if(edit_model!=MODEL_CONSTANT.VIEW){
		//	return false;
		//}
		doAddButton('btn_add');

	}
	
	/**
	 * 删除调用
	 */
	function deleteDocket(){
		if((!api)||(!W)){
			return ;
		}
		var edit_model=getEditModel();//获取当前编辑模式
		if(edit_model!=MODEL_CONSTANT.VIEW){
			return;
		}
		W.$(W.document.body).data('toolbar_treasure',$.getPageDocket());
		W.$(W.document.body).data('toolbar_api',colse_api); //子页面的api
		W.$(W.document.body).data('toolbar_operateMethod','remove');
		W.$(W.document).find('#btn_remove').click();
	};	
	
	
	function giveup(){/*取消*/
		if((!api) || (!W)){
			return ;
		}
		var edit_model=getEditModel();//获取当前编辑模式
		if(edit_model==MODEL_CONSTANT.VIEW){
			return;
		}
		//alert(edit_model);
		//当前是新增的时候关闭
		if(edit_model==MODEL_CONSTANT.ADD){
			doAddButton('btn_add',true);
		}

		//当前是修改的时候回到浏览状态
		if (edit_model==MODEL_CONSTANT.EDIT) {
			toEdit(true);//调用修改
    	};	
	}
	
	function copy(){/*复制*/
		
		if((!api)||(!W)){
			return ;
		}
		
		var edit_model=getEditModel();//获取当前编辑模式		
		
		//if(edit_model==MODEL_CONSTANT.ADD || edit_model == MODEL_CONSTANT.EDIT){			
		//	return;
		//}
		W.$(W.document.body).data('toolbar_treasure',$.getPageDocket());
		W.$(W.document.body).data('toolbar_api',colse_api); //子页面的api
		W.$(W.document.body).data('toolbar_operateMethod','copy');	
		doAddButton('btn_add');
	}
	
	
	/*
	 * 关闭api
	 * */
	function colse_api(){		
		if(api){
			api.close();
		}
	}

	/*
	* 处理新增
	*/
	function doAddButton(btn_add,add){
		var edit_model=getEditModel();//获取当前编辑模式		
		//if(!add && (edit_model!=MODEL_CONSTANT.VIEW)){
		//	return;
		//}
		var btn_nenu = W.$(W.document.body).find('.menu[target="'+btn_add+'"]');
		if (btn_nenu[0]) {
			btn_nenu.find('.menu_li:first').click();			
			api.close();//把自己干掉 
		}else{
			if(W.$('#'+btn_add)[0]){
				W.$('#'+btn_add).click();
				api.close();
			}
		}
	} 	
})(jQuery);

//添加清除复制的多余信息
function clearCopyResidue(){
	$("#bill_xh").val('');
	$("#bill_no").val('');
	$("#audit_state").val('1'); //审核
	$("#deal_state").val('0'); //处理状态
	$("#frozen_state").val('0'); //冻结
	$("#tally_state").val('0'); //记账帐
	$("#close_state").val('0');//关闭
}