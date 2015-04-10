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
		<title>����ȼ�����ѧƷ</title>
		<script type="text/javascript" src="sc/res/jquery.form.js" ></script>
		<style type="text/css">
			.scFileUpload:hover {
				background:url(sc/img/btnImpS.gif) center no-repeat;
			}
			.scFileUpload:active {
				background:url(sc/img/btnImpS.gif) center no-repeat;
			}
			#picUpload {
				display: inline;
				width:50px;
				line-height:24px;
				height:24px;
				padding:4px 0px;
			}
			.scFileUpload {
				width:50px;
				line-height:24px;
				height:24px;
				background:url(sc/img/btnImp.gif) center no-repeat;
				display: inline;
				padding:4px 0px;
			}
			.scFileInput {
				width:60px; height:24px;
				cursor: pointer;
				font-size: 3px;
				outline: medium none;
				filter:alpha(opacity=0);
				-moz-opacity:0;
				opacity:0;
				cursor: pointer;
				outline: medium none;
				filter:alpha(opacity=0);
				visibility: hidden;
			}
			.scBtn{
				color:#444444;
			}
		</style>
		<script type="text/javascript">
			var scClassName = "com.sc.imp.service.ImpExcelService";
			var filter = "";
			var scDlg = "";
			var pageSize = 10;//ÿҳ��ʾ����
			var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
			var formName = "�˵�����";//������
			var order = " order by scShowOrder";//�б�����ʽ
			//��ʼ��ҳ��
			$(document).ready(function() {
				scDlg = $(".scDlg");//�õ��Ի���
				sc.form.dgPagerInit();//��ҳ��ʼ��
				sc.form.dgDataLoad();//�б����ݼ���
			});
			//ģ������
			var downLoad=function(){
				window.location.href=sc.basePath+"recourse/jianDingBaoGao.xls";
			};
			//��ѯ
			var searchClick = function(){
				filter = "";
				var sdate= $("#sdate").val();
				if(sdate){
					filter += "and sdate like '%"+sdate+"%'";
				}
					var company=$("#company").val();
				if(company){
					filter +="and company like '%"+company+"%'";
				}
					sc.form.dgDataLoad();//�б����ݼ���
			};
			var clearSearch = function(){
				$("#sdate").val("");
				$("#company").val("");
			};
			/**
			 * �ļ��ϴ�
			 */
			var fileUpload = function() {
				// ׼����Options����
				var options = {
					type: "POST",
					url: "servlet/ExcelImpServlet",
					success: function(data) {
						sc.alert("����ɹ�");
						sc.form.dgDataLoad();//�б����ݼ���
					},
					error: function() {
						alert("error");
					}
				};
				// ��options����ajaxForm
				$('#picUpload').ajaxSubmit(options);
			};
			//��div����ͼƬ�ĵ���¼�����file��ť�ĵ���¼����Դ�������������������
			function openBrowse(){
				document.getElementById("file").click();
				document.getElementById("filename").value=document.getElementById("file").value;
			};
		</script>
	</head>
	<body>
		<div class="scTitle">����ȼ�����ѧƷ</div>
		<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td id="name"> �������ڣ�</td> <td><input type="text" id="sdate" name="sdate" onclick="WdatePicker()"></td>
			<td id="name"> &nbsp;&nbsp;&nbsp;&nbsp;����������</td> <td><input type="text" id="company" name="company"></td>
			<td>&nbsp;</td>
			<td><input class="scBtn" type="button" value="��ѯ" onclick="searchClick()"> </td>
			<td>&nbsp;&nbsp;</td>
			<td><input class="scBtn" type="button" value="���"  onclick="clearSearch()"> </td>
		</tr>
		</table>
		<br />
		<div id="toolbar">
			<form id="picUpload" action="servlet/ExcelImpServlet" method="post" enctype="multipart/form-data">
				<div class="scFileUpload" id="filename" onclick="openBrowse()">
					<input type="file" name="file" id="file" class="scFileInput" onchange="fileUpload()"/>
				</div>
			</form>
			<input class="scBtn" type="button" value="ģ������" onclick="downLoad()" />
			<input class="scBtn" type="button" value="ɾ��" onclick="sc.form.del()" />
		</div>
		<table id="dg" class="scDg easyui-datagrid" style="height:340px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true" >
				<thead>
					<tr>
						<th data-options="field:'scid',checkbox:true"></th>
						<th data-options="field:'company',width:175" >��������</th>
						<th data-options="field:'sdate',width:175" >����</th>
					</tr>
				</thead>
		</table>
	</body>
</html>