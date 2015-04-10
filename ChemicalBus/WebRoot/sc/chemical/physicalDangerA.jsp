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
    <title>��ѧƷ����Σ���Է����ٲ�����</title>
	<script type="text/javascript">
		var scClassName = "chemical.service.ChemicalApplicationService";
		var filter = ""; 
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "��ѧƷ����Σ���Է����ٲ������";//������
		var order = " order by scShowOrder";//�б�����ʽ
		
		$(document).ready(function() {
		    var code = sc.user.scid;
			if(code){
		  		filter += "and userCode like '%" + code + "%'";
		  		order = " order by case when (scStatus = 0) then 0 when (scStatus = -1) then 1 else 2 end,scCreatedate desc ";
		  	}
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���	
			top.sc.indexAutoHeight();//���˫����������
		});
	</script>  
	<script type="text/javascript">
		//����
		var add = function() {
			 window.location.href=sc.basePath+"sc/chemical/applicationForm.jsp"; 
		};
	
		//�޸�
		var edit = function() {
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ���޸�һ�����ݡ�");
				return;
			} else {		
			 	window.location.href=sc.basePath+"sc/chemical/applicationForm.jsp?scid="+row[0].scid;
			}
		};

		//��ѯ
		var searchClick = function() {
			filter="";
			var applyUnit= $("#applyUnit").val();
			if(applyUnit){
				filter += "and applyUnit like '%"+applyUnit+"%'";
			}
			var acceptanceDate=$("#acceptanceDate").val();
			if(acceptanceDate){
				filter +="and acceptanceDate like '%"+acceptanceDate+"%'";
			}
			var chineseName=$("#chineseName").val();
			if(chineseName){
				filter +="and chineseName like '%"+chineseName+"%'";
			}
			sc.form.dgDataLoad();//�б����ݼ���
		};
	
		//��ղ�ѯ����
		var clearSearch = function() {
			$("#applyUnit").val("");
		  	$("#acceptanceDate").val("");	
		  	$("#chineseName").val("");
		  	window.location.href=sc.basePath+"sc/chemical/physicalDangerA.jsp";	
		};
	
		//���״̬�ж�
		var checkStatusFormmater = function(val,rec) {
			var res = "";
			if(val == "-1") {
				res = "����";
			} else if (val=="0") {
				res = "�����";
			} else if (val=="1") {
				res = "���ͨ��";
			}
			return res;
		};
	</script>  
  </head>
  <body>
    <div class="scTitle">��ѧƷ����Σ���Է����ٲ������</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>���뵥λ��</td>
    		<td><input type="text" id="applyUnit" /></td>
    		<td>&nbsp;&nbsp;�������ڣ�</td>
    		<td><input type="text" id="acceptanceDate" onclick="WdatePicker()" /></td>
    		<td>&nbsp;&nbsp;��ѧƷ��������</td>
    		<td><input type="text" id="chineseName" /></td>
    		<td>&nbsp;&nbsp;&nbsp;&nbsp;<input class="scBtn" type="button" value="��ѯ"  onclick="searchClick()" /></td>
    		<td>&nbsp;&nbsp;&nbsp;&nbsp;<input class="scBtn" type="button" value="���"  onclick="clearSearch()" /></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>             
                <th data-options="field:'acceptanceCode',width:150">������</th>   
                <th data-options="field:'applyUnit',width:150">���뵥λ</th>
                <th data-options="field:'telNumber',width:180">��ϵ�绰</th>
                <th data-options="field:'chineseName',width:240">��ѧƷ������</th>
                <th data-options="field:'englishName',width:240">��ѧƷӢ����</th>     
                <th data-options="field:'unitName',width:150">��λ����</th>
                <th data-options="field:'chargePeople',width:180">��λ������</th>
                <th data-options="field:'otherMatters',width:175">��������</th>
             	<th data-options="field:'count',width:120">������</th> 
                <th data-options="field:'attachmentName',width:175">��������</th>
                <th data-options="field:'acceptPeople',width:120">������</th>
                <th data-options="field:'acceptanceDate',width:175">��������</th>
                <th data-options="field:'scStatus',width:175,formatter:checkStatusFormmater" >���״̬</th>                 
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="����" onclick="add()" />
    	<input class="scBtn" type="button" value="�޸�" onclick="edit()" />
    	<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()"/>
	</div>
  </body>
</html>
