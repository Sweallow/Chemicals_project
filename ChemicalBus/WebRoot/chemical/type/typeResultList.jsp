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
    <title>�ٲý��</title>
	<script type="text/javascript">
		var scClassName = "com.sc.chemical.service.CategoryArbitralResultService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "�ٲý��";//������
		var order = " order by scShowOrder";//�б�����ʽ
		
		$(document).ready(function() {
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���
			top.sc.indexAutoHeight();
		});

		//��ѯ
		var searchClick = function(){
			filter = "";
			var startAbstempelnTime = $("#startAbstempelnTime").val();
			var endAbstempelnTime = $("#endAbstempelnTime").val();
			if(startAbstempelnTime){
				filter += " and abstempelnTime >= '" + startAbstempelnTime + "'";
			}
			if(endAbstempelnTime){
				filter += " and abstempelnTime <= '" + endAbstempelnTime + "'";
			}
			if(startAbstempelnTime && endAbstempelnTime){
				filter += " and abstempelnTime between '" + startAbstempelnTime+"'" + " and " + "'" + endAbstempelnTime + "'";
			}
			if(startAbstempelnTime && endAbstempelnTime && (startAbstempelnTime > endAbstempelnTime)){
				alert("������Ŀ�ʼʱ�����С�ڽ���ʱ��!");
				return;
			}
			var acceptNumber = $("#acceptNumber").val();
			if(acceptNumber){
				filter += " and acceptNumber like '%" + acceptNumber + "%'";
			}
			sc.form.dgDataLoad();//�б����ݼ���
		};
		
		//����
		var resetClick = function(){
			$("#startAbstempelnTime").val("");
			$("#endAbstempelnTime").val("");
			$("#acceptNumber").val("");
			window.location.href = sc.basePath + "chemical/type/typeResultList.jsp";
		};
		
	  	function formEdit(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("һ��ֻ���޸�һ�����ݡ�");
	  			return;
	  		} else {
	  			window.location.href = sc.basePath + "chemical/type/categoryArbitralResult.jsp?scid=" + row[0].scid;
	  		};
		};
	</script>  
  </head>
  <body>
	<div class="scTitle">��ѧƷ����Σ���Է����ٲý��֪ͨ��</div>
	<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
    	<tr>
    		<td>֪ͨ��ǩ�����ڣ�</td>
    		<td>
	    		<input class="Wdate" onclick="WdatePicker()" type="text" id="startAbstempelnTime" />&nbsp;��&nbsp;
	    		<input class="Wdate" onclick="WdatePicker()" type="text" id="endAbstempelnTime" />
    		</td>
    		<td>&nbsp;&nbsp;&nbsp;֪ͨ���ţ�</td>
    		<td><input type="text" id="acceptNumber"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="���" onclick="resetClick()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;" toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<input type="hidden" id="scid" />
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'applicationEnterprise',width:80">���뵥λ����</th>
                <th data-options="field:'acceptNumber',width:80">����֪ͨ����</th>
                <th data-options="field:'abstempelnTime',width:80">֪ͨ��ǩ������</th>
                <th data-options="field:'arbitralResult',width:80">�ٲý��</th>
                <th data-options="field:'participant',width:80">�����ίԱ</th>
                <th data-options="field:'contactPerson',width:80">��ϵ��</th>
                <th data-options="field:'phone',width:80">��ϵ�绰</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
    	<input class="scBtn" type="button" value="�޸�" onclick="formEdit()" />
    	<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
	</div>
  </body>
</html>
