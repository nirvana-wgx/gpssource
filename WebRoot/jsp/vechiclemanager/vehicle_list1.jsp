<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gps.login.service.AccountServiceImpl"%>
<%@page import="com.gps.login.service.IAccountService"%>
<%@page import="com.gps.login.entity.Account"%>
<%@page import="java.util.List"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<link href="<%=path%>/css/toolbars.css" rel="stylesheet" type="text/css" />
        <link href="<%=path%>/css/common.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div>
		    <form>
		    <table cellspacing="0">
            <tr>
               <td colspan="2" align="center"><input name="lock" type="checkbox" value="" />被锁定</td>
               <td colspan="2" align="center"><input name="nowork" type="checkbox" value="nowork" />长时间不工作(10天未接收)</td>
               <td colspan="2" align="center"><input name="locateex" type="checkbox" value="locateex" />定位异常(10天未定位)</td>
               <td colspan="2" align="center">&nbsp;</td>
            </tr>
            <tr>
               <td align="right">
                    机械种类:
               </td>
               <td align="left">
                  <select name="type" style="width:80px">
                      <option value="">全部</option>
                      <option value="">挖掘机</option>
                      <option value="">推土机</option>
                      <option value="">装载机</option>
                      <option value="">小汽车</option>
                      <option value="">平地机</option>
                      <option value="">泵车</option>
                      <option value="">压路机</option>
                  </select>
               </td>
               <td align="right">
                                    机型:
               </td>
               <td align="left">
                  <select name="type" style="width:80px">
                      <option value="">全部</option>
                      <option value="">BM01</option>
                  </select>
               </td>
               <td align="right">
                  机械状态:
               </td>
               <td align="left">
                  <select name="type" style="width:80px">
                      <option value="">全部</option>
                      <option value="">入库</option>
                      <option value="">测试</option>
                      <option value="">销售</option>
                  </select>
               </td>
               <td align="right">
                  所属账号:
               </td>
               <td align="left">
                  <select name="type" style="width:80px">
                      <option value="">全部</option>
                      <option value="">root</option>
                  </select>
               </td>
            </tr>
            <tr>
               <td align="right">最终用户:</td>
               <td align="left"><input type="text"/></td>
               <td align="right">机号:</td>
               <td align="left"><input type="text"/></td>
               <td align="right">设备号:</td>
               <td align="left"><input type="text"/></td>
               <td align="right">SIM卡号:</td>
               <td align="left"><input type="text"/></td>
            </tr>
            <tr>
               <td colspan="8" align="center">
                  <a href="javascript:void(0)" onclick="" id="btn_add"> <span
                                class="toolbar_btn"><span
                                    class="toolbar_btn_ico toolbar_btn_search">查询</span></span></a>
                            <a href="javascript:void(0)" onclick="" id="btn_add"><span
                                class="toolbar_btn"><span
                                    class="toolbar_btn_ico toolbar_btn_clear">重置</span>
                            </span></a>
               </td>
            </tr>
         </table>
         <br/>
		    <table cellpadding="0">
		    <tr><td colspan="99">
                <div id="div_list">
                <table id="tab_list" cellspacing="0">
                <tr>
	                <th width="60">
	                    命令下发
	                </th>
	                <th width="60">
	                    历史查询
	                </th>
	                <th>
	                                    机型
	                </th>
	                <th>
	                                    机号
	                </th>
	                <th>
	                    接收时间
	                </th>
	                <th>
	                    工作小时
	                </th>
	                <th>
	                                    位置
	                </th>
	                <th>
	                    工作状态
	                </th>
	                <th>
	                    机械状态
	                </th>
	                <th>
	                                    操作
	                </th>
	                <th title="机械报警">
                      M
                    </th>
                    <th title="终端报警">
                      G
                    </th>
                    <th title="被锁定">
                      L
                    </th>
                    <th title="定位异常">
                      P
                    </th>
                </tr>
                <tr>
                    <td align="left">
                        <input type="button" value="下发" name="" />
	                </td>
	                <td align="left">
	                    <input type="button" value="查询" name="" onclick="goHistory()"/>
	                </td>
	                <td>
	                    BM01
	                </td>
	                <td>
	                    <a id="" href="javascript:void(0)" onclick="">CM002</a>
	                </td>
	                <td>
	                    2013-06-06 13:11:43
	                </td>
	                <td>
	                    1235.23小时
	                </td>
	                <td>
	                                        西藏自治区，昌都地区，银都县
	                </td>
	                <td>
	                    <input type="image" name="ck" src="<%=path%>/images/ok.gif" />
	                </td>
	                <td>
	                       销售
	                </td>
	                <td>
	                    <a href="javascript:void(0)" onclick="openRefund()">还款</a>/<a href="javascript:void(0)" onclick="openMaintain()">保养</a>/<a href="javascript:void(0)" onclick="updVehicle()">修改</a>/<a href="#">删除</a>
	                </td>
	                <td title="机械报警">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="终端报警">
                        &nbsp;
                    </td>
                    <td title="被锁定">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="定位异常">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
	               </tr>
	               <tr>
                    <td align="left">
                        <input type="button" value="下发" name="" />
                    </td>
                    <td align="left">
                        <input type="button" value="查询" name="" onclick="goHistory()"/>
                    </td>
                    <td>
                        BM01
                    </td>
                    <td>
                        <a id="" href="javascript:void(0)" onclick="">CM001</a>
                    </td>
                    <td>
                        2013-06-06 13:12:56
                    </td>
                    <td>
                        1514.56小时
                    </td>
                    <td>
                                            西藏自治区，昌都地区，丁青县
                    </td>
                    <td>
                        <input type="image" name="ck" src="<%=path%>/images/close.gif" />
                    </td>
                    <td>
                           入库
                    </td>
                    <td>
                        <a href="javascript:void(0)" onclick="openSale()">销售</a>/<a href="javascript:void(0)" onclick="updVehicle()">修改</a>/<a href="#">删除</a>
                    </td>
                    <td title="机械报警">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="终端报警">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="被锁定">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="定位异常">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                   </tr>
                   <tr>
                    <td align="left">
                        <input type="button" value="下发" name="" />
                    </td>
                    <td align="left">
                        <input type="button" value="查询" name="" onclick="goHistory()"/>
                    </td>
                    <td>
                        BM01
                    </td>
                    <td>
                        <a id="" href="javascript:void(0)" onclick="">CM003</a>
                    </td>
                    <td>
                        2013-06-11 09:14:13
                    </td>
                    <td>
                        876.23小时
                    </td>
                    <td>
                                            西藏自治区，昌都地区，水牛县
                    </td>
                    <td>
                        <input type="image" name="ck" src="<%=path%>/images/close.gif" />
                    </td>
                    <td>
                           测试
                    </td>
                    <td>
                        <a id="test" href="javascript:void(0)" onclick="openTest()">入库</a>/<a href="javascript:void(0)" onclick="updVehicle()">修改</a>/<a href="#">删除</a>
                    </td>
                    <td title="机械报警">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="终端报警">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="被锁定">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                    <td title="定位异常">
                        <img src="<%=path%>/images/icon_warning.gif"/>
                    </td>
                   </tr>
	             </table>
	           </div>
            </td>
         </tr>
         
         <tr>
                     <td colspan="99" class="jpaginate">
                        <a href="#"><img src="<%=path%>/images/sprevious.png" /></a>
                        <a href="#"><img src="<%=path%>/images/previous.png" /></a>
                        <span>第<input type="text" value="1" />页/22页</span>
                        <a href="#"><img src="<%=path%>/images/next.png" /></a>
                        <a href="#"><img src="<%=path%>/images/snext.png" /></a> 
                        <span>每页<input type="text" value="15" />条</span>
                        <a href="#"><img src="<%=path%>/images/Refresh.gif"/></a> </td>
                </tr>
        </table>
		       
		    </form>
		</div>
	</body>
