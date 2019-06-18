<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gps.login.service.AccountServiceImpl"%>
<%@page import="com.gps.login.service.IAccountService"%>
<%@page import="com.gps.login.entity.Account"%>
<%@page import="java.util.List"%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
	</head>
	<body>
		<%
			IAccountService service = new AccountServiceImpl();
			Account params = new Account();
			List<Account> list = service.findAll(params);
		%>
		<table width="610" id="list_table" cellspacing="1" cellpadding="0"
			>
			<tr>
				<th>
					<input type="checkbox" />
				</th>
				<th>
					AID
				</th>
				<th>
					用户名
				</th>
				<th>
					密码
				</th>
				<th>
					父节点名称
				</th>
			</tr>
			<%
			for(Account account :list){
				
			 
			%>
			<tr class="ts0">
				<td align="left">
					<input type="checkbox" value=<%=account.getAid() %> />
				</td>
				<td align="left">
					<%=account.getAid() %>
				</td>
				<td>
					<%=account.getName() %>
				</td>
				<td></td>
				<td align="left">
					<%=account.getParentname() %>
				</td>
			</tr>
			<% } %>
		</table>
	</body>

</html>
