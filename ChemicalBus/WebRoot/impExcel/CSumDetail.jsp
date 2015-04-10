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
		<title>��ѧƷ����</title>
		<script type="text/javascript">
			  var scClassName = "com.sc.imp.service.CsumDetailService";
			  var filter = "";
			  var scDlg = "";
			  var pageSize = 10;//ÿҳ��ʾ����
			  var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
			  var formName = "�˵�����";//������
			  var order = " order by scShowOrder";//�б�����ʽ
			
			  $(document).ready(function() {
			  	scDlg = $(".scDlg");//�õ��Ի���
			  	sc.form.dgPagerInit();//��ҳ��ʼ��
			  	sc.form.dgDataLoad();//�б����ݼ���
			  });
			  //��ѯ
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
				  sc.form.dgDataLoad();//�б����ݼ���
			  };
			  //��հ�ť
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
		<div class="scTitle">��ѧƷ����</div>
		<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td id="name"> ��������</td> <td><input type="text" id="cname" name="cname"></td>
				<td id="name">&nbsp;&nbsp;&nbsp;&nbsp; ���ı�����</td> <td><input type="text" id="cnameS" name="cnameS"></td>
				<td id="name">&nbsp;&nbsp;&nbsp;&nbsp; Ӣ������</td> <td><input type="text" id="ename" name="ename"></td>
				<td>&nbsp;</td>
				<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"> </td>
				<td>&nbsp;&nbsp;</td>
				<td><input class="scBtn" type="button" value="���" onclick="clearSearch()"> </td>
			</tr>
		</table>
		<br />
		<table id="dg" class="scDg easyui-datagrid" style="height:340px;"
			toolbar="#toolbar" pagination="true" rownumbers="true" 
			fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'scid',checkbox:true"></th>
					<th data-options="field:'cname',width:175" >������</th>
					<th data-options="field:'cnameS',width:175" >���ı���</th>
					<th data-options="field:'ename',width:175" >Ӣ����</th>
					<th data-options="field:'scCreatedate',width:175" >��������</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="�޸�" onclick="sc.form.edit(sc.form.dlgSave)" />
			<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
		</div>
		<div class="scDlg">
			<input type="hidden" id="scid" />
			<table>
				<tr>
					<td>��������</td>
					<td><input type="text" class="scSave" id="cname" /></td>
				</tr>
				<tr>
					<td>���ı�����</td>
					<td><input type="text" class="scSave" id="cnameS" /></td>
				</tr>
				<tr>
					<td>Ӣ������</td>
					<td><input type="text" class="scSave" id="ename" /></td>
				</tr>
				<tr>
					<td>�������ڣ�</td>
					<td><input type="text" class="scSave" id="scCreatedate" onclick="WdatePicker()" disabled="disabled"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>