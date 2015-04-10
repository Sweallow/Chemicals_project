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
    <title>�˵�����</title>
    
    <link rel="stylesheet" type="text/css" href="sc/res/zTree/css/zTreeStyle.css" />
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.core-3.5.min.js"></script>
<style type="text/css">
body {
	overflow: hidden;
}
</style>    
<script type="text/javascript">
var scClassName = "com.sc.sys.service.MenuService";
var filter = "";
var scDlg = "";
var pageSize = 10;//ÿҳ��ʾ����
var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
var formName = "�˵�����";//������
var order = " order by scShowOrder";//�б�����ʽ

var pMenu = "";//���˵�

$(document).ready(function() {
	scDlg = $(".scDlg");//�õ��Ի���
	sc.form.dgPagerInit();//��ҳ��ʼ��
	
	filter = " and (pMenu is null or pMenu = '') ";
	
	sc.form.dgDataLoad();//�б����ݼ���
	
	initTree();
});
/**
 * ����ʹ�õı��淽��
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		//����ǰ
		scDlg.find("#pMenu").val(pMenu);
	},function() {
		initTree();
	});
}
/**
 * ɾ����
 */
var afterDel = function() {
	initTree();
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
	var zNodes = ServiceBreakSyn(scClassName, "getAllMenus4Tree", ["scUser"]);
	$.fn.zTree.init($("#menuTree"), setting, zNodes);
}
/**
 * ���ڵ���
 */
 var treeNodeClick = function(event, treeId, treeNode) {
	pMenu = treeNode.id;
	filter = " and pMenu = '" + treeNode.id + "'";
	pageNumber = 1;
	sc.form.dgDataLoad();//�б����ݼ���
}

//�޸�·���ָ���
var changeFileSplit = function() {
	var val = $("#url").val();
	val = val.replace(/\\/g, "/");
	$("#url").val(val);
}

	var searchClick = function(){
		filter = "";
		var scName = $("#scName").val();
			if(scName){
			  filter += "and menuName like '%"+scName+"%'";
	  
			}
			sc.form.dgDataLoad();//�б����ݼ���
	};
	//��ղ�ѯ��
			var clearSearch = function(){
				$("#scName").val("");
			};
</script>    
  </head>
  
  <body>
    <div class="scTitle">�˵�����</div>
    <div class="scLeft ztree" id="menuTree" style="width:15%; height:390px;background-color:rgb(112,175,226);">12123</div>
  	<div class="scRight" style="width:80%; height:390px;">
	    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>���ƣ�</td>
	    		<td><input type="text" id="scName" /></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()" /></td>
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
	                <th data-options="field:'menuName',width:80">�˵�����</th>
	                <th data-options="field:'url',width:150">���ӵ�ַ</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="����" onclick="sc.form.add(addSave)" />
	    	<input class="scBtn" type="button" value="�޸�" onclick="sc.form.edit(sc.form.dlgSave)" />
	    	<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del(afterDel)" />
			<input class="scBtn" type="button" value="����" onclick="sc.dlgDataUp()" />
	    	<input class="scBtn" type="button" value="����" onclick="sc.dlgDataDown()" />
		</div>
		<div class="scDlg">
	    	<input type="hidden" id="scid" />
	    	<input type="hidden" class="scSave" id="pMenu" />
	    	<table>
	    		<tr>
	    			<td>���ƣ�</td>
	    			<td><input type="text" class="scSave" id="menuName" /></td>
	    		</tr>
	    		<tr>
	    			<td>���ӣ�</td>
	    			<td><input type="text" class="scSave" id="url" onchange="changeFileSplit()" /></td>
	    		</tr>
	    	</table>
	    </div>
	</div>
  </body>
</html>
