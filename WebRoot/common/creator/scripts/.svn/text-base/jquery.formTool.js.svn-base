/*-------------------------------------------
 *表单提交工具
 *formtool
 *@author fireflyhoo@gmail.com
 *@declaration Everything has nothing to do with me, I am innocent.
 */
/*===================================================================*/
(function($){
/*===================================================================*/
	$.formtool={
		//------------------default setting--------------------//		
		setting:{
			action: '/common/control/executeAJAX.page', //单据操作执行的入口
			openLog:true, //是否打开日志
			async:true ,//异步提交
			context:"/" //应用上下文
		},
		operate:{ //操作类型
			_insert:'insert',
			_update:'modify',
			_delete:'delete',
			_complexUpdate:'complexUpdate',
			_insertMulti:'insertMulti'
		},

		//--------------helper methods------------------//
		log:function(title,data){ //记录日志
			var option=this.setting;
			try{
			if(option.openLog && window && window.console && window.console.log){ //如果打开日志
				if (title!=undefined) {
					window.console.log(title);
				};
				
				if (data!=undefined) {
					window.console.log(data);	
				};						
			}
			}catch(e){}//日志问题..
		},
		
	    getContext:function(){
	          var contextPath = document.location.pathname;
	          var index =contextPath.substr(1).indexOf("/");
	          contextPath = contextPath.substr(0,index+1);
	          delete index;
	          return contextPath;
	     },
		

		/**
		*获取页面单据结构
		*/
		getPagDocketStruct:function(){
			//获取去单据结构
			var dtypes={};
			var keys=[];
			this.log("单据结构",$('[docket_datatype]'));
			$('[docket_datatype]').each(function(i,_data){
				dtypes[$(_data).attr('docket_datatype')]=$(_data).attr('docket_datatype');
			});			
			for(var key in dtypes){
				keys.push(key);
			}
			this.log("单据结构:",dtypes);
			this.log("keys:",keys);
			return keys;
		},

		internalCallBack:function(data,_callBack){
			this.log("发送数据到服务器获得响应数据",data);
			//TODO (需要调整)对数据做处理
			var ripeData=data;

			if(typeof data =="string"){//从服务器传过来的数据
				//判断是否是json格式
				var callbackObj=null;
				var jsonObj=null;
				try{
					jsonObj=$.parseJSON(data);					
				}catch(error){
				}
				if(jsonObj==null){//无转成json
					var meg=data.split("@");
					if (meg.length==2) {
						callbackObj={
							state:meg[0],
							message:meg[1],
							data:[]
						};	
					}else{//后台数据无法解析
						callbackObj={
							state:false,
							message:"后台数据无法解析",
							data:[]
						};	
						$.formtool.log('后台数据无法解析:',data);
					}					
				}
				/*----------------
				for(var element in jsonObj){
					if(element=='result_out' &&(typeof jsonObj[element] == "object")){//是调用规则的返回的数据						
						$.formtool.log(jsonObj[element]);
						var docketResult=jsonObj[element];
						var jsonStrObj=$.parseJSON(docketResult.jsonStr);
						var _msg=docketResult.message;
						if(docketResult.executeResult && !_msg){//操作成功
							_msg='操作成功!';
						}
						callbackObj={
							state:docketResult.executeResult,
							message:_msg,
							data:jsonStrObj							
						};
					}
				}
				----------------------*/
				if(typeof jsonObj.status == "object"){//是调用规则的返回的数据						
					var _msg = jsonObj.status.message;
					if(jsonObj.status.ok && !_msg){//操作成功
						_msg = '操作成功!';
					}
					var dataObj = {};
					
				
					//bug 不同的规则掉用的结果不太一样啊
					if(jsonObj.output && jsonObj.output.result) {
						dataObj = jsonObj.output.result;
					}else{
						
						if(jsonObj.output && jsonObj.output.result_out) {
							dataObj = jsonObj.output.result_out;
						}else if(jsonObj.output && !jsonObj.output.result_out){
							dataObj = jsonObj.output;
						}
					}
					callbackObj={
						state:jsonObj.status.ok,
						message:_msg,
						data:dataObj
					};
				}
			}else{//内部提示错误
				callbackObj=ripeData;
			};
			//回调外部的函数
			if(_callBack){
				if(callbackObj){
					_callBack(callbackObj);	
				}else{
					_callBack(ripeData);
				}
			}else{
				this.log('没有找到回调函数',_callBack);
			}
		},
		sendDataToServe:function(data,externalcllback){
			var innerfun=this;
			var option=this.setting;
			innerfun.log('---开始发送数据到服务器---');
			innerfun.log('往服务器发送的数据为',data);
			var jsonstr='['+JSON.stringify(data)+']';
			var url=option.context+'/'+option.action;
			
			innerfun.log("url:",url);

			$.ajax({
				url:url,
				async:false,
				type:'POST',
				cache:false,
				data:{'jsonStr':jsonstr}, //提交数据
				dataType:'text',
				error:function(httpRequest, textStatus, errorThrown){				
					innerfun.log(errorThrown);
					innerfun.log('请求出错',textStatus);
					//创建对象给外部
					var _data={
						state:'error',
						message:'未能发起Ajax请求,或服务器处理发生错误!',
						data:[]
					};
					innerfun.internalCallBack(_data,externalcllback);
				},
				success:function(_data, textStatus){
				//	alert(_data);
					innerfun.log('请求调用成功:',_data);
					innerfun.log('状态:',textStatus);
					innerfun.internalCallBack(_data,externalcllback);			
				}
			});
		},
		//判断传进来的是数据对象
		isData:function(data){

			return (data instanceof Object && !(data instanceof $));
		},
		//从容器中序列化单据信息
		findDocketData:function($container){ //TODO 重要方法 获得数据
			var innerfun=this;
			if($container.find('.datagrid_pane')[0]){
				var grid= $.data($container.find('.datagrid_pane')[0], 'datagrid');
				var serialObj={};
				var delData=grid.getDeleteRows(); //删除数据
				var updataData=grid.getUpdatedRowsData(); //修改数据
				var addData=grid.getAddedRowsData(); //新增数据
				
				if(addData && !$.isEmptyObject(addData) && $.isArray(addData) && addData.length>0){
					$.extend(serialObj, {"add": addData});
				}
				if(delData && !$.isEmptyObject(delData) && $.isArray(delData) && delData.length>0){
					$.extend(serialObj,{"remove": delData});
				}
				if(updataData && !$.isEmptyObject(updataData) && $.isArray(updataData) && updataData.length>0){
					$.extend(serialObj,{'modify':updataData});
				}
				if($.isEmptyObject(serialObj)){//新增时子表没有数据
					innerfun.log('没有任何数据');
					serialObj.add=[];
					serialObj.remove=[];
					serialObj.modify=[];
				}
				if(!serialObj.add || $.isEmptyObject(serialObj.add)){
					serialObj.add=[];
				}
				if(!serialObj.remove || $.isEmptyObject(serialObj.remove)){
					serialObj.remove=[];
				}
				if(!serialObj.modify || $.isEmptyObject(serialObj.modify)){
					serialObj.modify=[];
				}else{//对于可编辑表格中的空，全部替换成NA
					$.each(serialObj.modify,function(i,_dat){
						for(var key in _dat){
							if(!_dat[key]||_dat[key]==''){//特殊处理把 //TODO 可能是个坑....
								_dat[key]="NA";
							}
						}	
					});
				}
			}else{
				serialObj= $container.serialAll('object','noarray');
				
				//比对修改情况...
				var initial_data=$.data($container[0],'initial_data');
				//console.log(initial_data);
				if(initial_data){//是修改
					for( key in initial_data){		
						if(key && initial_data[key] && initial_data[key]!=serialObj[key] && serialObj[key]==''){
							serialObj[key]='NA';
						}
					}
				}
			}

			//alert(serialObj);
			innerfun.log('序列化对象:',serialObj);			
			return serialObj;
		},
		//从容器中序列化单据信息(采购专用)
		findDocketData2:function($container){ //TODO 重要方法 获得数据
			var innerfun=this;
			var serialObj={};
			$container.each(function(i,obj){
				//alert(JSON.stringify(serialObj));
				obj=$(obj);
				if(obj.find('.datagrid_pane')[0]){
					var grid= $.data(obj.find('.datagrid_pane')[0], 'datagrid');
					var delData=grid.getDeleteRows(); //删除数据
					var updataData=grid.getUpdatedRowsData(); //修改数据
					var addData=grid.getAddedRowsData(); //新增数据
					
					if(addData && !$.isEmptyObject(addData) && $.isArray(addData) && addData.length>0){
						var currentData = serialObj["add"];
						if(currentData){
							addData = currentData.concat(addData);
						}
						$.extend(serialObj, {"add": addData});
					}
					if(delData && !$.isEmptyObject(delData) && $.isArray(delData) && delData.length>0){
						var currentData = serialObj["remove"];
						if(currentData){
							addData = currentData.concat(addData);
						}
						$.extend(serialObj,{"remove": delData});
					}
					if(updataData && !$.isEmptyObject(updataData) && $.isArray(updataData) && updataData.length>0){
						var currentData = serialObj["modify"];
						if(currentData){
							addData = currentData.concat(addData);
						}
						$.extend(serialObj,{'modify':updataData});
					}
					if($.isEmptyObject(serialObj)){//新增时子表没有数据
						innerfun.log('没有任何数据');
						serialObj.add=[];
						serialObj.remove=[];
						serialObj.modify=[];
					}
					if(!serialObj.add || $.isEmptyObject(serialObj.add)){
						serialObj.add=[];
					}
					if(!serialObj.remove || $.isEmptyObject(serialObj.remove)){
						serialObj.remove=[];
					}
					if(!serialObj.modify || $.isEmptyObject(serialObj.modify)){
						serialObj.modify=[];
					}else{//对于可编辑表格中的空，全部替换成NA
						$.each(serialObj.modify,function(i,_dat){
							for(var key in _dat){
								if(!_dat[key]||_dat[key]==''){//特殊处理把 //TODO 可能是个坑....
									_dat[key]="NA";
								}
							}	
						});
					}
				}else{
					serialObj= obj.serialAll('object','noarray');
					
					//比对修改情况...
					var initial_data=$.data(obj[0],'initial_data');
					//console.log(initial_data);
					if(initial_data){//是修改
						for( key in initial_data){		
							if(key && initial_data[key] && initial_data[key]!=serialObj[key] && serialObj[key]==''){
								serialObj[key]='NA';
							}
						}
					}
				}
			});

			//alert(JSON.stringify(serialObj));
			innerfun.log('序列化对象:',serialObj);			
			return serialObj;
		},
		
		/**
		 * 反序列化一个的单据
		 * @param $container
		 */
		deserializeDocket:function($container,ddata, gridIsInit){
			if(!ddata){ return ;}//没有数据
			
			//判断容器是普通容器还是包含可编辑表格的
			if($container.find('.datagrid_pane')[0]){//表格
				//调用表格的反序列化
				var grid=$.data($container.find('.datagrid_pane')[0],'datagrid');				
				if(grid){
					if(typeof gridIsInit == 'undefined') {
						gridIsInit = true;
					}
					//反序列化
					grid.clear();
					grid.appendRow(ddata,gridIsInit);
					//将原始数据缓存到的到单据节点上/* 2012/10/09  */
					$.data($container[0],'initial_data',ddata);
					//console.log($container[0]);
					//console.log(ddata);
				};		
			}else{			
				//
				if($.isArray(ddata)&& ddata.length==1){
					$container.serialAll('load',ddata[0]);
					//将原始数据缓存到的到单据节点上/* 2012/10/09  */
					$.data($container[0],'initial_data',ddata[0]);
					//console.log($container[0]);
					//console.log(ddata);
				}else{
					if(ddata.length>1){				
						//for(var i=0;i<)
						//bug
					}else{
						$container.serialAll('load',ddata);
						//将原始数据缓存到的到单据节点上/* 2012/10/09  */
						$.data($container[0],'initial_data',ddata);
						//console.log($container[0]);
						//console.log(ddata);
					}
				}
				
			}
		},
		
		//找到单据头信息 eq:
		/*
			{
				"_docket" : "docket:com.chinacreator.demo.check_bill",
				"mainDocketCode": 'mancket',
				"childDocketCode": ['childcket','childcket2']
			}
		*/
		findDocketHead:function($container){//TODO 重要方法	

			var _docket;

			if(!$container){
				_docket=$("[docket_code]:first").attr("docket_code");

			}else{
				_docket=$($container).find("[docket_code]:first").attr("docket_code");
			}


			var docket_head={};
			$.extend(docket_head,{'_docket':_docket});


			return docket_head;
		}
		,
		deserialize:function(_data,$_callbackfun,_docketOption){//TODO 重要方法	反序列化
			var innerfun=this;
			var docketHead=innerfun.findDocketHead();
			$.extend(docketHead,{"data":_data});
			$.extend(docketHead,{"_operation":"query"});
			if(_docketOption&& typeof _docketOption== "string"){
				$.extend(docketHead,{"_operation":_docketOption});//允许调用自定义的单据数据查询数据回填到页面
			}
			
			innerfun.sendDataToServe(docketHead,function(data){
				innerfun.deserializeData(data, $_callbackfun);
			});
		},
		deserializeData:function(data, $_callbackfun, gridIsInit) {//将数据反序列化到页面上
			var innerfun=this;
			innerfun.log('data',data);
			//处理逻辑啊....
			if(data.state=='error'){
				return;
			}			
			var keys =innerfun.getPagDocketStruct();
			if(keys.length>1){//主从表
				for(var i=0;i<keys.length;i++){//TODO 此处还有问题.
					/*var obj= data.data[0][keys[i]];
					if($.isArray(obj)&&obj.length==1){
						obj=obj[0];
					}
					if($("[docket_datatype='"+keys[i]+"']").find('.datagrid_pane')[0]){//是表格
						$.data($("[docket_datatype='"+keys[i]+"']").find('.datagrid_pane')[0], 'datagrid').deserialize(data.data[0][keys[i]])	
					}

					$("[docket_datatype='"+keys[i]+"']").serialAll('load',obj);
					*/
					if(data.data[keys[i]]) {
						if(data.data[keys[i]].info) {//子单据数据不为空， 则反序列化子单据数据
							if($.isArray(data.data[keys[i]].info)/* && data.data[keys[i]].info.length > 0*/) { /** modify by xiaoqing.qiu | 2012-11-12*/
								innerfun.deserializeDocket($("[docket_datatype='"+keys[i]+"']"),data.data[keys[i]].info, gridIsInit);
							}
						} else {//主单据数据
							innerfun.deserializeDocket($("[docket_datatype='"+keys[i]+"']"),data.data[keys[i]]);
						}
					}
				}
			}else{
				if (keys.length==1) {//TODO 此处还有问题
					//$("[docket_datatype='"+keys[0]+"']").serialAll('load',data.data[0]);		
					innerfun.deserializeDocket($("[docket_datatype='"+keys[0]+"']"),data.data);
				}else{
					//$("body").serialAll('load',data.data[0]);	
					innerfun.deserializeDocket($("body"),data.data);
				}				
			}
			if($_callbackfun&& typeof $_callbackfun == "function"){
				$_callbackfun(data);//以防万一将回调函数曝露出去
			}
		},
		deletespare:function(data){//删除多余的属性
			var _data=data;
			if(_data._docket){
				delete _data._docket;								
			}
			if(_data._operation){
				delete _data._operation;
			}
			return _data;
		},			
		save:function(operatetype,callBack,del_data){

			var innerfun=this;
			var options=this.setting;
			var operate=this.operate;
			var sendData={};
			var _callbackfun=callBack;
			var mainData={};
			var childData=[];
			var _docket =null;

			innerfun.log('调用保存单据....');
			innerfun.log('setting:',options);
			innerfun.log('------------------------------------------------------------------');

			var keys=innerfun.getPagDocketStruct();
			if(keys.length>1){//主从表
				for (var i=0;i<keys.length;i++){
					var temp=innerfun.findDocketData($("[docket_datatype='"+keys[i]+"']"));
					mainData[keys[i]]=temp;
				}
			}else{//只有主表
				if(keys.length==1){
					mainData=innerfun.findDocketData($("[docket_datatype='"+keys[0]+"']"));
				}else{
					mainData=innerfun.findDocketData($("body"));
				}
			}

			//获取单据头信息
			var docketHead=innerfun.findDocketHead();
			if((typeof del_data == "object") && (!(del_data instanceof $))){  //删除的特殊处理
				mainData=del_data;	
				if(mainData._docket){
					_docket=mainData._docket;//删除时外部传入了单据信息
				}
				if(mainData.delDate){
					mainData=mainData.delDate;
				}

				mainData=innerfun.deletespare(mainData);
			}

			//组装数据
			/*if(operatetype==operate._insert){//单表新增

				mainData=innerfun.deletespare(mainData); //删除单据信息
				$.extend(sendData,{'_docket':docketHead._docket});//单据id
				$.extend(sendData,{'_operation':operate._insert});
				$.extend(sendData,{'data':mainData});
			}

			if(operatetype==operate._update){//单表更新
				$.extend(sendData,{'_docket':docketHead._docket});//单据id
				$.extend(sendData,{'_operation':operate._update});
				mainData=innerfun.deletespare(mainData);
				$.extend(sendData,{'data':mainData});
			}

			if(operatetype==operate._delete){ //单表删除
				$.extend(sendData,{'_docket':mainData._docket});//单据id
				$.extend(sendData,{'_operation':operate._delete});
				//删除data 大无关字段
				mainData=innerfun.deletespare(mainData);
				$.extend(sendData,{'data':mainData});
			}

			//if(operatetype==operate._insertMulti){//主从表插入
				$.extend(sendData,{'_docket':docketHead._docket});//单据id
				$.extend(sendData,{'_operation':operate._insertMulti});
				//var tempData={};
				//tempData[docketHead.mainDocketCode]=mainData;
				//tempData[docketHead.childDocketCode]=childData;
				$.extend(sendData,{'data': mainData});
		//	}

			*/

			//if(operatetype==operate._insertMulti){//主从表插入
				$.extend(sendData,{'_docket':docketHead._docket});//单据id
				if(_docket){
					$.extend(sendData,{'_docket':_docket});//单据id
				}
				$.extend(sendData,{'_operation':operatetype});
				//var tempData={};
				//tempData[docketHead.mainDocketCode]=mainData;
				//tempData[docketHead.childDocketCode]=childData;
				$.extend(sendData,{'data': mainData});
		//	}

			//if (operatetype==operate._complexUpdate){ //主从表更新

				//TODO 搞不定啊

			//};


			//TODO  一系列处理之后....
			if(!callBack){
				innerfun.log('未传入回调函数或者回调函数不存在,将会使用默认的 save_callback_fun', callBack);
				_callbackfun=save_callback_fun;
			}
			innerfun.sendDataToServe(sendData,_callbackfun);
		},
		save2:function(operatetype,callBack,del_data){

			var innerfun=this;
			var options=this.setting;
			var operate=this.operate;
			var sendData={};
			var _callbackfun=callBack;
			var mainData={};
			var childData=[];
			var _docket =null;

			innerfun.log('调用保存单据....');
			innerfun.log('setting:',options);
			innerfun.log('------------------------------------------------------------------');

			var keys=innerfun.getPagDocketStruct();
			if(keys.length>1){//主从表
				for (var i=0;i<keys.length;i++){
					var temp=innerfun.findDocketData2($("[docket_datatype='"+keys[i]+"']"));
					mainData[keys[i]]=temp;
				}
			}else{//只有主表
				if(keys.length==1){
					mainData=innerfun.findDocketData2($("[docket_datatype='"+keys[0]+"']"));
				}else{
					mainData=innerfun.findDocketData2($("body"));
				}
			}

			//获取单据头信息
			var docketHead=innerfun.findDocketHead();
			if((typeof del_data == "object") && (!(del_data instanceof $))){  //删除的特殊处理
				mainData=del_data;	
				if(mainData._docket){
					_docket=mainData._docket;//删除时外部传入了单据信息
				}
				if(mainData.delDate){
					mainData=mainData.delDate;
				}

				mainData=innerfun.deletespare(mainData);
			}


			//if(operatetype==operate._insertMulti){//主从表插入
				$.extend(sendData,{'_docket':docketHead._docket});//单据id
				if(_docket){
					$.extend(sendData,{'_docket':_docket});//单据id
				}
				$.extend(sendData,{'_operation':operatetype});
				//var tempData={};
				//tempData[docketHead.mainDocketCode]=mainData;
				//tempData[docketHead.childDocketCode]=childData;
				$.extend(sendData,{'data': mainData});
		//	}

			//TODO  一系列处理之后....
			if(!callBack){
				innerfun.log('未传入回调函数或者回调函数不存在,将会使用默认的 save_callback_fun', callBack);
				_callbackfun=save_callback_fun;
			}
			innerfun.sendDataToServe(sendData,_callbackfun);
		},
		getDocketInfo:function(){
			var mainData={};

			var keys=$.formtool.getPagDocketStruct();
			if(keys.length>1){//主从表
				for (var i=0;i<keys.length;i++){
					var temp=$.formtool.findDocketData($("[docket_datatype='"+keys[i]+"']"));
					mainData[keys[i]]=temp;
				}
			}else{//只有主表
				if(keys.length==1){
					mainData=$.formtool.findDocketData($("[docket_datatype='"+keys[0]+"']"));
				}else{
					mainData=$.formtool.findDocketData($("body"));
				}
			}
			//获取单据头信息
			var docketHead=$.formtool.findDocketHead();
			mainData["_docket"]=docketHead._docket;
			return mainData;
		}//end
	};
	//end

	


	//jQuery对象方法
	$.saveDocket=function(operatetype,callbackfun,data){
		$.formtool.save(operatetype,callbackfun,data);
	};
	
	//采购专用
	$.saveDocket2=function(operatetype,callbackfun,data){
		$.formtool.save2(operatetype,callbackfun,data);
	};

	$.formtoolInit=function(options){		
		$.extend($.formtool.setting,options);
	};
	
	
	/***************
	 * ajax调用单据方法
	 * @param $_docket 单据ID
	 * @param $_operation 单据操作
	 * @param $data 业务数据 {} 对象形式
	 * @param $callbackfun 回调函数  function(data)
	 */
	$.executeDocket=function($_docket,$_operation,$data,$callbackfun){
		if(!$_docket || !$_operation){
			alert('路由信息不能为空!');
		}
		var route={'_operation':$_operation};
		route._docket=$_docket;
		$.extend($data,route);
		$.formtool.save($_operation,$callbackfun,$data);
	};
	
	$.updateLoadData=function(data,$_callbackfun,_docketOption){
		//修改加载数据
		//var docket_head={"_operation":"query","_docket":"docket:com.Coollf"};
		//$.extend(docket_head,{"data":data});
		$.formtool.deserialize(data,$_callbackfun,_docketOption);
	};
	
	/**
	 * 将数据反序列化到页面上， 这里只做数据的反序列化，不做查询
	 * @param data 满足单据数据格式的数据集
	 * @param $_callbackfun 回调函数
	 * @param gridIsInit 可编辑表格是否已经初始化。true：反序列化的数据放入modify中。false：反序列化的数据放入add中
	 */
	$.deserializeData=function(data,gridIsInit,$_callbackfun){
		var _data = new Object();
		$.extend(_data,{'data': data});
		$.formtool.deserializeData(_data,$_callbackfun, gridIsInit);
	};
	
	/**
	 * 将数据反序列化到页面上， 这里只做数据的反序列化，不做查询
	 * 这个专用于转换后数据的反序列化；转换后数据的格式与序列化数据格式不一致，需要做转换
	 * @param data 转换得到的数据集
	 * @param $_callbackfun 回调函数
	 * @param gridIsInit 可编辑表格是否已经初始化。true：反序列化的数据放入modify中。false：反序列化的数据放入add中
	 */
	$.deserializeTransData=function(transData,gridIsInit,$_callbackfun){
		var tempdata = new Object();
		if(transData && transData[0]) {
			var first = transData[0];//只取第一个数据
			for(var i in first) {//对结果集循环，调整其结构
				var docket = first[i];//得到单据对象
				for(var temp in docket) {//得到单据对象的其中一个属性
					if($.isPlainObject(docket[temp])) {//如果他的属性是一个对象，则表示其实从单据
						tempdata[i] = new Object();
						$.extend(tempdata[i],{'info': docket});
					} else {//否则是主单据
						tempdata[i] = docket;
					}
					break;
				}
			}
		}
		var data = new Object();
		$.extend(data,{'data': tempdata});
		if(typeof gridIsInit == 'undefined') {
			gridIsInit = false;
		}
		$.formtool.deserializeData(data,$_callbackfun,gridIsInit);//反序列化到页面上
	};
	//end

	//初始化应用上下文
	$.formtoolInit({context:$.formtool.getContext()});	
/*===================================================================*/
})(jQuery);
/*===================================================================*/



