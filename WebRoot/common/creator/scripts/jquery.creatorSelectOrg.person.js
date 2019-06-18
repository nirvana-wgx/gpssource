
/***************
 * 选择机构
 * @param app_root 
 * @param title 标题
 * @param callbackfun 回调函数
 * @param single 是否单选(可选)
 * @param rootNumber 机构编码(可选)
 * @param power 获取权限范围内的机构树(可选)
 * @param copy 是否只选择公司
 * @param windid 窗口ID
 */
function popOrgSelect(app_root,title,callbackfun,single,rootNumber,power,copy,windid) {	
	var opt={};
	opt.app_root=app_root;
	if(title){
		opt.window_title=title;
	}
	if(callbackfun){
		opt.callFunction=callbackfun;
	}
	if(single){
		opt.relay_param_p_single='single';
	}
	if(rootNumber){
		opt.org_number=rootNumber;
	}
	opt.relay_param_p_target='org';
	if(power){
		opt.power='power';
	}
	if(windid){
		opt.app_window=windid;		
	}
	if(copy){
		opt.relay_param_cop='-1';
		opt.cop='-1';
	}
	org_tree(opt);
}




/**********
 * 选择人员
 * @param app_root
 * @param title 标题
 * @param callbackfun 回调函数
 * @param single 是否单选(可选)
 * @param rootNumber 机构编码(可选)
 * @param power 获取权限范围的的机构树(可选)
 * @param windid 窗口ID
 */
function popPeopleSelect(app_root,title,callbackfun,single,rootNumber,power,windid){		
	var opt={};
	opt.app_root=app_root;
	if(title){
		opt.window_title=title;
	}
	if(callbackfun){
		opt.callFunction=callbackfun;
	}
	if(single){
		opt.relay_param_p_single='single';
	}
	if(rootNumber){
		opt.org_number=rootNumber;
	}
	opt.relay_param_p_target='user';
	if(power){
		opt.power='power';
	}
	if(windid){
		opt.app_window=windid;		
	}
	opt.relay_param_p_sqlid='user_sql';
	org_tree(opt);
}



function org_tree(param){
	  var def={
		  app_window:'org_wind',
		  app_root:'/',
		  relay_param_p_single:'over',
		  relay_param_cop:'',
		  cop:'',
		  power:'',
		  org_number:'',
		  relay_param_p_target:'org',
		  callFunction:'call_function',
		  window_title:'选择机构',
		  relay_param_p_sqlid:'org_sql'
	  };
	  $.extend(def,param);	
	  var param_url=jQuery.param(def);
	  //alert(param_url);
	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/org_person_tree/main.jsp?"+param_url,600,470); 
}

/**-------------------------Added by xiaoqing.qiu----------------------------------------------*/
 /***
 * 弹出下拉树的层
 * @app_root
 * @single=true单选；=false多选
 * @positionBaseTarget; 用于定位弹出层的dom对象，弹出层会出现在positionBaseTarget的下方
 * @treeId,用于请求下拉树的数据
 * @callbackfun,选择完成后点确定按钮后调用的方法
 * @width 弹出层的宽度
 * @height 弹出层的高度
 */
 function popupTree(app_root,single,positionBaseTarget,treeId,callbackfun, width, height){
 	var def={
		width : 200,
		height : 220
	};
 	var option={};
 	option.app_root = app_root;
 	option.treeId = treeId;
 	option.width = width;
 	option.height = height;
 	option.callFunction=callbackfun;
 	if(single){
		option.single='single';
		option.tree_type='radio';
	}else{
		option.single='over';
		option.tree_type='checkbox';
	}
	option = $.extend(def, option);
	var popup = $(document.body).find("div#popup_dropdown_tree");
	if(popup.length ==0){
		$(document.body).append("<div id='popup_dropdown_tree'></div>");
		popup = $(document.body).find("div#popup_dropdown_tree");
		$(popup).css({
	  		'position': 'absolute',
	  		'background-color': '#FFFFFF',
	  		'border': '2px solid #DDDDDD'
		});
	}
	$(popup).css({
		'display':'block',
		'height': option.height+'px',
		'width': option.width+'px'
	});
	/** 在IE出现滚动条的情况下，top的值有问题，为解决。**/
	$(popup).offset({top: positionBaseTarget.getBoundingClientRect().height+$(positionBaseTarget).offset().top,
					left: positionBaseTarget.getBoundingClientRect().left});
	var param_url=jQuery.param(option);  	
	$(popup).load(option.app_root+"/common/customer_tree/popup_tree.jsp?"+param_url);
 }
 
 function closePopupTree(){
 	var tree = $(document.body).find("div#popup_dropdown_tree");
 	$(tree).children().remove();
 	$(tree).hide();
 }
 /**---------------------------end--------------------------------------------*/

