<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path =request.getContextPath();
%>
<html>
<head>
<!--jQuery dependencies-->
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/themes/base/jquery-ui.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>    
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
 
    <link rel="stylesheet" href="<%=path %>/plugs/grid/pqgrid.min.css" />
    <script src="<%=path %>/plugs/grid/pqgrid.min.js"></script>
    <link rel="stylesheet" href="<%=path %>/plugs/grid/themes/office/pqgrid.css" />
 
<script>
    //$(function () {
    //    query();
   // });
    $(function () {
        var tbl = $("#nasdaq_market_table");
        var obj = $.paramquery.tableToArray(tbl);

        var newObj = { width: 800, height: 400, numberCell: true, minWidth: 10,
            
             
            freezeCols: 1, resizable: true, columnBorders: true,
            selectionModel: { type: 'cell', mode: 'block' },
            editModel: { clicksToEdit: 2, saveKey: 13 },
            hoverMode: 'cell'
        };
        //make space in every row to save checkbox state .
        for (var i = 0; i < obj.data.length; i++) {
            obj.data[i].push("");
        }

        newObj.dataModel = { data: obj.data, sortIndx: 4, curPage: 1, paging: "local", rPP: 15, rPPOptions: [15, 30, 45] };
        obj.colModel.splice(2, 1);
        newObj.colModel = obj.colModel;        

        $.extend(newObj.colModel[0], { width: 150 });
        $.extend(newObj.colModel[1], { width: 150 });

        $.extend(newObj.colModel[2], {
            render: function (ui) {
                var rowData = ui.rowData; ;
                if (rowData[4] < 0) {
                    return "<img src='/Content/images/arrow-us-down.gif'/>&nbsp;" + rowData[3];
                }
                else {
                    return "<img src='/Content/images/arrow-us-up.gif'/>&nbsp;" + rowData[3];
                }
            }, width: 120
        });
        $.extend(newObj.colModel[3], { width: 80 });
        $.extend(newObj.colModel[4], { width: 80, dataType: "float" });
        $.extend(newObj.colModel[5], { width: 80, dataType: "float" });
        //here we have to set dataIndx explicitly because it's a new column.
         
        newObj.rowSelect = function (evt, ui) {            
            var rowIndx = ui.rowIndx;
            newObj.dataModel.data[rowIndx][7] = true;
            $grid1.pqGrid("refreshCell", { rowIndx: rowIndx, dataIndx: 7 });
        }
        newObj.rowUnSelect = function (evt, ui) {
            var rowIndx = ui.rowIndx,
                data = ui.dataModel.data,
                evt = ui.evt;
            data[rowIndx][7] = false;            
            $grid1.pqGrid("refreshCell", { rowIndx: rowIndx, dataIndx: 7 });
        }
        newObj.cellKeydown = function (evt, ui) {
            var rowIndx = ui.rowIndx, colIndx = ui.colIndx,
                column = ui.column, data = ui.dataModel.data;

            if (column && column.dataIndx == 7) {
                var dataIndx = column.dataIndx,
                    rowIndx = ui.rowIndx;                
                //enter key or space bar.
                if (evt.keyCode == 13 || evt.keyCode == 32) {
                    if (!data[rowIndx][dataIndx]) {
                        //select the row
                        $grid1.pqGrid("selection", { type: 'row', method: 'add', rowIndx: rowIndx });
                    }
                    else {
                        //un select the row
                        $grid1.pqGrid("selection", { type: 'row', method: 'remove', rowIndx: rowIndx });
                    }
                    evt.stopPropagation();
                    evt.preventDefault();
                    return false;
                }
            }
        }
        newObj.cellClick = function (evt, ui) {
            //debugger;
            var rowIndx = ui.rowIndx, colIndx = ui.colIndx,
                column = ui.column, dataModel = ui.dataModel,
                data = dataModel.data;

            if (column && column.dataIndx == 7) {
                var dataIndx = column.dataIndx;

                if (!data[rowIndx][dataIndx]) {
                    $grid1.pqGrid("selection", { type: 'row', method: 'add', rowIndx: rowIndx });
                }
                else {
                    $grid1.pqGrid("selection", { type: 'row', method: 'remove', rowIndx: rowIndx });
                }
                evt.stopPropagation();
                return false;
            }
        }
        var $grid1 = $("#grid_selection_custom").pqGrid(newObj);
    });
    function query(){
        $.ajax({
	        url:'<%=path%>/account/findAll.page',
	        data: "pageSize=5&curentPage=2",
	        dataType:"text",
	        async:false,
	        type:'GET',
	        success:function (data){
	        	alert(data);
	        	var data =[[]];
	        	var obj = { width: 700, height: 400, title: "ParamQuery Grid Example",resizable:true,draggable:true };
		        obj.colModel = [{ title: "AID", width: 100, dataType: "string" },
		        { title: "NAME", width: 200, dataType: "string" },
		        { title: "Parentname", width: 150, dataType: "string", align: "right"}];
		        obj.dataModel = { data: data };
		        $("#grid_array").pqGrid(obj);
	        }
        });
    }
