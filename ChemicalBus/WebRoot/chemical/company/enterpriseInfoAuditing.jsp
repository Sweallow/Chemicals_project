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
    <title>��ҵ������Ϣ���</title>
    
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
		  	filter += " and scStatus = 0 and userName like '%" + name + "%'";
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
		  	filter += " and scStatus = 0 and userName like '%" + name + "%'";
		} 
		var enterpriseName = $("#enterpriseName").val();
		if(enterpriseName){
			filter += " and enterpriseName like '%" + enterpriseName + "%'";
		}
		var enterpriseAttribute = $("#enterpriseAttribute").val();
		if(enterpriseAttribute){
			filter +=" and enterpriseAttribute like '%" + enterpriseAttribute + "%'";
		}
		  	sc.form.dgDataLoad();//�б����ݼ���
	};
	//����
	var resetClick = function(){
		$("#enterpriseName").val("");
		$("#enterpriseAttribute").val("");
		window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
	};
	
	//����ԭ����д
	var dlgShow = function(i,scid) {
		var d = dialog({
			lock:true,
		    title: '����ԭ��',
		    content: "<textarea id = 'reason' rows='6' cols='50'></textarea>",
		    okValue: "�ύ",
		    ok: function() {
				var rs = $("#reason").val();
				ServiceBreak(scClassName, "updateReason", [rs, scid], function(data){
					if(data){
					}else{
						showMsg();
					}
				});
				ServiceBreak(scClassName, "updateScstatus", [i, scid], function(data){
					if(data == "success"){
						var d = dialog({
						    content: "�����ѳɹ����أ�",
						    okValue: "ȷ��",
						    ok: function() {
						    	window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
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
		    	window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
		    }
		});
		d.showModal();
	}
	
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
			sc.alert("��ѡ��Ҫ��˵����ݡ�");
			return;
		} else if(row.length > 1) {
			sc.alert("һ��ֻ�����һ�����ݡ�");
			return;
		} else {
			if(i == 1){
				ServiceBreak(scClassName, "updateScstatus", [i, row[0].scid], function(data){
					if(data == "success"){
						var d = dialog({
						    content: "��˳ɹ���",
						    okValue: "ȷ��",
						    ok: function() {
						    	window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
						    }
						});
						d.showModal();
					}else{
						showMsg();
					}
				});
			}else if(i == -1){
				dlgShow(i,row[0].scid);
			}
		};
	}
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
                <th data-options="field:'operator',width:75">������</th> 
                <th data-options="field:'phone',width:80">��ϵ�绰</th>
                <th data-options="field:'scStatus',width:80,formatter:checkStatusFormatter">���״̬</th>
                                          
			</tr>
		</thead>
	</table>
		<div id="toolbar">
	    	<input class="scBtn" type="button" value="���ͨ��" onclick="secretaryExam(1)" />
	    	<input class="scBtn" type="button" value="��˲���" onclick="secretaryExam(-1)" />
	    	<input class="scBtn" type="button" value="�鿴" onclick="formSelect()" />
		</div>
	<script type="text/javascript">
	  	function formSelect(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("��ѡ��Ҫ�鿴�ļ�¼��");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("һ��ֻ�ܲ鿴һ����¼��");
	  			return;
	  		} else {
	  			window.location.href = sc.basePath + "chemical/company/companyExamine.jsp?scid=" + row[0].scid;
	  		};
			
		};
	 </script>   
  </body>
</html>
