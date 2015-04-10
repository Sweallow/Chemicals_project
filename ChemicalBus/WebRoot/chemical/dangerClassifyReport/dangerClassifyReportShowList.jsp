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
    <title>��ѧƷ����Σ���Է��౨���</title>
    <script type="text/javascript">
		var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "��ѧƷ����Σ���Է��౨���";//������
		var order = " order by scShowOrder";//�б�����ʽ
		
		$(document).ready(function() {
			top.sc.indexAutoHeight();
			var userId = sc.user.scid;
			if(userId){
		  		filter += "and userId like '%" + userId + "%'";
		  		order = " order by case when (scstatus = '0') then 0 when (scstatus = '-1') then 1 else 2 end ,scCreatedate desc";
		  	}
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���
		});
		
		//ģ����ѯ
		var findData = function(){
			filter = "";
			var userId = sc.user.scid;
			if(userId){
		  		filter += "and userId like '%" + userId + "%'";
		  	}
			var unit_name= $("#unit_name").val();
			if(unit_name){
				filter += "and unit_name like '%"+unit_name+"%'";
			}
			var unit_property=$("#unit_property").val();
			if(unit_property){
				filter +="and unit_property like '%"+unit_property+"%'";
			}
			var chemist_name= $("#chemist_name").val();
			if(chemist_name){
				filter += "and chemist_name like '%"+chemist_name+"%'";
			}
			var acceptance_no=$("#acceptance_no").val();
			if(acceptance_no){
				filter +="and acceptance_no like '%"+acceptance_no+"%'";
			}
			sc.form.dgDataLoad();//�б����ݼ���
		};
		
		//��ղ�ѯ����
		function clearData(){
			$("#unit_name").val("");
			$("#unit_property").val("");
			$("#chemist_name").val("");
			$("#acceptance_no").val("");
		}
		
		//������ҳ��
	  	function formAdd(){
			window.location.href= sc.basePath + "chemical/dangerClassifyReport/addDangerClassifyReport.jsp";
		};
		
		//���޸�ҳ��
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ���޸�һ�����ݡ�");
				return;
			} else {
				window.location.href = sc.basePath 
					+ "chemical/dangerClassifyReport/addDangerClassifyReport.jsp?scid=" + row[0].scid;
			};
		};
		
		//���״̬�ж�
		var checkStatusFormatter = function(val,rec){
			var res = "";
			if(val == "-1"){
				res = "����";
			}else if(val == "0"){
				res = "�����";
			}else if (val == "1"){
				res = "���ͨ��";
			}
			return res;
		};
		
		//ɾ�����Ϣ
		var dataDels = function(){
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
						ServiceBreakSyn(scClassName, "delFormDatas", [ids.substring(1)]);
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
	<div class="scTitle">��ѧƷ����Σ���Է��౨���</div>
	<table class="scSearcher" cellspace="0" cellpadding="0" border="0">
	  	<tr>
	  		<td >��λ���ƣ�</td>
	  		<td><input type="text" id="unit_name"  size="15"  name="unit_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	  		<td>��λ���ԣ�</td>
	  		<td><input type="text"  id="unit_property"  size="15"  name ="unit_property"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	  		<td>��ѧƷ���ƣ�</td>
	  		<td><input type="text"  id="chemist_name"  size="15"   name ="chemist_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	  		<td>�����ţ�</td>
	  		<td><input type="text"  id="acceptance_no"  size="15"  name ="acceptance_no"/>&nbsp;</td>
	  		<td><input class="scBtn" type="button" value="��ѯ"  onclick = "findData()"/>&nbsp;&nbsp;</td>
	  		<td><input class="scBtn" type="button" value="���"  onclick = "clearData()"/></td>
	  	</tr>
  	</table>
  	<table id="dg" class="scDg easyui-datagrid" style="height:350px;" toolbar="#toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
		        <th data-options="field:'chemist_name',width:80">��ѧƷ����</th>
		        <th data-options="field:'unit_name',width:80">��λ����</th>
		        <th data-options="field:'unit_property',width:80">��λ����</th>
		        <th data-options="field:'executePeople',width:80">������</th>
		        <th data-options="field:'email',width:80">��������</th>
		        <th data-options="field:'phone',width:80">��ϵ�绰</th>
		        <th data-options="field:'scstatus',width:80, formatter:checkStatusFormatter">���״̬</th>                       
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="����" onclick="formAdd()" />
	   	<input class="scBtn" type="button" value="�޸�" onclick="formEdit()" />
	   	<input class="scBtn" type="button" value="ɾ��" onclick="dataDels()" />
	</div>
  </body>
</html>
