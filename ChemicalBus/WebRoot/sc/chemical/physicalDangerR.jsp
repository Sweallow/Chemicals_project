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
    <title>��ѧƷ����Σ���Լ����ٲý��</title>
<script type="text/javascript">
var scClassName = "chemical.service.ResultNoticeService";
var filter = "";
var scDlg = "";
var pageSize = 10;//ÿҳ��ʾ����
var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
var formName = "��ѧƷ����Σ���Լ����ٲý����";//������
var order = " order by scShowOrder";//�б�����ʽ

$(document).ready(function() {
	scDlg = $(".scDlg");//�õ��Ի���
	sc.form.dgPagerInit();//��ҳ��ʼ��
	sc.form.dgDataLoad();//�б����ݼ���
	top.sc.indexAutoHeight();//���˫����������
});
</script>   

<script type="text/javascript">	
	/**
	 *����
	 */
	 var add=function(){
		 window.location.href=sc.basePath+"sc/chemical/resultNotice.jsp"; 
	};
	
	/**
	 *�޸�
	 */
	var edit=function(){
		var row = $('#dg').datagrid('getSelections');
		if(row.length == 0) {
			sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
			return;
		} else if(row.length > 1) {
			sc.alert("һ��ֻ���޸�һ�����ݡ�");
			return;
		} else {
			var scid=row[0].scid;
			 window.location.href=sc.basePath+"sc/chemical/resultNotice.jsp?scid="+scid;
		}
	};
	
	/**
	 *��ѯ
	 */
	var searchClick = function(){
	  	filter = "";
		var unitName= $("#unitName").val();
		if(unitName){
			filter += "and unitName like '%"+unitName+"%'";
		}
		var chemicalName=$("#chemicalName").val();
		if(chemicalName){
			filter +="and chemicalName like '%"+chemicalName+"%'";
		}
		sc.form.dgDataLoad();//�б����ݼ���
	};
	
	/**
	 *���
	 */
	var clearSearch =function(){
	  $("#unitName").val("");
	  $("#chemicalName").val("");	
	};

	</script>   
  </head>
  
  <body>
    <div class="scTitle">��ѧƷ����Σ���Լ����ٲý��֪ͨ��</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>��λ���ƣ�</td>
    		<td><input type="text" id="unitName" /></td>   		
    		<td>&nbsp;&nbsp;&nbsp;&nbsp;��ѧƷ���ƣ�</td>
    		<td><input type="text" id="chemicalName" /></td>
    		<td>&nbsp;</td>
    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"/></td>
    		<td>&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="���"  onclick="clearSearch()" /></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'auditNumber',width:150">��˱�� </th>   
                <th data-options="field:'unitName',width:150">��λ����</th>
                <th data-options="field:'identificationAgency',width:150">��������</th>
                <th data-options="field:'chemicalName',width:175">��ѧƷ����</th>
                <th data-options="field:'identificationProject',width:150">������Ŀ</th>
                <th data-options="field:'identificationResult',width:150">�������</th>
                <th data-options="field:'originalAgency',width:200">ԭ������������</th>
                <th data-options="field:'specifiedAgency',width:200">ָ��������������</th>
                <th data-options="field:'people',width:150">��ϵ��</th>
                <th data-options="field:'telNumber',width:150">��ϵ�绰</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<!-- <input class="scBtn" type="button" value="����" onclick="add()" /> -->
    	<input class="scBtn" type="button" value="�޸�" onclick="edit()" />
    	<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
	</div>
	<script>
	
	
	</script>
  </body>
</html>
