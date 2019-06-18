<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();

%>

<html>
  <head>
    
    <title>����������Ϣ</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- 	<link href="<%=path %>/css/toolbars.css" rel="stylesheet" type="text/css" /> -->
   <link href="<%=path %>/css/common.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript" src="<%=path %>/scripts/jquery-1.7.1.min.js" > </script>
	
	<style type="text/css">
	   body { background: #E6EAE9; background-image:url(<%=path %>/images/006.jpg) }
      fieldset { background: #FFFFFF;filter:alpha(opacity=70);-moz-opacity: 0.70; opacity: 0.70;  }
      .dis_none {border: 0 none;color: red;margin-top: 20px;text-align: center;}
      .state{clear:both;margin-left:16%;overflow:hidden;padding:5px 0 ;width:700px;font-size:12px;border:0px;}
      .state ul li{list-style:none;float:left;width:72px;height:28px;padding:6px 8px 7px 5px; line-height:14px;text-align:center;font-size:12px;background:#FFFFFF}
      .state ul li.normal{background:url(<%=path %>/images/state_grey.gif) no-repeat left top;color:#5a646e; }
      .state ul li.normal span{ display:block;color:#333; font-weight:bold;margin-left: 20px;}
      .state ul li.warning{background:url(<%=path %>/images/state_red.gif) no-repeat left top;color:#000; }
      .state ul li.warning span{ display:block;color:#000; font-weight:bold;margin-left: 20px;}
      .state ul li.on{background:url(<%=path %>/images/state_green.gif) no-repeat left top;color:#000; }
      .state ul li.on span{ display:block;color:#000; font-weight:bold;margin-left: 20px;}
      .state2{clear:both;border:0px;margin-left:-48px;overflow:hidden;width:106%;text-align:left;font-size:12px;height:90px;}
      .state2 ul li{list-style:none;float:left;width:72px;height:28px;padding:5px 3px 8px 6px;line-height:14px;text-align:center; }
      .state2 ul li.normal{background:url(<%=path %>/images/state_grey.gif) no-repeat left top;color:#5a646e; }
      .state2 ul li.normal span{ display:block;color:#333; font-weight:bold;margin-right:0px;}
      .state2 ul li.warning{background:url(<%=path %>/images/state_red.gif) no-repeat left top;color:#000; }
      .state2 ul li.warning span{ display:block;color:#000; font-weight:bold;margin-right:0px;}
      .state2 ul li.on{background:url(<%=path %>/images/state_green.gif) no-repeat left top;color:#000; }
      .state2 ul li.on span{ display:block;color:#000; font-weight:bold;margin-right:0px;}
   </style>	   
  </head>
  
  <body>
    <!--�������� ��ʼ-->
    <fieldset>
      <legend>�豸��ϸ��Ϣ</legend>
      <table id="tab_list">
            <tr>
               <th>��е����</th>
               <th>����</th>
               <th>����</th>
               <th>�豸��</th>
               <th>SIM����</th>
            </tr>
            <tr>
               <td>${ type_name }</td>
               <td>${ relation.typename }</td>
               <td>${ relation.vehicleid }</td>
               <td>${ relation.deviceid }</td>
               <td>${ relation.sim }</td>
            </tr>
            <tr>
                <th>����״̬</th>
                <th>�����˺�</th>
                <th>�����û�</th>
                <th>��ϵ��ʽ</th>
                <th>¼��ʱ��</th>
            </tr>
            <tr>
                <td>${ relation.carstate }</td>
                <td>${ relation.account }</td>
                <td>${ relation.ownername }</td>
                <td>${ relation.ownerphone }</td>
                <td>${ relation.createtime }</td>
            </tr>
        </table>
      </fieldset>
        <br/>
        <fieldset>
        <legend>λ����Ϣ</legend>
        <table id="tab_list">
            <tr>
               <th width="10%">��λʱ�䣺</th>
               <td width="25%"><b style="color:red;"><fmt:formatDate value="${ messagebm.collecttime }" pattern="yyyy��MM��dd��  HH:mm:ss"/></b></td>
               <th width="8%">���ȣ�</th>
               <td width="17%">${ messagebm.longitude }</td>
               <th width="8%">γ�ȣ�</th>
               <td width="17%">${ messagebm.latitude }</td>
               <th width="10%">����������</th>
               <td width="5%">${ messagebm.satelliteusable }</td>
            </tr>
            <tr>
                <th width="10%">λ�ã�</th>
                <td colspan="5">
                     <a class="positionMap" href="javascript:void(0);">
                        ${ messagebm.positioninfo }
                     </a>
                </td>
                <td colspan="2"><a class="positionMap" href="javascript:void(0);"><img style="border:0px;" src="<%=path %>/images/map_button.gif" alt="��ͼ"></a></td>
            </tr>
        </table>
         <!-- 
         <img src="../images/btn_detail02.gif" alt="��Ƭ"></a>&nbsp;&nbsp;<a href="#"><img src="../images/btn_detail03.gif" alt="�켣�ط�"></a>
          -->
       </fieldset>     
       <br/>  
       <fieldset>
       <legend>������Ϣ</legend>
       
       <table id="tab_list">
            <tr>
                <th>��Ϣ�ϴ�ʱ��</th>
                <th>��Ϣ����</th>
                <th>����Сʱ</th>
                <th>��λ</th>
                <th>������״̬</th>
                <th>��ȴˮ��</th>
                <th>����ѹ��</th>
            </tr>
            <tr>
                <td><b style="color:red;"><fmt:formatDate value="${ messagebm.receivetime }" pattern="yyyy��MM��dd��  HH:mm:ss"/></b></td>
                <td>${ messagebm.infotype }</td>
                <td><b style="color:red;">${ messagebm.worktime }</b></td>
                <td>${ messagebm.oillevel }</td>
                
                <!-- ������״̬:�ο�messagebm.getAutoLockString() -->
                <td
                  <c:if test="${ AutoLockString != '����' }">
                     style="font-weight:normal;font-size:12px;"
                  </c:if>
                >
                  ${ AutoLockString }
                </td>
                <td>${ messagebm.watertemperature }</td>
                <td>${ messagebm.oilpressure }</td>
            </tr>
            <tr>
                <th>���ݲɼ�ʱ��</th>
                <th>��Դ��ѹ</th>
                <th>оƬ�¶�</th>
                <th>ת��</th>
                <th>�󱸵�ص�ѹ</th>
                <th>����״̬</th>
                <th>Һѹ����</th>
            </tr>
            <tr>
                <td><b style="color:red;"><fmt:formatDate value="${ messagebm.collecttime }" pattern="yyyy��MM��dd��  HH:mm:ss"/></b></td>
                <td>${ messagebm.voltage }</td>
                <td>${ messagebm.envtemperature }</td>
                <td>${ messagebm.rotaryspeed }</td>
                <td>${ messagebm.backup }</td>
                <!-- ����״̬���ο�messagebm.getLockString() -->
                <td
                  <c:if test="${ LockString != '����' }">
                     style="color:red;"
                  </c:if>
                >
                  ${ LockString }
                </td>
                <td>${ messagebm.oiltemperature }</td>
            </tr>
        </table>
        
        <div class="dis_none"
           <c:if test="${ messagebm.deviceid != '' && messagebm.deviceid != null }">
              style="display:none;"
           </c:if>
        >
           ��ǰ������
        </div>
        
        <div class="state2"
           <c:if test="${ messagebm.deviceid == '' || messagebm.deviceid == null }">
              style="display:none;"
           </c:if>
        >
        <ul>
           <c:choose>
             <c:when test="${ messagebm.carkey == '' || messagebm.carkey == null || messagebm.carkey == '�ر�' }">
               <li class="normal"><span>��Կ��</span>�ر�</li>
             </c:when>
             <c:otherwise>
               <li class="on"><span>��Կ��</span>����</li>
             </c:otherwise>
           </c:choose>

           <c:choose>
               <c:when test="${ messagebm.gpsantenna == '' || messagebm.gpsantenna == null || messagebm.gpsantenna != '����' }">
                  <li class="warning"><span>GPS����</span>${ messagebm.gpsantenna }</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>GPS����</span>����</li>
               </c:otherwise>
           </c:choose>

            <c:choose>
               <c:when test="${ messagebm.gpsshell == '' || messagebm.gpsshell == null || messagebm.gpsshell == '��Ǵ�' }">
                  <li class="warning"><span>���</span>��Ǵ�</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>���</span>��Ǳպ�</li>
               </c:otherwise>
            </c:choose>
            
            <!-- �Ƿ��ն˱���:�ο�messagebm.isWarnZDBJ() -->
            <c:choose>
               <c:when test="${ isWarnZDBJ == 1 }">
                  <li class="warning"><span>�ն��豸</span>����</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>�ն��豸</span>����</li>
               </c:otherwise>
            </c:choose>
            
            <c:choose>
               <c:when test="${ fn:substringBefore(messagebm.voltage,'.') < 5 }">
                  <li class="warning"><span>��Դ��ѹ</span>����</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>��Դ��ѹ</span>����</li>
               </c:otherwise>
            </c:choose>
            
            <c:choose>
               <c:when test="${ messagebm.outalarm == 1 }">
                  <li class="warning"><span>Խ��״̬</span>���籨��</li>
               </c:when>
               <c:when test="${ messagebm.outalarm == 2 }">
                  <li class="warning"><span>Խ��״̬</span>��籨��</li>
               </c:when>
               <c:otherwise>
                  <li class="on"><span>Խ��״̬</span>����</li>
               </c:otherwise>
            </c:choose>
            
            <c:choose>
                  <c:when test="${ messagebm.warnys != null && messagebm.warnys == '����' }">
                     <li class="warning"><span>��ˮ</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>��ˮ</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warncd != null && messagebm.warncd == '����' }">
                     <li class="warning"><span>���</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>���</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnry != null && messagebm.warnry == '����' }">
                     <li class="warning"><span>��λ</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>��λ</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnyy != null && messagebm.warnyy == '����' }">
                     <li class="warning"><span>��ѹ</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>��ѹ</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnsw != null && messagebm.warnsw == '����' }">
                     <li class="warning"><span>ˮ��</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>ˮ��</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnyw != null && messagebm.warnyw == '����' }">
                     <li class="warning"><span>����</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>����</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnyl != null && messagebm.warnyl == '����' }">
                     <li class="warning"><span>����</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>����</span>����</li>
                  </c:otherwise>
               </c:choose>
               
               <c:choose>
                  <c:when test="${ messagebm.warnkl != null && messagebm.warnkl == '����' }">
                     <li class="warning"><span>����</span>����</li>
                  </c:when>
                  <c:otherwise>
                     <li class="on"><span>����</span>����</li>
                  </c:otherwise>
               </c:choose>
          </ul>
        </div>

          </fieldset> 
<!--�������� ����-->
<script type="text/javascript">
   $(document).ready(function(){
      $(".positionMap").click(function(){
         window.top.document.getElementById("singleleftframe").contentWindow.openMap();
      });
   });
</script>
  </body>
</html>
