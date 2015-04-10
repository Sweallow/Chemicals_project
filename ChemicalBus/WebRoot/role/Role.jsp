<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <%@ include file="/sc/common.jsp"%>
    <title>角色管理</title>
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="sc/res/jquery.form.js" ></script>
    <script type="text/javascript">
		var scClassName = "com.sc.role.service.RoleService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "角色管理";//表单名称
		var order = " order by scShowOrder desc";//列表排序方式
		//初始化页面
		$(document).ready(function() {
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
		});
		//查询
		var searchClick = function(){
			filter = "";
			var roleName= $("#roleName").val();
			if(roleName){
				filter += "and roleName like '%"+roleName+"%'";
			}
				sc.form.dgDataLoad();//列表数据加载
		};
		//清空查询框
		var clearSearch = function(){
			$("#roleName").val("");
		};
	</script>
	<style type="text/css">
		.scSave{
		  	width:150px;
		}
	</style>
  </head>
  <body>
  <div class="scTitle">角色管理</div>
  <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td id="name"> 角色名称：</td> <td><input type="text" id="roleName" name="roleName"></td>
			<td>&nbsp;</td>
			<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"> </td>
			<td>&nbsp;&nbsp;</td>
			<td><input class="scBtn" type="button" value="清空"  onclick="clearSearch()"> </td>
		</tr>
		</table>
		<br />
		<div id="toolbar">
			<input class="scBtn" type="button" value="新增" onclick="sc.form.add(sc.form.dlgSave)" />
			<input class="scBtn" type="button" value="修改" onclick="sc.form.edit(sc.form.dlgSave)" />
			<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
			<input class="scBtn" type="button" value="上移" onclick="sc.dlgDataUp()" />
	    	<input class="scBtn" type="button" value="下移" onclick="sc.dlgDataDown()" />
		</div>
		<table id="dg" class="scDg easyui-datagrid" style="height:340px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'roleName',width:175" >角色名称</th>
						<th data-options="field:'others',width:175" >备注</th>
					</tr>
				</thead>
		</table>
		<div class="scDlg">
			<input type="hidden" id="scid" />
			<table>
				<tr>
					<td>角色名称：</td>
					<td><input type="text" class="scSave" id="roleName" /></td>
				</tr>
				<tr>
					<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
					<td><textarea class="scSave" id="others"  ></textarea></td>
				</tr>
			</table>
		</div>
  </body>
</html>