</script>    
</head>
<body>
<table width="610" id="nasdaq_market_table" cellspacing="1" cellpadding="0" style="display:none;">
<tr><th><input type="checkbox"/></th><th>Company Name</th><th>Symbol</th><th>Chart</th><th>Price</th><th>Change</th><th>% Change</th><th>Volume</th></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Sirius Xm Radio Inc. </td><td>SIRI</td><td></td><td align="left">2.70</td><td align="right">+0.01</td><td align="right">+0.37%</td><td align="right">81,250,806</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Intel</td><td>INTC</td><td></td><td align="left">20.26</td><td align="right">+0.07</td><td align="right">+0.35%</td><td align="right">69,433,790</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Microsoft</td><td>MSFT</td><td></td><td align="left">26.74</td><td align="right">+0.22</td><td align="right">+0.83%</td><td align="right">57,179,237</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Research in Motion Limited </td><td>RIMM</td><td></td><td align="left">9.58</td><td align="right">+0.38</td><td align="right">+4.13%</td><td align="right">42,529,737</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Cisco Systems </td><td>CSCO</td><td></td><td align="left">18.31</td><td align="right">+0.32</td><td align="right">+1.78%</td><td align="right">40,616,346</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Yahoo! Inc. </td><td>YHOO</td><td></td><td align="left">18.36</td><td align="right">+0.50</td><td align="right">+2.80%</td><td align="right">32,997,005</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Dell</td><td>DELL</td><td></td><td align="left">9.12</td><td align="right">+0.26</td><td align="right">+2.95%</td><td align="right">29,800,460</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Apple</td><td>AAPL</td><td></td><td align="left">566.06</td><td align="right">+38.38</td><td align="right">+7.27%</td><td align="right">29,398,995</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Oracle </td><td>ORCL</td><td></td><td align="left">30.14</td><td align="right">+0.14</td><td align="right">+0.47%</td><td align="right">22,551,075</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Applied Materials </td><td>AMAT</td><td></td><td align="left">10.35</td><td align="right">+0.20</td><td align="right">+1.97%</td><td align="right">15,542,402</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Brocade Communications Systems </td><td>BRCD</td><td></td><td align="left">5.56</td><td align="right">+0.30</td><td align="right">+5.70%</td><td align="right">14,598,474</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">News </td><td>NWSA</td><td></td><td align="left">23.96</td><td align="right">+0.67</td><td align="right">+2.88%</td><td align="right">14,096,772</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Dynavax Technologies </td><td>DVAX</td><td></td><td align="left">2.64</td><td align="right">+0.20</td><td align="right">+8.20%</td><td align="right">12,758,155</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Qualcomm Incorporated </td><td>QCOM</td><td></td><td align="left">62.12</td><td align="right">+0.19</td><td align="right">+0.31%</td><td align="right">12,169,272</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Activision Blizzard </td><td>ATVI</td><td></td><td align="left">11.23</td><td align="right">+0.18</td><td align="right">+1.62%</td><td align="right">11,940,358</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Huntington Bancshares</td><td>HBAN</td><td></td><td align="left">6.11</td><td align="right">+0.10</td><td align="right">+1.66%</td><td align="right">11,448,001</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Ftb</td><td>FITB</td><td></td><td align="left">14.47</td><td align="right">+0.37</td><td align="right">+2.62%</td><td align="right">11,313,550</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Comcast </td><td>CMCSA</td><td></td><td align="left">36.01</td><td align="right">+0.56</td><td align="right">+1.58%</td><td align="right">10,694,461</td></tr>
<tr class="ts0"><td align="left"><input type="checkbox"/></td><td align="left">Marvell</td><td>MRVL</td><td></td><td align="left">7.70</td><td align="right">+0.30</td><td align="right">+4.06%</td><td align="right">10,262,907</td></tr>
<tr class="ts1"><td align="left"><input type="checkbox"/></td><td align="left">Arena</td><td>ARNA</td><td></td><td align="left">8.98</td><td align="right">+0.48</td><td align="right">+5.65%</td><td align="right">10,182,512</td></tr>
 </table>

<div id="grid_selection_custom" style="margin:100px;"></div>
</body>

</html>
