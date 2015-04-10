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
    <title>仲裁结果</title>
	<script type="text/javascript">
		var scClassName = "com.sc.chemical.service.CategoryArbitralResultService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "仲裁结果";//表单名称
		var order = " order by scShowOrder";//列表排序方式
		
		$(document).ready(function() {
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
			top.sc.indexAutoHeight();
		});

		//查询
		var searchClick = function(){
			filter = "";
			var startAbstempelnTime = $("#startAbstempelnTime").val();
			var endAbstempelnTime = $("#endAbstempelnTime").val();
			if(startAbstempelnTime){
				filter += " and abstempelnTime >= '" + startAbstempelnTime + "'";
			}
			if(endAbstempelnTime){
				filter += " and abstempelnTime <= '" + endAbstempelnTime + "'";
			}
			if(startAbstempelnTime && endAbstempelnTime){
				filter += " and abstempelnTime between '" + startAbstempelnTime+"'" + " and " + "'" + endAbstempelnTime + "'";
			}
			if(startAbstempelnTime && endAbstempelnTime && (startAbstempelnTime > endAbstempelnTime)){
				alert("您输入的开始时间必须小于结束时间!");
				return;
			}
			var acceptNumber = $("#acceptNumber").val();
			if(acceptNumber){
				filter += " and acceptNumber like '%" + acceptNumber + "%'";
			}
			sc.form.dgDataLoad();//列表数据加载
		};
		
		//重置
		var resetClick = function(){
			$("#startAbstempelnTime").val("");
			$("#endAbstempelnTime").val("");
			$("#acceptNumber").val("");
			window.location.href = sc.basePath + "chemical/type/typeResultList.jsp";
		};
		
	  	function formEdit(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("请选择要修改的数据。");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("一次只能修改一条数据。");
	  			return;
	  		} else {
	  			window.location.href = sc.basePath + "chemical/type/categoryArbitralResult.jsp?scid=" + row[0].scid;
	  		};
		};
	</script>  
  </head>
  <body>
	<div class="scTitle">化学品物理危险性分类仲裁结果通知书</div>
	<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
    	<tr>
    		<td>通知书签发日期：</td>
    		<td>
	    		<input class="Wdate" onclick="WdatePicker()" type="text" id="startAbstempelnTime" />&nbsp;至&nbsp;
	    		<input class="Wdate" onclick="WdatePicker()" type="text" id="endAbstempelnTime" />
    		</td>
    		<td>&nbsp;&nbsp;&nbsp;通知书编号：</td>
    		<td><input type="text" id="acceptNumber"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="清空" onclick="resetClick()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;" toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<input type="hidden" id="scid" />
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'applicationEnterprise',width:80">申请单位名称</th>
                <th data-options="field:'acceptNumber',width:80">受理通知书编号</th>
                <th data-options="field:'abstempelnTime',width:80">通知书签发日期</th>
                <th data-options="field:'arbitralResult',width:80">仲裁结果</th>
                <th data-options="field:'participant',width:80">参与的委员</th>
                <th data-options="field:'contactPerson',width:80">联系人</th>
                <th data-options="field:'phone',width:80">联系电话</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
    	<input class="scBtn" type="button" value="修改" onclick="formEdit()" />
    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
	</div>
  </body>
</html>
