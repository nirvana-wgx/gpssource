/*****************************************************
 * 平台弹出选择树
 * @param approot 系统上下文 String
 * @param treeid  树编码   String
 * @param title   弹出框选择标题 String
 * @param single  single  是否单选 boolean
 * @param callback callback 回调函数名称 String 
 * @param param   param  业务参数 Object
 * @param query   树是否可查询 boolean 
 * @param winid   弹出树id
 * @param width   宽度
 * @param height  高度
 */
function popSelectTree(approot,treeid,title,single,callback,param,query,winid,width,height){
	 var def={
			  app_window:'selectTree_wind',
			  app_root:'/',	
			  callFunction:'call_function',
			  window_title:'选择神马',
			  relay_param_p_single:'over',
			  width:600,
			  height:470
	};
	 if(approot){
		  def.app_root=approot;
	  }
	  if(treeid){
		  def.ps_tree_id=treeid;
	  }
	  if(title){
		  def.window_title=title;
	  }
	  if(callback){
		  def.callFunction=callback;
	  }
	  if(width){
		  def.width=width;
	  }
	  if(height){
		  def.height=height;
	  }
	  //处理内宽度
	  def.height_px=def.height-75;
	  def.width_px=def.width-24;
	  
	  
	  if(single){
		  def.tree_type='radio';
	  }else{
		  def.tree_type='checkbox';		  
	  }
	  if(query){
		  def.query_tree='query';
	  }
	  if(param){
		  $.extend(def,param);	
	  }
	  var param_url=jQuery.param(def);		
	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/org_person_tree/tree_template.jsp?"+param_url,def.width,def.height); 
}



/****************************************************************************
 * 左树右选择页面通用方法 
 * @param approot  系统上下文 Stirng
 * @param treeid   树ID String
 * @param title    显示标题 String
 * @param single   是否单选 boolean
 * @param callback 回调函数名称 String
 * @param param    业务参数 Object [可选] 参见easytree帮助文档
 * @param query    树是否带查询条件 boolean [可选]
 * @param winid    窗口ID String [可选]
 * @param width    宽度  Number [可选]
 * @param height   高度  Number [可选]
 */
function popSelectTreeOption(approot,treeid,title,single,callback,param,query,winid,width,height){
	  var def={
		  app_window:'org_wind',
		  app_root:'/',	
		  callFunction:'call_function',
		  window_title:'选择机构',
		  relay_param_p_single:'over',
		  width:600,
		  height:470
	  };
	  if(approot){
		  def.app_root=approot;
	  }
	  if(treeid){
		  def.ps_tree_id=treeid;
	  }
	  if(title){
		  def.window_title=title;
	  }
	  if(callback){
		  def.callFunction=callback;
	  }
	  
	  if(width){
		  def.width=width;
	  }
	  if(height){
		  def.height=height;
	  }
	  if(single){
		  def.relay_param_p_single='single';
	  }
	  if(query){
		  def.query_tree='query';
	  }
	  if(param){
		  $.extend(def,param);	
	  }
	  var param_url=jQuery.param(def);	
	  openModelWindow(def.app_window,def.window_title,def.app_root+"/common/org_person_tree/main.jsp?"+param_url,def.width,def.height); 
}


/*************************************************************************************
 * 左树右查询页面
 * @param approot 系统上下文
 * @param treeid 树编码
 * @param single 是否单选
 * @param title 标题
 * @param callback 回调函数名称
 * @param param 业务参数
 * @param query 是否是查询树
 * @param winid 窗口编号
 * @param width 宽度
 * @param height 高度
 * @param 树所在部分所占百分比 默认(28%)
 */
function popSelectTreePage(approot,treeid,single,title,callback,param,query,winid,width,height,scale){
	var option={
		  app_window:'tree_page_window',
		  app_root:'/',	
		  callFunction:'call_function',
		  window_title:'选择页面',
		  relay_param_p_single:'over',
		  width:600,
		  height:470				
	};
	if(approot){
		option.app_root=approot;
	}
	if(treeid){
		option.ps_tree_id=treeid;
	}
	if(title){
		option.window_title=title;
	}
	if(callback){
		option.callFunction=callback;
	}
	if(width){
		option.width=width;
	}
	if(height){
		option.height=height;
	}
	 //处理内宽度
	option.height_px=option.height-75;
	option.width_px=option.width-24;
	if(single){
		option.relay_param_p_single='single';
	}
	option.p_height=option.height-80;
  if(query){
	  option.query_tree='query';
  }
  if(scale){
	  option.p_scale=scale;
  }
  if(param){
	  $.extend(option,param);	
  }
  var param_url=jQuery.param(option);	
  openModelWindow(option.app_window,option.window_title,option.app_root+"/common/org_person_tree/tree_page_template.jsp?"+param_url,option.width,option.height);
}
