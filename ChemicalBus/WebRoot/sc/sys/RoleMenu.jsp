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
    <title>角色菜单</title>
    <link rel="stylesheet" type="text/css" href="sc/res/zTree/css/zTreeStyle.css" />
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
//页面加载
$(document).ready(function() {
	//初始化角色树
	initRoleTree();
	//初始化菜单树
	initMenuTree();
	
	top.sc.indexAutoHeight(700);
});
var initRoleTree = function() {
	var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: roleNodeClick
		}
	};
	var zNodes = ServiceBreakSyn("com.sc.role.service.RoleService", "getAllRole4Tree", ["scUser"]);
	$.fn.zTree.init($("#roleTree"), setting, zNodes);
}

//初始化菜单树
var initMenuTree = function() {
	var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		check: {
			enable: true,
			chkStyle: "checkbox",
			chkboxType: { "Y": "p", "N": "s" }
		}
	};
	var zNodes = ServiceBreakSyn("com.sc.sys.service.MenuService", "getAllMenus4Tree", ["scUser"]);
	var menuTree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
	menuTree.expandAll(true);
}
//角色树点击
var roleNodeClick = function(event, treeId, treeNode) {
	var menuids = ServiceBreakSyn("com.sc.role.service.RoleService", "getRoleMenus", [treeNode.id]);
	var treeObj = $.fn.zTree.getZTreeObj("menuTree");
	treeObj.checkAllNodes(false);
	for(var i = 0; i < menuids.length; i++) {
		var node = treeObj.getNodesByParam("id", menuids[i])[0];
		treeObj.checkNode(node, true, true);
	}
}
//保存按钮点击
var saveClick = function() {
	var menuTree = $.fn.zTree.getZTreeObj("menuTree");
	var roleTree = $.fn.zTree.getZTreeObj("roleTree");
	var roles = roleTree.getSelectedNodes();
	if(roles.length == 0) {
		sc.alert("请选择角色节点！");
		return;
	}
	var menus = menuTree.getCheckedNodes(true);
	if(menus.length == 0) {
		sc.alert("请选择角色对应菜单！");
	}
	var menuStr = "";
	for(var i = 0; i < menus.length; i++) {
		menuStr += "," + menus[i].id;
	}

	ServiceBreak("com.sc.role.service.RoleService", "saveRoleMenu", [roles[0].id, menuStr], function() {
		sc.alert("保存成功！");
	});
}
</script>
  </head>
  
  <body>
  	<div class="scTitle">角色权限管理</div>
  	<div><input class="scBtn" type="button" value="保存"  onclick="saveClick()"/></div>
    <div class="scLeft" style="width:20%; height:360px;background-color:rgb(112,175,226);">
    	<div>&gt;&gt;角色</div>
    	<div class="ztree" id="roleTree"></div>
    </div>
    <div class="scRight" style="width:75%; height:360px;background-color:rgb(112,175,226);">
    	<div>&gt;&gt;菜单</div>
    	<div class="ztree" id="menuTree" style="background-color:rgb(112,175,226);"></div>
    </div>
  </body>
</html>
