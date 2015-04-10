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
    <title>��ɫ����</title>
    <script type="text/javascript" src="sc/res/zTree/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="sc/res/jquery.form.js" ></script>
    <script type="text/javascript">
		var scClassName = "com.sc.role.service.RoleService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "��ɫ����";//������
		var order = " order by scShowOrder desc";//�б�����ʽ
		//��ʼ��ҳ��
		$(document).ready(function() {
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���
		});
		//��ѯ
		var searchClick = function(){
			filter = "";
			var roleName= $("#roleName").val();
			if(roleName){
				filter += "and roleName like '%"+roleName+"%'";
			}
				sc.form.dgDataLoad();//�б����ݼ���
		};
		//��ղ�ѯ��
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
  <div class="scTitle">��ɫ����</div>
  <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td id="name"> ��ɫ���ƣ�</td> <td><input type="text" id="roleName" name="roleName"></td>
			<td>&nbsp;</td>
			<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"> </td>
			<td>&nbsp;&nbsp;</td>
			<td><input class="scBtn" type="button" value="���"  onclick="clearSearch()"> </td>
		</tr>
		</table>
		<br />
		<div id="toolbar">
			<input class="scBtn" type="button" value="����" onclick="sc.form.add(sc.form.dlgSave)" />
			<input class="scBtn" type="button" value="�޸�" onclick="sc.form.edit(sc.form.dlgSave)" />
			<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
			<input class="scBtn" type="button" value="����" onclick="sc.dlgDataUp()" />
	    	<input class="scBtn" type="button" value="����" onclick="sc.dlgDataDown()" />
		</div>
		<table id="dg" class="scDg easyui-datagrid" style="height:340px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'roleName',width:175" >��ɫ����</th>
						<th data-options="field:'others',width:175" >��ע</th>
					</tr>
				</thead>
		</table>
		<div class="scDlg">
			<input type="hidden" id="scid" />
			<table>
				<tr>
					<td>��ɫ���ƣ�</td>
					<td><input type="text" class="scSave" id="roleName" /></td>
				</tr>
				<tr>
					<td>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע��</td>
					<td><textarea class="scSave" id="others"  ></textarea></td>
				</tr>
			</table>
		</div>
  </body>
</html>