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
    <title>化学品物理危险性鉴定仲裁结果</title>
<script type="text/javascript">
var scClassName = "chemical.service.ResultNoticeService";
var filter = "";
var scDlg = "";
var pageSize = 10;//每页显示条数
var pageNumber = 1;//起始数据条数据（从1开始）
var formName = "化学品物理危险性鉴定仲裁结果表";//表单名称
var order = " order by scShowOrder";//列表排序方式

$(document).ready(function() {
	scDlg = $(".scDlg");//得到对话框
	sc.form.dgPagerInit();//分页初始化
	sc.form.dgDataLoad();//列表数据加载
	top.sc.indexAutoHeight();//解决双滚动条问题
});
</script>   

<script type="text/javascript">	
	/**
	 *新增
	 */
	 var add=function(){
		 window.location.href=sc.basePath+"sc/chemical/resultNotice.jsp"; 
	};
	
	/**
	 *修改
	 */
	var edit=function(){
		var row = $('#dg').datagrid('getSelections');
		if(row.length == 0) {
			sc.alert("请选择要修改的数据。");
			return;
		} else if(row.length > 1) {
			sc.alert("一次只能修改一条数据。");
			return;
		} else {
			var scid=row[0].scid;
			 window.location.href=sc.basePath+"sc/chemical/resultNotice.jsp?scid="+scid;
		}
	};
	
	/**
	 *查询
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
		sc.form.dgDataLoad();//列表数据加载
	};
	
	/**
	 *清空
	 */
	var clearSearch =function(){
	  $("#unitName").val("");
	  $("#chemicalName").val("");	
	};

	</script>   
  </head>
  
  <body>
    <div class="scTitle">化学品物理危险性鉴定仲裁结果通知书</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>单位名称：</td>
    		<td><input type="text" id="unitName" /></td>   		
    		<td>&nbsp;&nbsp;&nbsp;&nbsp;化学品名称：</td>
    		<td><input type="text" id="chemicalName" /></td>
    		<td>&nbsp;</td>
    		<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"/></td>
    		<td>&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="清空"  onclick="clearSearch()" /></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'auditNumber',width:150">审核编号 </th>   
                <th data-options="field:'unitName',width:150">单位名称</th>
                <th data-options="field:'identificationAgency',width:150">鉴定机构</th>
                <th data-options="field:'chemicalName',width:175">化学品名称</th>
                <th data-options="field:'identificationProject',width:150">鉴定项目</th>
                <th data-options="field:'identificationResult',width:150">鉴定结果</th>
                <th data-options="field:'originalAgency',width:200">原鉴定机构名称</th>
                <th data-options="field:'specifiedAgency',width:200">指定鉴定机构名称</th>
                <th data-options="field:'people',width:150">联系人</th>
                <th data-options="field:'telNumber',width:150">联系电话</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<!-- <input class="scBtn" type="button" value="新增" onclick="add()" /> -->
    	<input class="scBtn" type="button" value="修改" onclick="edit()" />
    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
	</div>
	<script>
	
	
	</script>
  </body>
</html>
