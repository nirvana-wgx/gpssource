<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>数据字典管理</title>
		<link href="<%=path%>/css/toolbars.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" ></script>
		<style type="text/css">
	body {
		/*font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
		color: #4f6b72;
		background: #E6EAE9;*/
	} 
	
	table {
		width: 100%;
		cellpadding:0;
		cellspacing:0;
	}
	
	table td {
		border-right: 1px solid #CCCCFF;
		border-bottom: 1px solid #CCCCFF;
		 
		background: #fff;
		font-size: 12px;
		padding: 1px 1px 1px 1px;
		color: #5C5C5C;
		font-weight: normal;
		text-align: center;
	}
	
	
	
	td.left {
		text-align: right;
	}
	
	td.right {
		text-align: left;
	}
	
	div {
		width: 99%;
		margin-left: 5px;
		border-top:1px solid #CCCCFF;
		border-left:1px solid #CCCCFF;
	}
	.jpaginate{
		text-align: right;
	}
	.jpaginate input{
		margin-right:20px;
		margin-left:20px;
	    width:30px;
	}
	.jpaginate a{
		text-decoration: none;
		border :0px;
	}
	a img{
		height:15px;
		border :0px;
		margin-left :5px;
		margin-right :5px;
	}
	span{
		margin-buttom:5px;
		margin-right:20px;
		font-size: 15px;
	}
	#div_list{
		width :100%;
		height:260px;
		margin :0px;
		padding:0px;
		border:0px;
		overflow:auto;
	}
	
	#tab_list td{
		border-right: 1px solid #CCCCFF;
		border-bottom: 1px solid #CCCCFF;
		spacell:0px;
		background: #fff;
		font-size: 12px;
		padding: 0px;
		margin:0px;
		color: #5C5C5C;
		font-weight: normal;
		text-align: center;
	}
	#tab_list th {
		border-right: 1px solid #CCCCFF;
		border-bottom: 1px solid #CCCCFF;
		border-width: thin;
		background: #f5fafa;
		font-size: 12px;
		padding: 0px;
		margin:0px;
		color: #5C5C5C;
		font-weight: bloder;
	}
	span{
		font-size: 12px;
		color: #5C5C5C;
	}
</style>
<script type="text/javascript">
$(function(){
	    	//绑定重置
	    	$("#btn_clear").bind("click",function(){
	    		clear();
	    	});
	    	//查询
	    	$("#btn_search").bind("click",function(){
	    		query();
	    	});
	    	//刷新
	    	$("#refresh").bind("click",function(){
	    		query();
	    	});
	    	$("#sprevious").bind("click",function(){
	    		query("sprevious");
	    	});
	    	$("#previous").bind("click",function(){
	    		query("previous");
	    	});
	    	$("#snext").bind("click",function(){
	    		query("snext");
	    	});
	    	$("#next").bind("click",function(){
	    		query("next");
	    	});
	    	$("input[name=currentPage]").bind("change",function(){
	    		var totalPage=new Number($("input[name=totalPage]").val());
	    		if($(this).val()>totalPage){
	    			$(this).val(1);
	    		}
	    	});
	    	$("input[name=pageSize]").bind("change",function(){
	    			$("input[name=currentPage]").val(1);
	    	});
	    	$("input:checkbox").bind("click",function(){
		    	var aid =$(this).val();
		    	selectOne(aid);
	    	});
	    	//新增
	    	$("#btn_add").bind("click",function(){
	    		add();
	    	});
	    	//修改
	    	$("#btn_modify").bind("click",function(){
	    		modify();
	    	});
	    	//删除
	    	$("#btn_remove").bind("click",function(){
	    		remove();
	    	});
}) ;
 
function add(){
  $("#queryform").attr("action","update.page");
  $("#queryform").submit();
}
function remove(){
	var d_code =$("input:checked:eq(0)").val();
	if($.trim(d_code)==""){
		alert("请选择一条数据");
		return ;
	}
	$("#queryform").attr("action","delete.page");
	$("#queryform").submit();
}
function modify(){
	var d_code =$("input:checked:eq(0)").val();
	if($.trim(d_code)==""){
		alert("请选择一条数据");
		return ;
	}
	$("#queryform").attr("action","update.page");
	$("#queryform").submit();
}