// handel bug
/**保证函数函数不出错**/
if(!document.save_callback_fun){
	save_callback_fun=function(data){
		//alert("系统回调函数:"+data);
	};
};




/*=================================================================================
	使用方法:
	1.在引入本js之前必须引入
		jquery.js
		jquery.serialAll.js
		json2.js

	2.初始化本工具
		$.formtoolInit({context,'你的应用上下文'}); //对本页面有效

	3.修改时加载数据(保存时可选)
						 {role:'aa'} 形式	
		$.updateLoadData(条件数据);

	4.提交单据
	                                      主单据数据{}     子单据数据[{}]
		$.saveDocket('操作类型',回调函数,'主容器选择器','子容器选择器')


	5. 特殊用法 删除
	                                         单据信息            //业务id 
	$.saveDocket('delete',null,{"_docket":"docket:com.Coollf","roleId":"id"});
	
	6.参考函数
	function callback(data){
		//data 格式:
		{
			state:false, //操作状态
			message:"后台数据无法解析", //信息
			data:[] //返回数据
		}	
		//你要做的处理

	}

	//新增保存
	function doAddDocket(_callback){
		$.saveDocket('insert',_callback);
	}
	
	//修改保存
	function doUpdateDocket(_callback){
		$.saveDocket('update',_callback);
	}
	
	
	
	/************************
	 * @param _docket 单据id
	 * @param  data 删除条件数据
	 * @param  _callback 回调函数
	 *
	function doDeleteDocket(_docket,data,_callback){
		data._docket=_docket;
		$.saveDocket('delete',_callback,data);
	}
	
	//加载数据
	function loadData(data,_callback,_docketOption){
		$.updateLoadData(data,_callback,_docketOption);
	}

/*=================================================================================*/