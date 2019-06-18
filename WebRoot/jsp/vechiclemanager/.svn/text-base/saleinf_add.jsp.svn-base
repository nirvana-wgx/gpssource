<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>销售信息新增</title>
		<script type="text/javascript" src="<%=path %>/plugs/My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" href="<%=path%>/css/toolbars.css" type="text/css" media="all" />
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
    </head>

    <body>
            <div>
                <form action="" method="post" name="">
                <fieldset>
                <legend>
                    销售信息
                </legend>
                  <div id="base">
                    <table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                        <tr>
                            <td id="tab_side" align="right">
                                    购买人:
                            </td>
                            <td id="tab_side" align="left">
                                <input type="text" id="">
                            </td>
                            <td id="tab_side" align="right">
                                    购买时间:
                            </td>
                            <td id="tab_side" align="left">
                                <input type="text" value="" id="testdate" name="testdate" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                                                付款方式:
                            </td>
                            <td id="tab_side" align="left" colspan="3">
                                <select id="payway" name="payway" style="width:80px" onChange="change()">
                                   <option value="">全款</option>
                                   <option value="">分期</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                   </div>
                   <div id="inf" style="display:none">
                    <table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                        <tr>
                            <td id="tab_side" align="right">
                                    预付款项:
                            </td>
                            <td id="tab_side" align="left">
                                <input type="text" id="">
                            </td>
                            <td id="tab_side" align="right">
                                    月供额度:
                            </td>
                            <td id="tab_side" align="left">
                                <input type="text" id="">
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    还款年限:
                            </td>
                            <td id="tab_side" align="left">
                                <select name="type" style="width:80px">
                                   <option value="">2年期</option>
                                   <option value="">3年期</option>
                                   <option value="">5年期</option>
                                </select>
                            </td>
                            <td id="tab_side" align="right">
                                    还款预警日期:
                            </td>
                            <td id="tab_side" align="left" colspan="3">
                                <input type="text" value="" id="testdate" name="testdate" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
                            </td>
                        </tr>
                    </table>
                   </div>
                   <div id="ds">
                    <table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                        <tr>
                           <td colspan="8" align="center">
                              <a href="javascript:void(0)" onclick="" id="btn_add"> <span
                                            class="toolbar_btn"><span
                                                class="toolbar_btn_ico toolbar_btn_ok">保存</span></span></a>
                                        <a href="javascript:void(0)" onclick="" id="btn_add"><span
                                            class="toolbar_btn"><span
                                                class="toolbar_btn_ico toolbar_btn_clear">重置</span>
                                        </span></a>
                           </td>
                        </tr>
                    </table>
                   </div>
                 </fieldset>
              </form>
           </div>
	</body>
</html>
<script type="text/javascript">
    function change(){
        var index = document.getElementById('payway').selectedIndex;
        if(index==1){
            document.getElementById('inf').style.display="";
        }else{
            document.getElementById('inf').style.display="none";
        }
    }
</script>