</html>
<script type="text/javascript">
    //入库弹出框
    function openTest(){
	  digStr="dialogHeight:300px;dialogWidth:600px;center:yes"
	  var ReturnValue = window.showModalDialog("<%=path%>/jsp/vechiclemanager/vehicle_test_add.jsp","",digStr)
	  alert(ReturnValue);
	 }
	 //销售弹出框
    function openSale(){
      digStr="dialogHeight:400px;dialogWidth:600px;center:yes"
      var ReturnValue = window.showModalDialog("<%=path%>/jsp/vechiclemanager/saleinf_add.jsp","",digStr)
     }
     //还款弹出框
    function openRefund(){
      digStr="dialogHeight:300px;dialogWidth:600px;center:yes"
      var ReturnValue = window.showModalDialog("<%=path%>/jsp/vechiclemanager/refundinf_add.jsp","",digStr)
     }
     //保养弹出框
    function openMaintain(){
      digStr="dialogHeight:300px;dialogWidth:600px;center:yes"
      var ReturnValue = window.showModalDialog("<%=path%>/jsp/vechiclemanager/maintain_add.jsp","",digStr)
     }
     //历史信息
    function goHistory(){
      //digStr="dialogHeight:600px;dialogWidth:700px;center:yes"
      window.open("<%=path%>/jsp/vechiclemanager/singlevehicle/history_info.jsp");
      //var ReturnValue = window.showModalDialog("<%=path%>/jsp/vechiclemanager/singlevehicle/history_info.jsp","",digStr)
     }
	 //修改弹出框
    function updVehicle(){
      digStr="dialogHeight:300px;dialogWidth:600px;center:yes"
      var ReturnValue = window.showModalDialog("<%=path%>/jsp/vechiclemanager/vehicle_edit.jsp","",digStr)
     }
</script>
