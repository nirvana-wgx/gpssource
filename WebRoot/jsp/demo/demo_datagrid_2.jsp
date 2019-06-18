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
    $(function () {
       query();
    });
    function query(){
        $.ajax({
	        url:'<%=path%>/account/findAll.page',
	        data: "pageSize=5&curentPage=2",
	        dataType:"html",
	        async:false,
	        type:'GET',
	        success:function (resp){
	        alert(resp);
	               $("#listPage").html(resp);
	        	    var tbl = $.find("#list_table");
	        
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
        var $grid1 = $("#grid_array").pqGrid(newObj);
	        	 
	        }
        });
    }
</script>    
</head>
<body>
<div id="listPage"  style="display:none"></div>
<div id="grid_array" style="margin:100px;"></div>
</body>

</html>
