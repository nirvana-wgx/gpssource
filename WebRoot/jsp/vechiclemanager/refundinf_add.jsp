<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>还款信息添加</title>
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
                 还款信息登记
            </legend>
                <table  border="0" cellspacing="0" cellpadding="0" class="commandsend_tab">
                    <tr>
                        <td id="tab_side" align="right">
                                还款金额：
                        </td>
                        <td id="tab_side" align="left">
                            <input type="text" value="" name="name" class="" />
                        </td>
                        <td id="tab_side" align="right">
                                实际还款日期：
                        </td>
                        <td id="tab_side" align="left">
                            <input type="text" value="" id="testdate" name="testdate" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
                        </td>
                    </tr>
                    <tr>
                        <td id="tab_side" align="right">
                                所剩余额：
                        </td>
                        <td id="tab_side" align="left" colspan="3">
                            <input type="text" value="" name="name" class="" />
                        </td>
                    </tr>
                    <tr>
                        <td id="tab_side" align="center" colspan="4">
                            <a href="javascript:void(0)" onclick="" id="btn_add"> <span
                                    class="toolbar_btn"><span
                                        class="toolbar_btn_ico toolbar_btn_ok">保存</span></span></a>
                                <a href="javascript:void(0)" onclick="closeWin()" id="btn_add"><span
                                    class="toolbar_btn"><span
                                        class="toolbar_btn_ico toolbar_btn_cancel">关闭</span>
                                </span></a>
                        </td>
                    </tr>
                </table>
             </fieldset>
          </form>
       </div>
	</body>
</html>
<script type="text/javascript">
    function closeWin(){
        window.returnValue = "入库信息添加成功";
        window.close();
    }
</script>