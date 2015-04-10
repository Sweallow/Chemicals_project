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
    <title>部门管理</title>
    <link rel="stylesheet" type="text/css" href="sc/res/zTree/css/zTreeStyle.css" />
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.core-3.5.min.js"></script>
<style type="text/css">
body {
	overflow: hidden;
}
</style>    
<script type="text/javascript">
var scClassName = "com.sc.sys.service.OrganiseService";
var filter = "";
var scDlg = "";
var pageSize = 10;//每页显示条数
var pageNumber = 1;//起始数据条数据（从1开始）
var formName = "组织机构管理";//表单名称
var order = " order by scShowOrder";//列表排序方式

var pOrg = "";//父菜单

$(document).ready(function() {
	scDlg = $(".scDlg");//得到对话框
	sc.form.dgPagerInit();//分页初始化
	
	filter = " and (porgid is null or porgid = '') ";
	
	sc.form.dgDataLoad();//列表数据加载

	initTree();//树初始化
});
//查询
var searchClick = function(){
	filter = "";
	var scName = $("#scName").val();
	if(scName){
		filter += "and orgname like '%"+scName+"%'";
	}
 	 sc.form.dgDataLoad();//列表数据加载
};
//清空查询框
var clearSearch = function(){
	$("#scName").val("");
};
/**
 * 新增使用的保存方法
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		//保存前
		scDlg.find("#porgid").val(pOrg);
	},function() {
		initTree();
	});
}
/**
 * 删除后
 */
var afterDel = function() {
	initTree();
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
	var zNodes = ServiceBreakSyn(scClassName, "getAllOrganse4Tree", ["scUser"]);
	var treeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
	treeObj.expandAll(true);
}
/**
 * 树节点点击
 */
 var treeNodeClick = function(event, treeId, treeNode) {
	pOrg = treeNode.id;
	filter = " and porgid = '" + treeNode.id + "'";
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
    <div class="scTitle">组织机构管理</div>
    <div class="scLeft ztree" id="orgTree" style="width:15%; height:390px;background-color:rgb(112,175,226);">12123</div>
	<div class="scRight" style="width:80%; height:390px;">
	    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>机构名称：</td>
	    		<td><input type="text" id="scName" /></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="查询"  onclick="searchClick()"/></td>
	    		<td>&nbsp;&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="清空"  onclick="clearSearch()"/></td>
	    	</tr>
	    </table>
	    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
	                <th data-options="field:'orgname',width:80">机构名称</th>
	                <th data-options="field:'others',width:150">备注</th>                         
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="新增" onclick="sc.form.add(addSave)" />
	    	<input class="scBtn" type="button" value="修改" onclick="sc.form.edit(sc.form.dlgSave)" />
	    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del(afterDel)" />
				<input class="scBtn" type="button" value="上移" onclick="sc.dlgDataUp()" />
		    	<input class="scBtn" type="button" value="下移" onclick="sc.dlgDataDown()" />
		</div>
	</div>
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<input type="hidden" class="scSave" id="porgid" />
    	<table>
    		<tr>
    			<td>机构名称：</td>
    			<td><input type="text" class="scSave" id="orgname" /></td>
    		</tr>
    		<tr>
    			<td>备注：</td>
    			<td>
    				<textarea class="scSave" id="others"></textarea>
    			</td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
