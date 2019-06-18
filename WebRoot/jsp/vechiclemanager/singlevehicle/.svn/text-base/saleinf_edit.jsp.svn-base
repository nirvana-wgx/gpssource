<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                   <div style="text-align:right;width:98%;margin-buttom:5px;">
                      <a href="<%=path%>/jsp/vechiclemanager/singlevehicle/SalesInfDownload.page?vehicleid=${ relation.deviceid }">导出</a>
                   </div>
                  <div id="base">
                    <table  style="margin-top:5px;border-collapse:collapse;border-spacing:0;" class="commandsend_tab">
                        <tr>
                            <td id="tab_side" align="right">
                                                                机号:
                            </td>
                            <td id="tab_side" align="left">
                                ${ relation.vehicleid }
                            </td>
                            <td id="tab_side" align="right">
                                                                付款方式:
                            </td>
                            <td id="tab_side" align="left">
                                ${ relation.payway }
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    购买人:
                            </td>
                            <td id="tab_side" align="left">
                               ${ relation.buyname }
                            </td>
                            <td id="tab_side" align="right">
                                    购买日期:
                            </td>
                            <td id="tab_side" align="left">
                                ${ relation.buytime }
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    预付款项:
                            </td>
                            <td id="tab_side" align="left">
                                ${ relation.prepay }
                            </td>
                            <td id="tab_side" align="right">
                                    月供额度:
                            </td>
                            <td id="tab_side" align="left">
                                ${ relation.paymonth }
                            </td>
                        </tr>
                        <tr>
                            <td id="tab_side" align="right">
                                    还款年限:
                            </td>
                            <td id="tab_side" align="left">
                                 ${ relation.payterm }
                            </td>
                            <td id="tab_side" align="right">
                                    还款预警日期:
                            </td>
                            <td id="tab_side" align="left" colspan="3">
                                ${ relation.paywarndate }
                            </td>
                        </tr>
                    </table>
                   </div>
                 </fieldset>
              </form>
           </div>
	</body>
</html>