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
    <title>��ѧƷ����Σ���Է�����˹鵵</title>
    <script type="text/javascript">
		var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "��ѧƷ����Σ���Է�����˹鵵";//������
		var order = " order by scShowOrder desc";//�б�����ʽ
		
		$(document).ready(function() {
			//����ҳ���������
			filter = "";
		  	var userId = sc.user.scid;
			if(userId){
				//scstatus = 1 Ϊ���ͨ����
		  		filter += "and scstatus = 1 and userId like '%"+userId+"%' ";
		  	}
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���
			top.sc.indexAutoHeight();
		});
	</script>
	<script type="text/javascript">
	 	//ģ����ѯ
		var findData = function(){
		  	filter = "";
		  	var userId = sc.user.scid;
			if(userId){
		  		filter += "and scstatus = 1 and userId like '%"+userId+"%' ";
		  	}
			var unit_name= $("#unit_name").val();
			if(unit_name){
				filter += " and scstatus = 1 and unit_name like '%"+unit_name+"%'";
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
		
		//��ղ�ѯ��
		function clearData(){
			$("#unit_name").val("");
			$("#unit_property").val("");
			$("#chemist_name").val("");
			$("#acceptance_no").val("");
		}
		
		//ѡ�����ݽ��鿴ҳ��
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫ�鿴�����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ�ܲ鿴һ�����ݡ�");
				return;
			} else {
				window.location.href = sc.basePath 
					+ "chemical/dangerClassifyReport/showDangerClassifyReportInfo.jsp?scid=" + row[0].scid+"&scstatus="+row[0].scstatus;
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
		
		//���֪ͨ��ť
		var showRst = function(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��һ�����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ��ѡ��һ�����ݡ�");
				return;
			} else {
				var appScid=row[0].scid;
			 	if(appScid) {
					ServiceBreak(scClassName, "isNotice", [appScid], function(data){
						if(data){
							window.location.href=sc.basePath+"chemical/report/reportD.jsp?scid="+data+"&rs=sh";
						}else{
							var d = dialog({
							    content: "����δ��д֪ͨ�飬����д֪ͨ�飡",
							    okValue: "ȷ��",
							    ok: function() {
							    	//window.location.href = sc.basePath + "chemical/report/reportD.jsp?appScid="+appScid+"&rs=sh";
							    	window.location.href = sc.basePath + "chemical/report/reportD.jsp?appscid="+ row[0].scid+"&rs=sh";
							    }
							});
							d.showModal();
						}
					});
				}
			}
		};
	</script> 
  </head>
  <body>
	<div class="scTitle">��ѧƷ����Σ���Է�����˹鵵</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>��λ���ƣ�</td>
    		<td><input type="text" id="unit_name"  size="15"  name="unit_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>��λ���ԣ�</td>
    		<td><input type="text"  id="unit_property"  size="15"  name ="unit_property"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>��ѧƷ���ƣ�</td>
    		<td><input type="text"  id="chemist_name"  size="15"  name ="chemist_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>�����ţ�</td>
    		<td><input type="text"  id="acceptance_no"  size="15"  name ="acceptance_no"/>&nbsp;</td>
    		<td><input class="scBtn" type="button" value="��ѯ"  onclick = "findData()"/>&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="���"  onclick = "clearData()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"toolbar="#toolbar" pagination="true"
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
                <th data-options="field:'scstatus',width:75,formatter:checkStatusFormatter">���״̬</th>                     
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="���֪ͨ" onclick="showRst()" />
    	<input class="scBtn" type="button" value="�鿴" onclick="formEdit()" />
	</div> 
  </body>
</html>
