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
    <title>�û�����</title>
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
var pageSize = 10;//ÿҳ��ʾ����
var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
var formName = "�û�����";//������
var order = " order by scShowOrder";//�б�����ʽ

var orgid = "";

$(document).ready(function() {
	scDlg = $(".scDlg");//�õ��Ի���
	sc.form.dgPagerInit();//��ҳ��ʼ��
	sc.form.dgDataLoad();//�б����ݼ���
	
	initTree();
	
	loadRoleCxb();
});
var searchClick = function(){
	filter = "";
	var scName = $("#scName").val();
	if(scName) {
		filter += "and username like '%" + scName + "%'";
	}
 	 sc.form.dgDataLoad();//�б����ݼ���
};
//��ղ�ѯ��
var clearSearch = function(){
	$("#scName").val("");
};
//��ɫ��Ϣ������
var loadRoleCxb = function() {
	var pager = ServiceBreakSyn("com.sc.role.service.RoleService", "getTableData", 
			["0", "100", "", "order by scShowOrder"]);
	if(pager != null && pager != 'null') {
		var cxbStr = "<option>��ѡ��</option>";
		for(var i = 0; i < pager.rows.length; i++) {
			cxbStr += "<option value='" + pager.rows[i].scid + "'>" 
					+ pager.rows[i].roleName + "</option>"
		}
		$("#roleid").html(cxbStr);
	}
}
/**
 * ����ʹ�õı��淽��
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		//����ǰ
		scDlg.find("#orgid").val(orgid);
	},function() {
		//initTree();
	});
}
/**
 * ��ʼ����
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
 * ���ڵ���
 */
 var treeNodeClick = function(event, treeId, treeNode) {
	orgid = treeNode.id;
	filter = " and orgid = '" + treeNode.id + "'";
	pageNumber = 1;
	sc.form.dgDataLoad();//�б����ݼ���
}
</script> 
<style type="text/css">
.scSave{
		width:170px;
}
</style>   
  </head>
  
  <body>
    <div class="scTitle">�û�����</div>
    <div class="scLeft ztree" id="orgTree" style="width:15%; height:390px;background-color:rgb(112,175,226);">12123</div>
	<div class="scRight" style="width:80%; height:390px;">
	    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>���ƣ�</td>
	    		<td><input type="text" id="scName" /></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="��ѯ"  onclick="searchClick()" /></td>
	    	    <td>&nbsp;&nbsp;</td>
	    	    <td><input class="scBtn" type="button" value="���"  onclick="clearSearch()" /></td>
	    	</tr>
	    </table>
	    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
	                <th data-options="field:'username',width:80">�û���</th>
	                <th data-options="field:'usercode',width:150">�˺�</th>                       
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="����" onclick="sc.form.add(addSave)" />
	    	<input class="scBtn" type="button" value="�޸�" onclick="sc.form.edit(sc.form.dlgSave)" />
	    	<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
				<input class="scBtn" type="button" value="����" onclick="sc.dlgDataUp()" />
		    	<input class="scBtn" type="button" value="����" onclick="sc.dlgDataDown()" />
		</div>
    </div>
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<input type="hidden" class="scSave" id="orgid" />
    	<table>
    		<tr>
    			<td>�û�����</td>
    			<td><input type="text" class="scSave" id="username" /></td>
    		</tr>
    		<tr>
    			<td>�˺ţ�</td>
    			<td><input type="text" class="scSave" id="usercode" /></td>
    		</tr>
    		<tr>
    			<td>��ɫ��</td>
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
