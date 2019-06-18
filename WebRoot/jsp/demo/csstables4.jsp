<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>CSS Tables</title>
		<link href="<%=path%>/css/table.css" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jPaginate.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=path%>/css/toolbars.css" rel="stylesheet"
			type="text/css" />
		 
	</head>

	<body><form action="">
				<table id="mytable" cellspacing="0"
			summary="The technical specifications of the Apple PowerMac G5 series">
			<tr>
				<th scope="col" abbr="Configurations">
					条件1
				</th>

				<th scope="col" abbr="Dual 1.8">
					<input type="text"/>
				</th>
				<th scope="col" abbr="Dual 2">
					Dual 2GHz
				</th>
				<th scope="col" abbr="Dual 2.5">
					<input type="text"/>
				</th>
				<th scope="col" abbr="Dual 2.5">
					<a href="javascript:void(0)" onclick="" id="btn_add"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_search">查询</span>
			</span>
			</a>
			<a href="javascript:void(0)" onclick="" id="btn_add"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_clear">重置</span>
			</span>
			</a>
				</th>
			</tr>
			 
		</table>
		 </form>
 
		<div class="toolbar">
		<ul><li>
			<!-- 工具条 按钮 -->
			<a href="javascript:void(0)" onclick="" id="btn_add"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_add">新增</span>
			</span>
			</a>
			<a href="javascript:void(0)" onclick="" id="btn_modify"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_edit">修改</span>
			</span>
			</a>
			<a href="javascript:void(0)" onclick="" id="btn_remove"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_remove">删除</span>
			</span>
			</a>
			<a href="javascript:void(0)" onclick="" id="btn_export"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_export">导出</span>
			</span>
			</a>
			<a href="javascript:void(0)" onclick="" id="btn_export"><span
				class="toolbar_btn"><span
					class="toolbar_btn_ico toolbar_btn_export">送审</span>
			</span>
			</a>
		 </li></ul>
		</div>

		<table id="mytable" cellspacing="0"
			summary="The technical specifications of the Apple PowerMac G5 series">

			<tr>
				<th scope="col" abbr="Configurations">
					Configurations
				</th>

				<th scope="col" abbr="Dual 1.8">
					Dual 1.8GHz
				</th>
				<th scope="col" abbr="Dual 2">
					Dual 2GHz
				</th>
				<th scope="col" abbr="Dual 2.5">
					Dual 2.5GHz
				</th>
			</tr>
			<tr>
				<th scope="row" abbr="Model" class="spec">
					Model
				</th>
				<td>
					M9454LL/A
				</td>

				<td>
					M9455LL/A
				</td>
				<td>
					M9457LL/A
				</td>
			</tr>
			<tr>
				<th scope="row" abbr="G5 Processor" class="specalt">
					G5 Processor
				</th>
				<td class="alt">
					Dual 1.8GHz PowerPC G5
				</td>
				<td class="alt">
					Dual 2GHz PowerPC G5
				</td>

				<td class="alt">
					Dual 2.5GHz PowerPC G5
				</td>
			</tr>
			<tr>
				<th scope="row" abbr="Frontside bus" class="spec">
					Frontside bus
				</th>
				<td>
					900MHz per processor
				</td>
				<td>
					1GHz per processor
				</td>
				<td>
					1.25GHz per processor
				</td>

			</tr>
			<tr>
				<th scope="row" abbr="L2 Cache" class="specalt">
					Level2 Cache
				</th>
				<td class="alt">
					512K per processor
				</td>
				<td class="alt">
					512K per processor
				</td>
				<td class="alt">
					512K per processor
				</td>
			</tr>

		</table>
		<div id="pagelist">
			<ul>
				<li>
					<a href="#">首页</a>
				</li>
				<li>
					<a href="#">上页</a>
				</li>
				<li class="pageinfo">
					第
					<input type="text" value="1" />
					页/22页
				</li>

				<li>
					<a href="#">下页</a>
				</li>
				<li>
					<a href="#">末页</a>
				</li>
				<li class="pageinfo">
					每页
					<input type="text" value="15" />
					条
				</li>
				<li>
					<a href="#">GO</a>
				</li>

			</ul>
		</div>
 
	</body>
</html>
