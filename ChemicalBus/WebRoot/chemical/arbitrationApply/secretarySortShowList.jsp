<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML >
<html>
  <head>
    <base href="<%=basePath%>">
    <%@ include file="/sc/common.jsp"%>
    <title>��ѧƷ����Σ���Լ����ٲ�����</title>
	  <script type="text/javascript">
	  var scClassName = "com.sc.arbitrationApply.service.ArbirtationApplyService";
	  var filter = "";
	  var scDlg = "";
	  var pageSize = 10;//ÿҳ��ʾ����
	  var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
	  var formName = "��ҵ�";//������
	  var order = " order by scShowOrder";//�б�����ʽ
	
	  $(document).ready(function() {
		filter = "";
		var name = sc.user.scid;
		if(name){
			filter += "and scstatus like '1' and userName like '%"+name+"%'";
		}
		scDlg = $(".scDlg");//�õ��Ի���
		sc.form.dgPagerInit();//��ҳ��ʼ��
		sc.form.dgDataLoad();//�б����ݼ���
		top.sc.indexAutoHeight();
	  });
	  </script>
	  <script type="text/javascript">
		
		/**
		 *��ѯ
		 */
		var searchClick = function(){
		  filter = "";
		  	var name = sc.user.scid;
	  		if(name){
		  		filter += "and scstatus like '1' and userName like '%"+name+"%'";
		  	}
			var applyCom= $("#applyCom").val();
			if(applyCom){
				filter += "and applyCom like '%"+applyCom+"%'";
			}
			var executePeople=$("#executePeople").val();
			if(executePeople){
				filter +="and executePeople like '%"+executePeople+"%'";
			}
			var chnName = $("#chnName").val();
			if(chnName){
				filter += "and chnName like '%" + chnName + "%'";
			}
		  	sc.form.dgDataLoad();//�б����ݼ���
		}
		
		/**
		 *���
		 */
		var cleanClick = function(){
			$("#applyCom").val("");
			$("#executePeople").val("");
			$("#chnName").val("");
		}
		
		/**
		 *�鿴
		 */
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
				return;
			} else if(row.length > 1) {
				sc.alert("һ��ֻ���޸�һ�����ݡ�");
				return;
			} else {
				window.location.href = sc.basePath + "chemical/arbitrationApply/secretaryExamDetail.jsp?scid=" + row[0].scid+"&scstatus="+row[0].scstatus;
			};
		};
		
		/**
		 *���״̬��ʾ
		 */
		var checkStatusFormatter = function(val, rec){
			var res = "";
			if(val == "-1"){
				res = "����";
			}else if(val == "0"){
				res = "�����";
			}else if(val == "1"){
				res = "���ͨ��";
			}
			return res;
		}
		
		/**
		 *֪ͨ����ʾ
		 */
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
								window.location.href=sc.basePath+"sc/chemical/resultNotice.jsp?scid="+data+"&rs=sh";
							}else{
								var d = dialog({
								    content: "����δ��д֪ͨ�飬����д֪ͨ�飡",
								    okValue: "ȷ��",
								    ok: function() {
								    	window.location.href = sc.basePath + "sc/chemical/resultNotice.jsp?appScid="+appScid+"&rs=sh";
								    }
								});
								d.showModal();
							}
						});
					}
				}
		}
	</script>  
  </head>

   <body>
    <div class="scTitle">��ѧƷ����Σ���Լ����ٲ���˹鵵</div>
    	<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>��ѧƷ��������</td>
	    		<td><input type="text" size="12" id="chnName" name="chnName"/></td>
	    		<td>&nbsp;&nbsp;&nbsp;&nbsp;���뵥λ��</td>
	    		<td><input type="text" size="12" id="applyCom" name="applyCom" /></td>
	    		<td>&nbsp;&nbsp;&nbsp;&nbsp;�����ˣ�</td>
	    		<td><input type="text" size="12" id="executePeople" name="executePeople"/></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"/></td>
	    		<td>&nbsp;&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="���" onclick="cleanClick()"/></td>
	    	</tr>
	    </table>
	    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'chnName',width:40">��ѧƷ������</th>
	                <th data-options="field:'applyCom',width:50">���뵥λ</th>
	                <th data-options="field:'executePeople',width:25">������</th>
	                <th data-options="field:'mobilePhone',width:40">�ƶ��绰</th>
	                <th data-options="field:'email',width:50">��������</th>
	                <th data-options="field:'fax',width:40">����</th>
	                <th data-options="field:'createtabledate',width:40">�������</th>
	                <th data-options="field:'responsible_person',width:25">��λ������</th>
	                <th data-options="field:'acceptance_pepple',width:25">������</th>
	                <th data-options="field:'scstatus',width:25,formatter:checkStatusFormatter">���״̬</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
	    	<input class="scBtn" type="button" value="���֪ͨ" onclick="showRst()" />
	    	<input class="scBtn" type="button" value="�鿴" onclick="formEdit()" />
		</div>
  </body>
</html>
