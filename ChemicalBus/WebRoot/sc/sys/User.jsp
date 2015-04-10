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
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="sc/res/zTree/css/zTreeStyle.css" />
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.core-3.5.min.js"></script>
<style type="text/css">
body {
	overflow: hidden;
}
</style>
<script type="text/javascript">
var scClassName = "com.sc.sys.service.UserService";
var filter = "";
var scDlg = "";
var pageSize = 10;//每页显示条数
var pageNumber = 1;//起始数据条数据（从1开始）
var formName = "用户管理";//表单名称
var order = " order by scShowOrder";//列表排序方式

var orgid = "";

$(document).ready(function() {
	scDlg = $(".scDlg");//得到对话框
	sc.form.dgPagerInit();//分页初始化
	sc.form.dgDataLoad();//列表数据加载
	
	initTree();
	
	loadRoleCxb();
});
var searchClick = function(){
	filter = "";
	var scName = $("#scName").val();
	if(scName) {
		filter += "and username like '%" + scName + "%'";
	}
 	 sc.form.dgDataLoad();//列表数据加载
};
//清空查询框
var clearSearch = function(){
	$("#scName").val("");
};
//角色信息下拉框
var loadRoleCxb = function() {
	var pager = ServiceBreakSyn("com.sc.role.service.RoleService", "getTableData", 
			["0", "100", "", "order by scShowOrder"]);
	if(pager != null && pager != 'null') {
		var cxbStr = "<option>请选择</option>";
		for(var i = 0; i < pager.rows.length; i++) {
			cxbStr += "<option value='" + pager.rows[i].scid + "'>" 
					+ pager.rows[i].roleName + "</option>"
		}
		$("#roleid").html(cxbStr);
	}
}
/**
 * 新增使用的保存方法
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		//保存前
		scDlg.find("#orgid").val(orgid);
	},function() {
		//initTree();
	});
}
/**
 * 初始化树
 */
var initTree = function() {
	var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: treeNodeClick
		}
	};
	var zNodes = ServiceBreakSyn("com.sc.sys.service.OrganiseService", "getAllOrganse4Tree", ["scUser"]);
	var treeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
	treeObj.expandAll(true);
}
/**
 * 树节点点击
 */
 var treeNodeClick = function(event, treeId, treeNode) {
	orgid = treeNode.id;
	filter = " and orgid = '" + treeNode.id + "'";
	pageNumber = 1;
	sc.form.dgDataLoad();//列表数据加载
}
</script> 
<style type="text/css">
.scSave{
		width:170px;
}
</style>   
  </head>
  
  <body>
    <div class="scTitle">用户管理</div>
    <div class="scLeft ztree" id="orgTree" style="width:15%; height:390px;background-color:rgb(112,175,226);">12123</div>
	<div class="scRight" style="width:80%; height:390px;">
	    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>名称：</td>
	    		<td><input type="text" id="scName" /></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="查询"  onclick="searchClick()" /></td>
	    	    <td>&nbsp;&nbsp;</td>
	    	    <td><input class="scBtn" type="button" value="清空"  onclick="clearSearch()" /></td>
	    	</tr>
	    </table>
	    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
	                <th data-options="field:'username',width:80">用户名</th>
	                <th data-options="field:'usercode',width:150">账号</th>                       
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="新增" onclick="sc.form.add(addSave)" />
	    	<input class="scBtn" type="button" value="修改" onclick="sc.form.edit(sc.form.dlgSave)" />
	    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
				<input class="scBtn" type="button" value="上移" onclick="sc.dlgDataUp()" />
		    	<input class="scBtn" type="button" value="下移" onclick="sc.dlgDataDown()" />
		</div>
    </div>
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<input type="hidden" class="scSave" id="orgid" />
    	<table>
    		<tr>
    			<td>用户名：</td>
    			<td><input type="text" class="scSave" id="username" /></td>
    		</tr>
    		<tr>
    			<td>账号：</td>
    			<td><input type="text" class="scSave" id="usercode" /></td>
    		</tr>
    		<tr>
    			<td>角色：</td>
    			<td>
				<select class="scSave" id="roleid" >
					<option></option>
				</select>
				</td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
