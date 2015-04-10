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
    <title>���Ź���</title>
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
var pageSize = 10;//ÿҳ��ʾ����
var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
var formName = "��֯��������";//������
var order = " order by scShowOrder";//�б�����ʽ

var pOrg = "";//���˵�

$(document).ready(function() {
	scDlg = $(".scDlg");//�õ��Ի���
	sc.form.dgPagerInit();//��ҳ��ʼ��
	
	filter = " and (porgid is null or porgid = '') ";
	
	sc.form.dgDataLoad();//�б����ݼ���

	initTree();//����ʼ��
});
//��ѯ
var searchClick = function(){
	filter = "";
	var scName = $("#scName").val();
	if(scName){
		filter += "and orgname like '%"+scName+"%'";
	}
 	 sc.form.dgDataLoad();//�б����ݼ���
};
//��ղ�ѯ��
var clearSearch = function(){
	$("#scName").val("");
};
/**
 * ����ʹ�õı��淽��
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		//����ǰ
		scDlg.find("#porgid").val(pOrg);
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
	var zNodes = ServiceBreakSyn(scClassName, "getAllOrganse4Tree", ["scUser"]);
	var treeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
	treeObj.expandAll(true);
}
/**
 * ���ڵ���
 */
 var treeNodeClick = function(event, treeId, treeNode) {
	pOrg = treeNode.id;
	filter = " and porgid = '" + treeNode.id + "'";
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
    <div class="scTitle">��֯��������</div>
    <div class="scLeft ztree" id="orgTree" style="width:15%; height:390px;background-color:rgb(112,175,226);">12123</div>
	<div class="scRight" style="width:80%; height:390px;">
	    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>�������ƣ�</td>
	    		<td><input type="text" id="scName" /></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="��ѯ"  onclick="searchClick()"/></td>
	    		<td>&nbsp;&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="���"  onclick="clearSearch()"/></td>
	    	</tr>
	    </table>
	    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
	                <th data-options="field:'orgname',width:80">��������</th>
	                <th data-options="field:'others',width:150">��ע</th>                         
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
	</div>
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<input type="hidden" class="scSave" id="porgid" />
    	<table>
    		<tr>
    			<td>�������ƣ�</td>
    			<td><input type="text" class="scSave" id="orgname" /></td>
    		</tr>
    		<tr>
    			<td>��ע��</td>
    			<td>
    				<textarea class="scSave" id="others"></textarea>
    			</td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
