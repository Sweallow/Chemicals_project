<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <%@ include file="/sc/common.jsp"%>
    <title>数据字典管理</title>
<script type="text/javascript">
var scClassName = "com.sc.sys.service.ParamService";
var filter = "";
var scDlg = "";
var pageSize = 10;//每页显示条数
var pageNumber = 1;//起始数据条数据（从1开始）
var formName = "数据字典管理";//表单名称
var order = " order by scShowOrder";//列表排序方式

$(document).ready(function() {
	scDlg = $(".scDlg");//得到对话框
	sc.form.dgPagerInit();//分页初始化
	sc.form.dgDataLoad();//列表数据加载
	//sc.alert(1);
});
</script>    
  </head>
  
  <body>
    <div class="scTitle">数据字典管理</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>名称：</td>
    		<td><input type="text" id="scName" /></td>
    		<td><input class="scBtn" type="button" value="查询" /></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:400px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'paramName',width:80">参数名称</th>
                <th data-options="field:'paramCode',width:150">参数值</th>
                <th data-options="field:'paramTypeId',width:150">参数类别</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="新增" onclick="sc.form.add(sc.form.dlgSave)" />
    	<input class="scBtn" type="button" value="修改" onclick="sc.form.edit(sc.form.dlgSave)" />
    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
    	<input class="scBtn" type="button" value="上移" onclick="dataUp()" />
    	<input class="scBtn" type="button" value="下移" onclick="dataDown()" />
	</div>
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<table>
    		<tr>
    			<td>参数名称：</td>
    			<td><input type="text" class="scSave" id="paramName" /></td>
    		</tr>
    		<tr>
    			<td>参数值：</td>
    			<td><input type="text" class="scSave" id="paramCode" /></td>
    		</tr>
    		<tr>
    			<td>参数类别：</td>
    			<td><input type="text" class="scSave" id="paramTypeId" /></td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
