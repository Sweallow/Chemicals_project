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
    <title>��ѧƷ����Σ���Է���Ǽ��������</title>
    <script type="text/javascript">
		var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//ÿҳ��ʾ����
		var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
		var formName = "��ѧƷ����Σ���Է���Ǽ��������";//������
		var order = " order by scShowOrder desc";//�б�����ʽ

		$(document).ready(function() {
			filter = "";
			//��¼�˵�id
		  	var userId = sc.user.scid;
			if(userId){
				//����ֻ��ʾscstatusΪ0�����ݣ���ֻ��ʾ����˵�
			  	filter += "and scstatus = 0  and userId like '%"+userId+"%' ";
			}
			scDlg = $(".scDlg");//�õ��Ի���
			sc.form.dgPagerInit();//��ҳ��ʼ��
			sc.form.dgDataLoad();//�б����ݼ���
			top.sc.indexAutoHeight();
		});
		
		//���ݲ�ѯ������ѯ���ݣ���ʾ�б�
		var findData = function(){
			filter = "";
			var userId = sc.user.scid;
			if(userId){
				//����ֻ��ʾscstatusΪ0�����ݣ���ֻ��ʾ����˵�
			  	filter += "and scstatus = 0  and userId like '%"+userId+"%' ";
			}
			var unit_name= $("#unit_name").val();
			if(unit_name){
				filter += " and scstatus = 0 and unit_name like '%"+unit_name+"%'";
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
		
		//��ղ�ѯ������
		function clearData() {
			$("#unit_name").val("");
			$("#unit_property").val("");
			$("#chemist_name").val("");
			$("#acceptance_no").val("");
		}
		
		//����ԭ����д
		var dlgShow = function(i,scid) {
			var d = dialog({
				lock:true,
			    title: '����ԭ��',
			    content: "<textarea id = 'reason' rows='6' cols='50'></textarea>",
			    okValue: "�ύ",
			    ok: function() {
					var rs = $("#reason").val();
					ServiceBreak(scClassName, "updateReason", [rs, scid],function(data){
						if(data){
							//sc.alert("�����ѳɹ����أ�");
						}else{
							showMsg();
						}
					});
					ServiceBreak(scClassName, "updateScstatus", [i, scid],function(data){
						if(data == "success"){
							var d = dialog({
							    content: "�����ѳɹ����أ�",
							    okValue: "ȷ��",
							    ok: function() {
							    	window.location.href = sc.basePath 
							    		+ "chemical/dangerClassifyReport/checkingDangerClassifyReport.jsp";
							    }
							});
							d.showModal();
						}else{
							showMsg();
						}
					});
					
			    },
			    cancelValue: "ȡ��",
				cancel: function () {} 
			});
			d.showModal();
		};
		
		//���ʧ����ʾ��Ϣ
		function showMsg(){
			var d = dialog({
			    content: "���ʧ�ܣ�",
			    okValue: "ȷ��",
			    ok: function() {
			    	window.location.href = sc.basePath 
			    		+ "chemical/dangerClassifyReport/checkingDangerClassifyReport.jsp";
			    }
			});
			d.showModal();
		}
		
		//״̬�ж�
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
		
		//���
		function secretaryExam(i){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫ���/���ص����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ�����/����һ�����ݡ�");
				return;
			} else {
				if(i == 1){
					ServiceBreak(scClassName, "updateScstatus", [i, row[0].scid], function(data){
						if(data == "success") {
							var d = dialog({
							    content: "��˳ɹ�������д֪ͨ�飡",
							    okValue: "ȷ��",
							    ok: function() {
							    	window.location.href = sc.basePath + "chemical/report/reportD.jsp?appscid=" + row[0].scid;
							    }
							});
							d.showModal();
						} else {
							showMsg();
						}
					});				
				} else if(i == -1) {
					dlgShow(i,row[0].scid);
				}	
			};
		}
		
		//�鿴
		function formSelect(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("��ѡ��Ҫ�鿴�ļ�¼��");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("һ��ֻ�ܲ鿴һ����¼��");
	  			return;
	  		} else {
	  			window.location.href = sc.basePath 
	  			+ "chemical/dangerClassifyReport/showDangerClassifyReportInfo.jsp?scid=" + row[0].scid+"&scstatus="+row[0].scstatus;
	  		};
		};
	</script>
  </head>
  <body>
	<div class="scTitle">��ѧƷ����Σ���Է���Ǽ��������</div>
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
                <th data-options="field:'scstatus',width:80,formatter:checkStatusFormatter">���״̬</th>                        
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="���ͨ��" onclick="secretaryExam(1)" />
	    <input class="scBtn" type="button" value="��˲���" onclick="secretaryExam(-1)" />
	    <input class="scBtn" type="button" value="�鿴" onclick="formSelect()" />  	
	</div>   
  </body>
</html>
