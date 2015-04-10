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
    <title>化学品物理危险性分类仲裁申请</title>
	<script type="text/javascript">
		var scClassName = "chemical.service.ChemicalApplicationService";
		var filter = ""; 
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "化学品物理危险性分类仲裁申请表";//表单名称
		var order = " order by scShowOrder";//列表排序方式
		
		$(document).ready(function() {
		    var code = sc.user.scid;
			if(code){
		  		filter += "and userCode like '%" + code + "%'";
		  		order = " order by case when (scStatus = 0) then 0 when (scStatus = -1) then 1 else 2 end,scCreatedate desc ";
		  	}
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载	
			top.sc.indexAutoHeight();//解决双滚动条问题
		});
	</script>  
	<script type="text/javascript">
		//新增
		var add = function() {
			 window.location.href=sc.basePath+"sc/chemical/applicationForm.jsp"; 
		};
	
		//修改
		var edit = function() {
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要修改的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能修改一条数据。");
				return;
			} else {		
			 	window.location.href=sc.basePath+"sc/chemical/applicationForm.jsp?scid="+row[0].scid;
			}
		};

		//查询
		var searchClick = function() {
			filter="";
			var applyUnit= $("#applyUnit").val();
			if(applyUnit){
				filter += "and applyUnit like '%"+applyUnit+"%'";
			}
			var acceptanceDate=$("#acceptanceDate").val();
			if(acceptanceDate){
				filter +="and acceptanceDate like '%"+acceptanceDate+"%'";
			}
			var chineseName=$("#chineseName").val();
			if(chineseName){
				filter +="and chineseName like '%"+chineseName+"%'";
			}
			sc.form.dgDataLoad();//列表数据加载
		};
	
		//清空查询条件
		var clearSearch = function() {
			$("#applyUnit").val("");
		  	$("#acceptanceDate").val("");	
		  	$("#chineseName").val("");
		  	window.location.href=sc.basePath+"sc/chemical/physicalDangerA.jsp";	
		};
	
		//审核状态判断
		var checkStatusFormmater = function(val,rec) {
			var res = "";
			if(val == "-1") {
				res = "驳回";
			} else if (val=="0") {
				res = "待审核";
			} else if (val=="1") {
				res = "审核通过";
			}
			return res;
		};
	</script>  
  </head>
  <body>
    <div class="scTitle">化学品物理危险性分类仲裁申请表</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>申请单位：</td>
    		<td><input type="text" id="applyUnit" /></td>
    		<td>&nbsp;&nbsp;受理日期：</td>
    		<td><input type="text" id="acceptanceDate" onclick="WdatePicker()" /></td>
    		<td>&nbsp;&nbsp;化学品中文名：</td>
    		<td><input type="text" id="chineseName" /></td>
    		<td>&nbsp;&nbsp;&nbsp;&nbsp;<input class="scBtn" type="button" value="查询"  onclick="searchClick()" /></td>
    		<td>&nbsp;&nbsp;&nbsp;&nbsp;<input class="scBtn" type="button" value="清空"  onclick="clearSearch()" /></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>             
                <th data-options="field:'acceptanceCode',width:150">受理编号</th>   
                <th data-options="field:'applyUnit',width:150">申请单位</th>
                <th data-options="field:'telNumber',width:180">联系电话</th>
                <th data-options="field:'chineseName',width:240">化学品中文名</th>
                <th data-options="field:'englishName',width:240">化学品英文名</th>     
                <th data-options="field:'unitName',width:150">单位名称</th>
                <th data-options="field:'chargePeople',width:180">单位负责人</th>
                <th data-options="field:'otherMatters',width:175">其他事项</th>
             	<th data-options="field:'count',width:120">附件数</th> 
                <th data-options="field:'attachmentName',width:175">附件名称</th>
                <th data-options="field:'acceptPeople',width:120">受理人</th>
                <th data-options="field:'acceptanceDate',width:175">受理日期</th>
                <th data-options="field:'scStatus',width:175,formatter:checkStatusFormmater" >审核状态</th>                 
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="新增" onclick="add()" />
    	<input class="scBtn" type="button" value="修改" onclick="edit()" />
    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del()"/>
	</div>
  </body>
</html>
