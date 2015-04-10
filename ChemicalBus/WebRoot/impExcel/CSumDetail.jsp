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
		<title>化学品管理</title>
		<script type="text/javascript">
			  var scClassName = "com.sc.imp.service.CsumDetailService";
			  var filter = "";
			  var scDlg = "";
			  var pageSize = 10;//每页显示条数
			  var pageNumber = 1;//起始数据条数据（从1开始）
			  var formName = "菜单管理";//表单名称
			  var order = " order by scShowOrder";//列表排序方式
			
			  $(document).ready(function() {
			  	scDlg = $(".scDlg");//得到对话框
			  	sc.form.dgPagerInit();//分页初始化
			  	sc.form.dgDataLoad();//列表数据加载
			  });
			  //查询
			  var searchClick = function() {
				  filter = "";
				  var cname = $("#cname").val();
				  if(cname) {
					  filter += " and cname like '%" + cname + "%'";
				  }
				  var cnameS = $("#cnameS").val();
				  if(cnameS) {
					  filter += " and cnameS like '%" + cnameS + "%'";
				  }
				  var ename = $("#ename").val();
				  if(ename) {
					  filter += " and ename like '%" + ename + "%'";
				  }
				  sc.form.dgDataLoad();//列表数据加载
			  };
			  //清空按钮
			  var clearSearch = function(){
				  $("#cname").val("");
				  $("#cnameS").val("");
				  $("#ename").val("");
			  };
		  </script>
		<style type="text/css">
		.scBtn{
			  color:#444444;
			}
		</style>
	</head>
	<body>
		<div class="scTitle">化学品管理</div>
		<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td id="name"> 中文名：</td> <td><input type="text" id="cname" name="cname"></td>
				<td id="name">&nbsp;&nbsp;&nbsp;&nbsp; 中文别名：</td> <td><input type="text" id="cnameS" name="cnameS"></td>
				<td id="name">&nbsp;&nbsp;&nbsp;&nbsp; 英文名：</td> <td><input type="text" id="ename" name="ename"></td>
				<td>&nbsp;</td>
				<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"> </td>
				<td>&nbsp;&nbsp;</td>
				<td><input class="scBtn" type="button" value="清空" onclick="clearSearch()"> </td>
			</tr>
		</table>
		<br />
		<table id="dg" class="scDg easyui-datagrid" style="height:340px;"
			toolbar="#toolbar" pagination="true" rownumbers="true" 
			fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'scid',checkbox:true"></th>
					<th data-options="field:'cname',width:175" >中文名</th>
					<th data-options="field:'cnameS',width:175" >中文别名</th>
					<th data-options="field:'ename',width:175" >英文名</th>
					<th data-options="field:'scCreatedate',width:175" >创建日期</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="修改" onclick="sc.form.edit(sc.form.dlgSave)" />
			<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
		</div>
		<div class="scDlg">
			<input type="hidden" id="scid" />
			<table>
				<tr>
					<td>中文名：</td>
					<td><input type="text" class="scSave" id="cname" /></td>
				</tr>
				<tr>
					<td>中文别名：</td>
					<td><input type="text" class="scSave" id="cnameS" /></td>
				</tr>
				<tr>
					<td>英文名：</td>
					<td><input type="text" class="scSave" id="ename" /></td>
				</tr>
				<tr>
					<td>创建日期：</td>
					<td><input type="text" class="scSave" id="scCreatedate" onclick="WdatePicker()" disabled="disabled"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>