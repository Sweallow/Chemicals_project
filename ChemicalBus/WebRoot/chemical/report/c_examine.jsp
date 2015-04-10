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
    <title>�������֪ͨ��</title>
	<script type="text/javascript">
		var scClassName = "com.sc.report.service.InformationService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "�������֪ͨ��";//������
		var order = " order by scShowOrder";//�б�����ʽ

		$(document).ready(function() {
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���
			top.sc.indexAutoHeight();
		});
		
		//��ת������ҳ��
		function toAdd(){
			window.location.href=sc.basePath+"chemical/report/reportD.jsp";
			window.event.returnValue = false; 
		}

		//ģ����ѯ
		var searchClick = function(){
		  	filter = "";
			var Userd= $("#Userd").val();
			if(Userd){
				filter += "and Userd like '%"+Userd+"%'";
			}
			var Chemical=$("#Chemical").val();
			if(Chemical){
				filter +="and Chemical like '%"+Chemical+"%'";
			}
			var Acceptance_number=$("#Acceptance_number").val();
			if(Acceptance_number){
				filter +="and Acceptance_number like '%"+Acceptance_number+"%'";
			}
			var Contact=$("#Contact").val();
			if(Contact){
				filter +="and Contact like '%"+Contact+"%'";
			}
			sc.form.dgDataLoad();//�б����ݼ���
		};
		
		//��հ�ť
		 var clearSearch = function(){
			  $("#Userd").val("");
			  $("#Chemical").val("");
			  $("#Acceptance_number").val("");
			  $("#Contact").val("");
		};

		//�б�ҳ���޸�
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ���޸�һ�����ݡ�");
				return;
			} else {
				window.location.href = sc.basePath + "chemical/report/reportD.jsp?scid=" + row[0].scid;
				window.event.returnValue = false;
			};
		};

		//ɾ��
		var delData = function(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫɾ�������ݡ�");
				return;
			}
			if(row) {
				var d = dialog({
					lock:true,
				    title: '��ʾ',
				    content: 'ȷ��ɾ��ѡ�����ݣ�',
				    okValue: "ȷ��",
				    ok: function() {
						var ids = "";
						for(var i = 0; i < row.length; i++) {
							ids += "," + row[i].scid;
						}
						ServiceBreakSyn(scClassName, "delFormData", [ids.substring(1)]);
						sc.form.dgDataLoad();//�����б�����
				    },
				    cancelValue: "ȡ��",
					cancel: function () {} 
				});
				d.showModal();
			}
		};

	</script>    
  </head>
  <body>
    <div class="scTitle">�������֪ͨ��</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>��λ����</td>
    		<td><input type="text" size="15"  id="Userd" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>��ѧƷ��</td>
    		<td><input type="text" size="15"  id="Chemical" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>�����ţ�</td>
    		<td><input type="text" size="15"  id="Acceptance_number" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>��ϵ�ˣ�</td>
    		<td><input type="text" size="15"  id="Contact" />&nbsp;</td>
    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()" />&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="���" onclick="clearSearch()" /></td>
    	</tr>
    </table>
    
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;" toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
		 	<tr>
             	<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'Userd',width:10">��λ��</th>
                <th data-options="field:'Chemical',width:10">��ѧƷ</th>
                <th data-options="field:'Acceptance_number',width:10">������</th>
                <th data-options="field:'Contact',width:10">��ϵ��</th>
                <th data-options="field:'Audit1',width:10">�����</th>
                <th data-options="field:'data3',width:10">���ʱ��</th>
			</tr>
		</thead>
	</table>	
	<div id="toolbar">
		<!-- <input class="scBtn" type="button" value="����" onclick="toAdd()" /> -->
		<input class="scBtn" type="button" value="�޸�" onclick="formEdit()" />
    	<input class="scBtn" type="button" value="ɾ��" onclick="delData()" />	
	</div>
  </body>
</html>
