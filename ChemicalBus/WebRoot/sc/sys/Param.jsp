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
    <title>�����ֵ����</title>
<script type="text/javascript">
var scClassName = "com.sc.sys.service.ParamService";
var filter = "";
var scDlg = "";
var pageSize = 10;//ÿҳ��ʾ����
var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
var formName = "�����ֵ����";//������
var order = " order by scShowOrder";//�б�����ʽ

$(document).ready(function() {
	scDlg = $(".scDlg");//�õ��Ի���
	sc.form.dgPagerInit();//��ҳ��ʼ��
	sc.form.dgDataLoad();//�б����ݼ���
	//sc.alert(1);
});
</script>    
  </head>
  
  <body>
    <div class="scTitle">�����ֵ����</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>���ƣ�</td>
    		<td><input type="text" id="scName" /></td>
    		<td><input class="scBtn" type="button" value="��ѯ" /></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:400px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'paramName',width:80">��������</th>
                <th data-options="field:'paramCode',width:150">����ֵ</th>
                <th data-options="field:'paramTypeId',width:150">�������</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="����" onclick="sc.form.add(sc.form.dlgSave)" />
    	<input class="scBtn" type="button" value="�޸�" onclick="sc.form.edit(sc.form.dlgSave)" />
    	<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
    	<input class="scBtn" type="button" value="����" onclick="dataUp()" />
    	<input class="scBtn" type="button" value="����" onclick="dataDown()" />
	</div>
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<table>
    		<tr>
    			<td>�������ƣ�</td>
    			<td><input type="text" class="scSave" id="paramName" /></td>
    		</tr>
    		<tr>
    			<td>����ֵ��</td>
    			<td><input type="text" class="scSave" id="paramCode" /></td>
    		</tr>
    		<tr>
    			<td>�������</td>
    			<td><input type="text" class="scSave" id="paramTypeId" /></td>
    		</tr>
    	</table>
    </div>
  </body>
</html>