/**------------------------------下拉树弹出窗口--begin----------------------------*/
 /*****************
 * 选择客户组
 * @param app_root
 * @param title
 * @param callbackfun
 * @param single
 */
function popCustomerGroupTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		customer_group_tree(option);
	}
	 
function customer_group_tree(param){
  	  var def={
  		  app_window:'customer_group_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'选择客户组'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/customer_group_tree.jsp?"+param_url,230,330); 
}


/***********
 * 选择客户
 * @param app_root
 * @param title
 * @param callbackfun
 * @param single
 */
function popCustomerTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		customer_tree(option);
	}
	 
function customer_tree(param){
  	  var def={
  		  app_window:'customer_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'选择客户组'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/customer_tree.jsp?"+param_url,300,395); 
}


/************************
 * 选择产库
 * @param app_root
 * @param title
 * @param callbackfun
 * @param single
 */
function popWarehouseTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		warehouse_tree(option);
	};

function warehouse_tree(param){
  	  var def={
  		  app_window:'warehouse_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'选择仓库'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/warehouse_tree.jsp?"+param_url,300,395); 
};


/****************************************************
 * 选择供应商
 * @param app_root
 * @param title
 * @param callbackfun
 * @param single
 */
function popSupplierTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		supplier_tree(option);
	};

/****
*供应商树
*/
function supplier_tree(param){
  	  var def={
  		  app_window:'supplier_tree_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'选择供应商'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/supplier_tree.jsp?"+param_url,300,395); 
};

/*
*供应商组
*/
function popSupplierGroupTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		supplier_group_tree(option);
	}
	 
function supplier_group_tree(param){
  	  var def={
  		  app_window:'supplier_group_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'选择供应商组'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/supplier_group_tree.jsp?"+param_url,230,330); 
}




/***
*选择销售区域
*/
function popRegionTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		region_tree(option);
	};

/****
*选择销售区域
*/
function region_tree(param){
  	  var def={
  		  app_window:'region_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'科目选择'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/region_tree.jsp?"+param_url,300,395); 
};


/**************************************
*选择物料组
*/
function popMaterielSortTree(app_root,title,callbackfun,single){
		var option={};
		if(app_root){
			option.app_root=app_root;
		}
		if(title){
			option.window_title=title;
		}
		if(callbackfun){
			option.callFunction=callbackfun;
		}
		if(single){
			option.single='single';
			option.tree_type='radio';
		}
		materiel_sort_tree(option);
};

/****
*选择物料组
*/
function materiel_sort_tree(param){
  	  var def={
  		  app_window:'materiel_sort_wind',
  		  app_root:'/',
  		  single:'over',
  		  tree_type:'checkbox',
  		  callFunction:'call_function',
  		  window_title:'科目选择'
  	  };
  	  $.extend(def,param);	
  	  var param_url=jQuery.param(def);  	
  	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/customer_tree/materiel_sort_tree.jsp?"+param_url,300,395); 
};	
/**------------------------------end----------------------------*/
