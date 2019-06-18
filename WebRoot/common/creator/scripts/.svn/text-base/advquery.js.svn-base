//控制条件的显示隐藏
function topx(x){
	$("#easylist_form_content").find("li").each(function(i){
			if(i<x){
				//$(this).hide();
				$(this).show();
			}else{
				$(this).hide();
			}
	});
}


function _loadshuju(jsonArray,winid){
		$(".easylist_input_search").serialAll("load", jsonArray);
		$("#advqueryForm").serialAll("load", jsonArray);
		toQuery();
		topx(3);
		closeModelWindow(winid);
}

function lipaixu(arr){
		var array=arr.split(",");
		var xhtml="";
		$.each(array,function(i){
		if(""!=array[i]){
			 $("#easylist_form_content").find("li").each(function(z){
				if($(this).attr("id")==array[i]){
						xhtml+="<li class=\""+$(this).attr("class")+"\" id=\""+$(this).attr("id")+"\">";
						xhtml+=$(this).html();
						xhtml+="</li>";
				}
			});	
			}
		});
		$("#easylist_form_content").html(xhtml);
		topx(3);
		$("#div_querycon").show();
}
function loadtiaojian(webroot,user_id,sql_id){
	$.ajax({url:webroot+"/common/control/executeAJAX.page?jsonStr=[{\"_myType\":\"query\",\"_myDocketId\":\"docket_tb_self_facorites\",\"user_id\":\""+user_id+"\",\"sql_id\":\""+sql_id+"\"}]",
		   type:"POST", 
		   async:false,
		   cacahe:false, 
		   dataType:"text",
		   success:function (respData) {
			   if("true@操作成功"==respData||null==respData||""==respData){
			   
			   }else{
			 	  var jsonArray = eval("(" + respData + ")");
			 	  lipaixu(jsonArray.SEARCH_FAV_COLUMN);
			 	  $("#div_querycon").show();
			   }
		   }
	});
}
function gethhh(obj){
/**
	var httml="";
	httml+="<table id=\"mytable\">";
    $("#easylist_form_content").find("li").each(function(i){
    	var temp=$(this).html().replace("</LABEL>","</label>");
    	var strs= new Array(); 
		temps=temp.split("</label>");
    	var lab=temps[0]+"</label>";
    	var inp=temps[1];
		httml+="<tr><td class=\"width_pct7\"><input type=\"checkbox\" id=\"selObj\" name=\"selObj\" value=\""+$(this).attr("id")+"\" /></td><td class=\"width_pct7\"><span class=\"row_index\">"+(i+1)+"</span></td><td class=\"width_pct20\">";
		httml+=lab;
		httml+="</td><td class=\"width_pct45\">"
		httml+=inp;
		httml+="</td></tr>";
	});
	httml+="</table>";
	return httml;
		**/

	$(obj).append("<table id=\"mytable\"></table>");
	var table = $(obj).find('table#mytable');
    $("#easylist_form_content").find("li").each(function(i,domEle){
		$(table).append("<tr><td class=\"width_pct7\"><input type=\"checkbox\" id=\"selObj\" name=\"selObj\" value=\""+$(domEle).attr("id")+"\" /></td><td class=\"width_pct7\"><span class=\"row_index\">"+(i+1)+"</span></td><td class=\"width_pct25\"><td class=\"width_pct45\"></td></tr>");
		//$(table).find("tr:last").find("td:eq(2)").append($(this).find("label").clone(true));
		///alert($(domEle).find("label").clone(true).html());
		$(table).find("tr:last").find("td:eq(2)").append($(domEle).find("label").clone(true));
		$(table).find("tr:last").find("td:eq(3)").append($(domEle).find("label").nextAll().clone(true));
	});
	
}