function selectOne(aid){
	$("form input:checkbox").each(function(){
			if($(this).val() !=aid){
				$(this).removeAttr("checked");
			}
	});
}
function selectAll(){
	var iSelect =$("input[name=selectAll]").attr("checked");
	$("form input:checkbox").each(function(){
		if(iSelect){
			$(this).attr("checked",iSelect);
		}else{
			$(this).removeAttr("checked");
		}
	});
}
function clear(){
		  $("input[name=d_value]").val("");
}
function query(type){
					var currentPage=new Number($("input[name=currentPage]").val());
					var totalPage =new Number($("input[name=totalPage]").val());
 					if(!type){
						$("#queryform").submit();
						return ;
					}else if(type=="sprevious"){//首页
					  if(currentPage>1){
					    $("input[name=currentPage]").val(1);
						$("#queryform").submit();
						return ;
					  }
					}else if(type=="previous"){//上一页
					   if(currentPage>1){
					    currentPage=currentPage-1;
					 	$("input[name=currentPage]").val(currentPage);
						$("#queryform").submit();
						return ;
					   }
					 	
					}else if(type=="next"){//下一页
						if(currentPage<totalPage){
							currentPage=currentPage+1;
							$("input[name=currentPage]").val(currentPage);
							$("#queryform").submit();
							return ;
						}
					}else if(type=="snext"){//末页
						$("input[name=currentPage]").val(totalPage);
						$("#queryform").submit();
						return ;
					}else if(type=="refresh"){//刷新
						$("#queryform").submit();
						return ;
					}else{
					
					}
					
					
}
</script>
	</head>

	<body>
		<div>
			<form id="queryform"  action="query.page" method="post">
				<table cellspacing="0">
					<tr>
						<td>
							名称
						</td>
						<td>
							<input type="text" name="d_value" value="${d_value }"/>
						</td>
						<td>
							<a href="javascript:void(0)" id="btn_search"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
							<a href="javascript:void(0)" id="btn_clear"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_clear">重置</span></span></a>
						</td>
					</tr>
				</table>
		
			<table cellspacing="0">
				<tr>
					<td class="left" colspan="99">
						<!-- 工具条 按钮 -->
						<a href="javascript:void(0)" id="btn_add"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_add">新增</span></span></a>
						<a href="javascript:void(0)" id="btn_modify"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_edit">修改</span></span></a>
						<a href="javascript:void(0)" id="btn_remove"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_remove">删除</span></span></a>
					</td>
				</tr>
				<tr><td colspan="99">
				<div id="div_list">
				<table id="tab_list" cellspacing="0">
				<tr>
					<th>
						 
					</th>
					<th> 
						 <input type="checkbox" name="selectAll"/>  
					</th>
					<th>
						名称
					</th>
					 
					<th>
						Key值
					</th>
					 <th>
						类型
					</th>
				</tr>
				<c:forEach var ="dictionary" items="${list}" varStatus="xh">
				<tr>
					<td>
						  ${xh.count}
					</td>
					<td>
						<input type="checkbox" name ="d_code" value ="${dictionary.d_code}"/>
					</td>
					<td>
						${dictionary.d_value}
					</td>
					<td>
						${dictionary.d_code}
					</td>
					<td>
						${dictionary.d_typeName}
					</td>
				</tr>
				 </c:forEach>
				</table>
				</div>
				
				</td></tr>
				
				<tr>
					 <td colspan="99" class="jpaginate">
					    <input type="hidden"  name="totalPage" value="${totalPage}"/>
					    <input type="hidden"  name="d_type" value="${d_type}"/>
						<a href="javascript:void(0)" id="sprevious"><img src="<%=path%>/images/sprevious.png" /></a>
						<a href="javascript:void(0)" id="previous"><img src="<%=path%>/images/previous.png" /></a>
						<span>第<input type="text"    name="currentPage" value="${currentPage}"/>页/${totalPage}页</span>
						<a href="javascript:void(0)" id="next"><img src="<%=path%>/images/next.png" /></a>
						<a href="javascript:void(0)" id="snext"><img src="<%=path%>/images/snext.png" /></a> 
						<span>每页<input type="text"    name="pageSize" value="${pageSize}"/>条，共${total}条</span>
						<a href="javascript:void(0)" id="refresh"><img src="<%=path%>/images/Refresh.gif"/></a> </td>
				</tr>
			</table>
	</form>
		</div>
	</body>
</html>
