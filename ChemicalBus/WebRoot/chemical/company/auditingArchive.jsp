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
    <title>��ҵ������˹鵵</title>
    
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
	  	filter += "and scStatus = 1  and userName like '%"+name+"%'";
	}
	scDlg = $(".scDlg");//�õ��Ի���
	sc.form.dgPagerInit();//��ҳ��ʼ��
	sc.form.dgDataLoad();//�б����ݼ���
	top.sc.indexAutoHeight();
	//sc.alert(1);
});
//��ѯ
var searchClick = function(){
    filter = "";
  	var name = sc.user.scid;
	if(name){
	  	filter += "and scStatus = 1  and userName like '%" + name + "%'";
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
	window.location.href = sc.basePath + "chemical/company/auditingArchive.jsp";
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
    		<td>&nbsp;&nbsp;��λ���ԣ�</td>
    		<td><input type="text" id="enterpriseAttribute"/></td>
    		<td>&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"/></td>
    		<td>&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="���" onclick="resetClick()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'enterpriseName',width:75">��λ����</th>
                <th data-options="field:'enterpriseAttribute',width:75">��λ����</th>
                <th data-options="field:'adress',width:75">��ַ</th>
                <th data-options="field:'email',width:75">�ʱ�</th>
                <th data-options="field:'appraisalNumber',width:75">��������</th>
                <th data-options="field:'operator',width:75">������</th> 
                <th data-options="field:'phone',width:75">��ϵ�绰</th>
                <th data-options="field:'scStatus',width:75,formatter:checkStatusFormatter">���״̬</th>
                                          
			</tr>
		</thead>
	</table>
		<div id="toolbar">
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
