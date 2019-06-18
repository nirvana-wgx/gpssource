/**
 * 容器内控件元素的序列化为JSON字符串,将JSON字符串回填到容器中的控件.
 * 日期： 2012年3月9日 14:44:23
 * 作者：Leon.Wang
 * Email: wang_yunlong@163.com
 * Copyright:湖南科创信息股份有限公司(chinacreator.com)。
 * 
 * 说明：将容器内的元素序列化，转换为JSON串。
 * 版本：1.0.0
 * 使用说明：
 * 1.定义容器的选择器，容器是包含要序列化对象的父级节点，可以是body、div、form、table、tr。
 * --------------------------------
 * 3.使用serialAll，传递参数为method="serial"，生成JSON字符串。
 * 传递参数method="load"，将加载数据在容器的控件上显示。
 * 测试插件功能使用正常的浏览器：
 * IE7.X、Branch of Chromium 14.0.835.186、（Window）Apple Safari、FireFox ESR 10.0.2。
 * 
 * edit info
 * 2012年3月30日 18:34:35 by Leon
 * 		1. 增加clear方法。清空容器内的控件数据。
 * 		2.回填数据之前，不在清空表单。
 */

(function($){
	
	$.fn.serialAll = function (method,params){
		if($.trim(method)=="serial"){//如果是序列化的方法.
			return $.fn.serialAll.methods["serial"](this);
		}else if($.trim(method) == "object"){
			return $.fn.serialAll.methods["object"](this,params);
		}else if($.trim(method)=="load"){//load数据.
			if($.isPlainObject(params)){//如果传递是对象.
				$.fn.serialAll.methods["loadObj"](this,params);
			}else{//如果是传递的是地址.
				return $.fn.serialAll.methods["loadUrl"](this, params);
			}
		}else if($.trim(method) == "clear"){
			$.fn.serialAll.methods["clear"](this);
		}
	};
	
	$.fn.serialAll.methods = {
		serial:function(obj){
			var jsonstr = '{';
			var fields = $(obj).find(":text,:password,:radio,textarea,:hidden,select").not("[unserial='true']").serializeArray();
			$.each(fields,function(i,field){
				jsonstr += '"'+field.name+'":'+'"'+field.value+'",';
			});
			
			//针对“是否”类型的checbox特殊处理
			var conBoxObj = $(obj).find(":checkbox[unselectvalue]").not("[unserial='true']");
			$.each(conBoxObj,function(){
				if($(this).prop("checked")){//如果当前的checbox为选择状态，取它的value值。
					jsonstr += '"'+$(this).attr("name")+'":'+'"'+$(this).attr("value")+'",';
				}else{
					jsonstr += '"'+$(this).attr("name")+'":'+'"'+$(this).attr("unselectvalue")+'",';
				}
			});
			
			var boxFields = $(obj).find(":checkbox").not("[unserial='true'],[unselectvalue]").serializeArray();
			var boxSize = $(boxFields).size();
			if(boxSize >0){
				jsonstr +='"'+$(boxFields).get(0).name+'":[';
			}else{
				var index = jsonstr.lastIndexOf(',');
				jsonstr = jsonstr.substring(0,index);
			}
			$.each(boxFields,function(i,field){
				var nextField = $(boxFields).get(i+1);
				if(nextField && field.name == nextField.name){//如果Next存在.
					jsonstr += '{"'+field.name+'":'+'"'+field.value+'"},';
				}else if(nextField && field.name != nextField.name){
					jsonstr +='{"'+field.name+'":'+'"'+field.value+'"}]'+',"'+nextField.name+'":[';
				}else if(! nextField){
					jsonstr += '{"'+field.name+'":'+'"'+field.value+'"}]';
				}
			});
			jsonstr +="}";
			return jsonstr;
		},object:function(obj,params){
			var object = new Object();
			var fields = $(obj).find(":text,:password,:radio,textarea,:hidden,select").not("[unserial='true']").serializeArray();
			$.each(fields,function(i,field){
				if($(obj).find("[name='"+field.name+"']").attr("formatType")=="number"){
					object[field.name] = $.string2Number(field.value);
				}else{
					object[field.name] = field.value;
				}
			});
			var boxFields = $(obj).find(":checkbox").not("[unserial='true'],[unselectvalue]").serializeArray();
			var array = new Array();
			$.each(boxFields,function(i,field){
				var nextField = $(boxFields).get(i+1);
				if(params == "noarray"){
					if(nextField && field.name == nextField.name){
						array.push(field.value);
					}else if(nextField && field.name != nextField.name){
						array.push(field.value);
						object[field.name] = array.join(",");
						array = [];
					}else if(!nextField){
						array.push(field.value);
						object[field.name] = array.join(",");
					}
				}else{
					if(nextField && field.name == nextField.name){
						var temp = new Object();
						temp[field.name] = field.value;
						array.push(temp);
					}else if(nextField && field.name != nextField.name){
						var temp = new Object();
						temp[field.name] = field.value;
						array.push(temp);
						object[field.name] = array;
						array = [];
					}else if(!nextField){
						var temp = new Object();
						temp[field.name] = field.value;
						array.push(temp);
						object[field.name] = array;
					}
				}
				
			});
			//针对“是否”类型的checbox特殊处理
			var conBoxObj = $(obj).find(":checkbox[unselectvalue]").not("[unserial='true']");
			$.each(conBoxObj,function(){
				if($(this).prop("checked")){//如果当前的checbox为选择状态，取它的value值。
					object[$(this).attr("name")] = $(this).attr("value");
				}else{
					object[$(this).attr("name")] = $(this).attr("unselectvalue");
				}
			});
			return object;
		},clear:function(obj){
			$(obj).find(":text,:password,textarea,input:hidden").val("");
			$(obj).find("select").each(function(){
				$(this).find("option").first().attr("selected",true);
			});
			$(obj).find(":radio").attr("checked",false);
			$(obj).find(":checkbox").attr("checked",false);
		},loadObj:function(obj,data){
			$(obj).find(":input,select,textarea").not(":checkbox,:radio,[unfillback='true']").each(function(){
				for(var element in data){
					if($(this).attr("name") == element){
						$(this).val(data[element]);
					}
				}
			});
			$(obj).find(":radio").not("[unfillback='true']").each(function(){
				for(var element in data){
					if($(this).attr("name") == element){
						$("input[name='"+$(this).attr("name")+"'][value='"+data[element]+"']").attr("checked",true);
					}
				}
			});
			$(obj).find(":checkbox").not("[unfillback='true']").each(function(){
				for(var element in data){
					if($(this).attr("name") == element){
						var listobj = data[element];
						if(listobj){
							if(jQuery.isArray(listobj)){
								$.each(listobj, function(i, son){
									for(var sonelement in son){
										$("input[name='"+sonelement+"'][value='"+son[sonelement]+"']").attr("checked",true);
									}
								});
							}else{
								var jQCheck = $(this);
								$.each(listobj.split(","), function(i, vstr){
									if(jQCheck.val() == vstr){
										jQCheck.prop("checked",true);
									}
								});
							}
						}
					}
				}
			});
		},loadUrl:function(obj, url){
			//by Leon 2012年6月7日 15:01:04。此方法改为有返回值。
			var backObj = new Object();
			$.ajax({
				type:"POST",
				url:url,
				dataType:"json",
				async:false,
				cache:false,
				success:function(jsonstr){
					$.fn.serialAll.methods.loadObj(obj,jsonstr);
					backObj = jsonstr;
				}
			});
			return backObj;
		}
	};
	/**
	 * 表单控件值的格式化。
	 * by Leon 2012年11月1日 11:32:25
	 */
	$.fn.formatForm = function(){
		//取得所有需要格式化的对象。
		var jQObject = $(this).find("[formatter]");
		$.each(jQObject,function(){
			if($.trim($(this).val()) != ""){
				var valueArry = $(this).val().split("");
				var dvalue = "";
				$.each(valueArry,function(){
					var regExp=/[0-9]|\./; 
					if(this != "" && regExp.exec(this)){
						//取出value中的所有数字，包含"."符号。
						dvalue += this.match(regExp);
					}
				});
				var formatter = $(this).attr("formatter");
				var fvalue = formatter;
				//判定格式化类型。
				if(formatter.indexOf("yyyy") != -1){
					fvalue = fvalue.replace("yyyy",dvalue.substring(0,4));
				}
				if(formatter.indexOf("MM") != -1){
					fvalue = fvalue.replace("MM",dvalue.substring(4,6));
				}
				if(formatter.indexOf("dd") != -1){
					fvalue = fvalue.replace("dd",dvalue.substring(6,8));
				}
				if(formatter.indexOf("###,###") != -1){
					var dArry = dvalue.split(".")[0].split("");
					var tempArry = [];
					$.each(dArry, function(){
						if(this != ""){
							tempArry.push(this);
						}
					});
					tempArry.reverse();
					dArry = [];
					$.each(tempArry,function(i){
						if(i != 0 && i%3 == 0){
							dArry.push(this + ",");
						}else{
							dArry.push(this);
						}
					});
					dArry.reverse();
					var tempStr = "";
					$.each(dArry,function(){
						tempStr += this;
					});
					fvalue = fvalue.replace("###,###",tempStr);
				}
				if(formatter.indexOf(".#") != -1){
					var endFormatterStr = formatter.split(".")[1];
					var pointSize = endFormatterStr.lastIndexOf("#") + 1;
					if(dvalue.split(".")[1]){
						if(dvalue.split(".")[1].length >= pointSize){
							fvalue = fvalue.replace(endFormatterStr.substring(0,pointSize),dvalue.split(".")[1].substring(0,pointSize));
						}else{
							fvalue = fvalue.replace(endFormatterStr.substring(0,pointSize),dvalue.split(".")[1]);
							var appendstr = "";
							for(var i=0;i<(pointSize - dvalue.split(".")[1].length); i++){
								appendstr +="0";
							}
							fvalue += appendstr;
						}
					}else{
						var appendstr = "";
						for(var i=0;i<pointSize; i++){
							appendstr +="0";
						}
						fvalue = fvalue.replace(endFormatterStr.substring(0,pointSize),appendstr);
					}
				}
				$(this).val(fvalue);
			}
		});
	};
})(jQuery);