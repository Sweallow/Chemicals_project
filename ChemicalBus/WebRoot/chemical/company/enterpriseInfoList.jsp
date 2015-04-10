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
    <title>��ҵ��Ϣ����</title>
    
<script type="text/javascript">
	var scClassName = "com.sc.chemical.service.ApplicationEnterpriseInfoService";
	var filter = "";
	var scDlg = "";
	var pageSize = 10;//ÿҳ��ʾ����
	var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
	var formName = "��ҵ������Ϣ";//������
	var order = " order by scShowOrder";//�б�����ʽ
	
	$(document).ready(function() {
	    var name = sc.user.scid;
		if(name){
	  		filter += "and userName like '%" + name + "%'";
	  		order = " order by case when (scStatus = 0) then 0 when (scStatus = -1) then 1 else 2 end,scCreatedate desc ";
	  	}
		scDlg = $(".scDlg");//�õ��Ի���
		sc.form.dgPagerInit();//��ҳ��ʼ��
		
		sc.form.dgDataLoad();//�б����ݼ���
		top.sc.indexAutoHeight();
	});
	//��ѯ
	var searchClick = function(){
		filter = "";
	  	var name = sc.user.scid;
		if(name){
		  	filter += " and userName like '%" + name + "%'";
		} 
		var enterpriseName = $("#enterpriseName").val();
		var enterpriseAttribute = $("#enterpriseAttribute").val();
		if(enterpriseName){
			filter += " and enterpriseName like '%" + enterpriseName + "%'";
		}
		if(enterpriseAttribute){
			filter += " and enterpriseAttribute like '%" + enterpriseAttribute + "%'";
		}
		sc.form.dgDataLoad();//�б����ݼ���
	};
	//����
	var resetClick = function(){
		$("#enterpriseName").val("");
		$("#enterpriseAttribute").val("");
		window.location.href = sc.basePath + "chemical/company/enterpriseInfoList.jsp";
	};
	
	//�����ʾ
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
</script>  
  </head>
  
  <body>
     <div class="scTitle">��ҵ������Ϣ</div>
    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
    	<tr>
    		<td>��λ���ƣ�</td>
    		<td><input type="text" id="enterpriseName" /></td>
    		<td> &nbsp;&nbsp;��λ���ԣ�</td>
    		<td><input type="text" id="enterpriseAttribute"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="���" onclick="resetClick()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'enterpriseName',width:80">��λ����</th>
                <th data-options="field:'enterpriseAttribute',width:80">��λ����</th>
                <th data-options="field:'adress',width:80">��ַ</th>
                <th data-options="field:'email',width:70">�ʱ�</th>
                <th data-options="field:'appraisalNumber',width:70">��������</th>
                <th data-options="field:'operator',width:70">������</th> 
                <th data-options="field:'phone',width:80">��ϵ�绰</th>
                <th data-options="field:'scStatus',width:80,formatter:checkStatusFormatter">���״̬</th>
                                          
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="����" onclick="formAdd()" />
    	<input class="scBtn" type="button" value="�޸�" onclick="formEdit()" />
    	<input class="scBtn" type="button" value="ɾ��" onclick="delData()" />
    	
	</div>
	<script type="text/javascript">
		//����
	  	function formAdd(){
			window.location.href = sc.basePath + "chemical/company/companyD.jsp";
		};
		//�޸�
	  	function formEdit(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("һ��ֻ���޸�һ�����ݡ�");
	  			return;
	  		}else {
	  			window.location.href = sc.basePath + "chemical/company/companyD.jsp?scid=" + row[0].scid;
	  		};
		};
		//ɾ��
		function delData(){
			//debugger;
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
  </body>
</html>
