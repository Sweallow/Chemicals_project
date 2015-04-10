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
		<title>上年度鉴定化学品</title>
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
			var pageSize = 10;//每页显示条数
			var pageNumber = 1;//起始数据条数据（从1开始）
			var formName = "菜单管理";//表单名称
			var order = " order by scShowOrder";//列表排序方式
			//初始化页面
			$(document).ready(function() {
				scDlg = $(".scDlg");//得到对话框
				sc.form.dgPagerInit();//分页初始化
				sc.form.dgDataLoad();//列表数据加载
			});
			//模板下载
			var downLoad=function(){
				window.location.href=sc.basePath+"recourse/jianDingBaoGao.xls";
			};
			//查询
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
					sc.form.dgDataLoad();//列表数据加载
			};
			var clearSearch = function(){
				$("#sdate").val("");
				$("#company").val("");
			};
			/**
			 * 文件上传
			 */
			var fileUpload = function() {
				// 准备好Options对象
				var options = {
					type: "POST",
					url: "servlet/ExcelImpServlet",
					success: function(data) {
						sc.alert("导入成功");
						sc.form.dgDataLoad();//列表数据加载
					},
					error: function() {
						alert("error");
					}
				};
				// 将options传给ajaxForm
				$('#picUpload').ajaxSubmit(options);
			};
			//用div里面图片的点击事件触发file按钮的点击事件，以此来解决浏览器兼容问题
			function openBrowse(){
				document.getElementById("file").click();
				document.getElementById("filename").value=document.getElementById("file").value;
			};
		</script>
	</head>
	<body>
		<div class="scTitle">上年度鉴定化学品</div>
		<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td id="name"> 鉴定日期：</td> <td><input type="text" id="sdate" name="sdate" onclick="WdatePicker()"></td>
			<td id="name"> &nbsp;&nbsp;&nbsp;&nbsp;鉴定机构：</td> <td><input type="text" id="company" name="company"></td>
			<td>&nbsp;</td>
			<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"> </td>
			<td>&nbsp;&nbsp;</td>
			<td><input class="scBtn" type="button" value="清空"  onclick="clearSearch()"> </td>
		</tr>
		</table>
		<br />
		<div id="toolbar">
			<form id="picUpload" action="servlet/ExcelImpServlet" method="post" enctype="multipart/form-data">
				<div class="scFileUpload" id="filename" onclick="openBrowse()">
					<input type="file" name="file" id="file" class="scFileInput" onchange="fileUpload()"/>
				</div>
			</form>
			<input class="scBtn" type="button" value="模板下载" onclick="downLoad()" />
			<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
		</div>
		<table id="dg" class="scDg easyui-datagrid" style="height:340px;"
				toolbar="#toolbar" pagination="true"
				rownumbers="true" fitColumns="true" singleSelect="false" striped="true" >
				<thead>
					<tr>
						<th data-options="field:'scid',checkbox:true"></th>
						<th data-options="field:'company',width:175" >鉴定机构</th>
						<th data-options="field:'sdate',width:175" >日期</th>
					</tr>
				</thead>
		</table>
	</body>
</html>