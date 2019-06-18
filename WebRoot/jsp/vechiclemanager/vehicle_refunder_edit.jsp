<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>还款信息添加</title>
		<script type="text/javascript" src="<%=path %>/plugs/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" ></script>
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
                #main{
                    width:99%;
                    margin-left:5px;
                }
                /*处理时间控件位置偏移*/
                div {
					    border-left: 0px;
					    border-top: 0px;
					    margin-left: 0px;
					    width: 0%;
					}
            </style>
<script type="text/javascript">
    function btn_close(){
        window.close();
    }
    function btn_ok(){
      var refundmoney = $("#refundmoney").val();
      var refundtime = $("#refundtime").val();
      var remainmoney = $("#remainmoney").val();
      
      if(refundmoney == '' || refundtime == '' || remainmoney == ''){
         alert("必填项不能为空");
         return;
      }
      
    	var str = $("form").serialize();
        window.returnValue = str;
        window.close();
    }
</script>
	</head>

	<body>
        <div id="main">
            <form   method="post" >
            <fieldset>
            <legend>
                 还款信息登记
            </legend>
                <table  style="border-collapse:collapse;border-spacing:0;" class="commandsend_tab">
                    <tr>
                        <td id="tab_side" align="right">
                                还款金额：
                        </td>
                        <td id="tab_side" align="left">
                            <input type="text" value="" id="refundmoney" name="refundmoney"  /><span style="color:red;margin-left:5px;">*</span>
                        </td>
                        <td id="tab_side" align="right">
                                实际还款日期：
                        </td>
                        <td id="tab_side" align="left">
                            <input type="text" value="" id="refundtime"  name="refundtime" class="Wdate" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /><span style="color:red;margin-left:5px;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td id="tab_side" align="right">
                                所剩余额：
                        </td>
                        <td id="tab_side" align="left" colspan="3">
                            <input type="text"  id="remainmoney" name="remainmoney"  /><span style="color:red;margin-left:5px;">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td id="tab_side" align="center" colspan="4">
                            <a href="javascript:void(0)" onclick="btn_ok();" id="btn_ok"><span  class="toolbar_btn"><span  class="toolbar_btn_ico toolbar_btn_ok">保存</span></span></a>
                            <a href="javascript:void(0)" onclick="btn_close();" id="btn_cancel"><span  class="toolbar_btn"><span  class="toolbar_btn_ico toolbar_btn_cancel">关闭</span></span></a>
                        </td>
                    </tr>
                </table>
             </fieldset>
          </form>
       </div>
	</body>
</html>
