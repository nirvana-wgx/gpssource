<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>${title}</title>
		<link rel="stylesheet" href="<%=path%>/css/toolbars.css" type="text/css" media="all" />
		<script type="text/javascript" src="<%=path%>/scripts/jquery-1.7.1.min.js"></script>
		    <style type="text/css">
			    body {
			        font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
			        color: #4f6b72;
			        /*background: #E6EAE9;*/
			    }
			    table{
			        width:100%;
			    }
			    .commandsend_tab td{
			        border-right: 1px solid #CCCCFF;
			        border-bottom: 1px solid #CCCCFF;
			        background: #fff;
			        font-size:12px;
			        padding: 6px 6px 6px 12px;
			        color: #000000;
			        font-weight :normal ;
			    }
			    #tab_side{
			        border-right:0px;
			    }
			    fieldset{
			        border: 1px solid #CCCCFF;
			        border-bottom: 0px solid #CCCCFF;
			        font-size: 15px;
			        font-weight :bolder  ;
			        color: #000000;
			    }
			    fieldset legend{
			        color: #000000;
			    }
			    div{
			        width:99%;
			        margin-left:5px;
			    }
		    </style>
		    <script type="text/javascript">
		    $(function(){
	
				//绑定保存事件 
				$("#btn_ok").bind("click",function(){
						save();
				});
				//重置
				$("#btn_clear").bind("click",function(){
						clear();
				});
				 
				 // 绑定ajaxVehicle
				 $("#deviceid").bind("blur",function(){
				   var value =$(this).val();
				 	ajaxVehicle("deviceid",value);
				 });
				 $("#vehicleid").bind("blur",function(){
				 	var value =$(this).val();
				 	ajaxVehicle("vehicleid",value);
				 });
				 $("#sim").bind("blur",function(){
				 	var value =$(this).val();
				 	ajaxVehicle("sim",value);
				 });
			});
	
	//验证唯一性
	function ajaxVehicle(name,value){
		if($.trim(value)==""){
			return ;
		}
	    var str =name+"="+value;
		$.ajax({
					 url:"ajaxVehicle.page",
					 type:"POST",
					 dataType:"json",
					 data:str,
					 success:function(data){
					 	if(data.error=="1"){
					 		if(data.message=="deviceid"){
					 			 alert("设备编号存在");
					 			  $("input[name=deviceid]").val("");
					 		}else if(data.message=="vehicleid"){
					 			 alert("车辆编号存在");
					 			 $("input[name=vehicleid]").val("");
					 		}else if(data.message=="sim"){
					 			 alert("SIM卡号存在");
					 			 $("input[name=sim]").val("");
					 		}
					 	} 
					 }
				 });
	}
	//保存	
		
	function save(){
		if(!validform()){
			return ;
		}
		var str = $("form").serialize();
				 $.ajax({
					 url:"carsave.page",
					 type:"POST",
					 dataType:"json",
					 data:str,
					 success:function(data){
					 	if(data.message=="0"){
					 		alert("保存失败!");
					 	}else{
					 		alert("保存成功!");
					 		if($("input[name=rid]").val()==""){
					 			clear();
					 		}else{
					 			window.location="list.page";
					 		}
					 	}
					 }
				 });
	}
	// 验证 
	function validform(){
		    var ownername =$.trim($("input[name=ownername]").val());
		    var vehicleid =$.trim($("input[name=vehicleid]").val());
		    var deviceid =$.trim($("input[name=deviceid]").val());
		    var sim =$.trim($("input[name=sim]").val());
		    var ownerphone =$.trim($("input[name=ownerphone]").val());
			if(ownername==""){
				alert("最终用户不能为空");
				return false ;
			}
			
			if(vehicleid==""){
				alert("车辆编号不能为空");
				return false;
			}
			if(deviceid==""){
				alert("设备编号不能为空");
				return false;
			}
			if(sim==""){
				alert("SIM卡号不能为空");
				return false;
			}
			return true;
		}
		//重置
		function clear(){
		  $("input[name=ownername]").val("");
		  $("input[name=vehicleid]").val("");
		  $("input[name=deviceid]").val("");
		  $("input[name=sim]").val("");
		  $("input[name=ownerphone]").val("");
		}
		    </script>
    </head>

    <body>
            <div>
                <form action="" method="post" name="">
                <input type="hidden" name="rid" value="${car.rid}"/>
                <fieldset>
                <legend>
                   ${title }
                </legend>
                    <table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                        <tr>
                            <td id="tab_side" align="right">
                                    机械种类:
                            </td>
                            <td id="tab_side" align="left">
                                <select name="type" style="width:80px">
                                <c:forEach var="dictionary" items="${list_jxzl}">
                                	<option value="${dictionary.d_code}">${dictionary.d_value }</option>
                                </c:forEach>
                                </select>
                            </td>
                            <td id="tab_side" align="right">
                                    所属账号:
                            </td>
                            <td id="tab_side" align="left">
                                <select name="account" style="width:80px">
                                   <c:forEach var="account" items="${list_account}">
                                	<option value="${account.name}">${account.name}</option>
                                </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    机械状态:
                            </td>
                            <td id="tab_side" align="left">
                                <select name="carstate" style="width:80px">
                                  <c:forEach var="dictionary" items="${list_clzt}">
                                	<option value="${dictionary.d_code}">${dictionary.d_value }</option>
                                </c:forEach>
                                </select>
                            </td>
                            <td id="tab_side" align="right">
                                  机械类型:
                            </td>
                            <td id="tab_side" align="left">
                                <select name="typename" style="width:80px">
                                  <c:forEach var="dictionary" items="${list_jxlx}">
                                	<option value="${dictionary.d_code}">${dictionary.d_value }</option>
                                </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    最终用户:
                            </td>
                            <td id="tab_side" align="left">
                                <input type="text" name="ownername" maxlength="20" value="${car.ownername}">
                            </td>
                            <td id="tab_side" align="right">
                                    车辆编号:
                            </td>
                            <td id="tab_side" align="left">
                            <c:choose>
                            <c:when test="${car.vehicleid !=null }"><input type="text" maxlength="30" readonly name="vehicleid" value="${car.vehicleid}"></c:when>
                            <c:otherwise><input type="text" name="vehicleid" id="vehicleid" maxlength="30" value="${car.vehicleid}"></c:otherwise>
                            </c:choose>
                                
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    设备编号:
                            </td>
                            <td id="tab_side" align="left">
                             <c:choose>
                            <c:when test="${car.deviceid !=null }"> <input type="text" readonly maxlength="10" name="deviceid" value="${car.deviceid}"></c:when>
                            <c:otherwise> <input type="text" name="deviceid" id="deviceid" maxlength="10" value="${car.deviceid}"></c:otherwise>
                            </c:choose>
                               
                            </td>
                            <td id="tab_side" align="right">
                                SIM卡号:
                            </td>
                            <td id="tab_side" align="left">
                             <c:choose>
                            <c:when test="${car.sim !=null }"><input type="text" readonly maxlength="15" name="sim" value="${car.sim}"></c:when>
                            <c:otherwise><input type="text" name="sim" id="sim" maxlength="15" value="${car.sim}"></c:otherwise>
                            </c:choose>
                                
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    联系方式:
                            </td>
                            <td id="tab_side" align="left">
                                <input type="text" name="ownerphone" maxlength="" value="${car.ownerphone}">
                            </td>
                            <td id="tab_side" align="right">
                            		  &nbsp;
                            </td>
                             <td id="tab_side" align="left">
                                       &nbsp;
                            </td>
                            <!--<td id="tab_side" align="right">
                            <c:choose>
                            <c:when test="${car.isnoice !=null}">  <input name="isnoice" type="checkbox" value="1" checked/></c:when>
                            <c:otherwise><input name="isnoice" type="checkbox" value="1"/></c:otherwise>
                            </c:choose>
                            </td>
                            <td id="tab_side" align="left">
                                     日报短信通知
                            </td>
                        --></tr>
                        <tr>
			               <td colspan="8" align="center">
			              <a href="javascript:void(0)" id="btn_ok"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_ok">保存</span></span></a>
			              <a href="javascript:void(0)" id="btn_clear"><span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_clear">重置</span></span></a>
			               </td>
			            </tr>
                    </table>
                </fieldset>
                </form>
                </div>
	</body>
</html>