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
    <title>化学品物理危险性分类报告填报</title>
    <script type="text/javascript">
		var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "化学品物理危险性分类报告填报";//表单名称
		var order = " order by scShowOrder";//列表排序方式
		
		$(document).ready(function() {
			top.sc.indexAutoHeight();
			var userId = sc.user.scid;
			if(userId){
		  		filter += "and userId like '%" + userId + "%'";
		  		order = " order by case when (scstatus = '0') then 0 when (scstatus = '-1') then 1 else 2 end ,scCreatedate desc";
		  	}
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
		});
		
		//模糊查询
		var findData = function(){
			filter = "";
			var userId = sc.user.scid;
			if(userId){
		  		filter += "and userId like '%" + userId + "%'";
		  	}
			var unit_name= $("#unit_name").val();
			if(unit_name){
				filter += "and unit_name like '%"+unit_name+"%'";
			}
			var unit_property=$("#unit_property").val();
			if(unit_property){
				filter +="and unit_property like '%"+unit_property+"%'";
			}
			var chemist_name= $("#chemist_name").val();
			if(chemist_name){
				filter += "and chemist_name like '%"+chemist_name+"%'";
			}
			var acceptance_no=$("#acceptance_no").val();
			if(acceptance_no){
				filter +="and acceptance_no like '%"+acceptance_no+"%'";
			}
			sc.form.dgDataLoad();//列表数据加载
		};
		
		//清空查询条件
		function clearData(){
			$("#unit_name").val("");
			$("#unit_property").val("");
			$("#chemist_name").val("");
			$("#acceptance_no").val("");
		}
		
		//进新增页面
	  	function formAdd(){
			window.location.href= sc.basePath + "chemical/dangerClassifyReport/addDangerClassifyReport.jsp";
		};
		
		//进修改页面
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要修改的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能修改一条数据。");
				return;
			} else {
				window.location.href = sc.basePath 
					+ "chemical/dangerClassifyReport/addDangerClassifyReport.jsp?scid=" + row[0].scid;
			};
		};
		
		//审核状态判断
		var checkStatusFormatter = function(val,rec){
			var res = "";
			if(val == "-1"){
				res = "驳回";
			}else if(val == "0"){
				res = "待审核";
			}else if (val == "1"){
				res = "审核通过";
			}
			return res;
		};
		
		//删除填报信息
		var dataDels = function(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要删除的数据。");
				return;
			}
			if(row) {
				var d = dialog({
					lock:true,
				    title: '提示',
				    content: '确认删除选中数据？',
				    okValue: "确定",
				    ok: function() {
						var ids = "";
						for(var i = 0; i < row.length; i++) {
							ids += "," + row[i].scid;
						}
						ServiceBreakSyn(scClassName, "delFormDatas", [ids.substring(1)]);
						sc.form.dgDataLoad();//加载列表数据
				    },
				    cancelValue: "取消",
					cancel: function () {} 
				});
				d.showModal();
			}
		};
	</script> 
  </head>
  <body>
	<div class="scTitle">化学品物理危险性分类报告填报</div>
	<table class="scSearcher" cellspace="0" cellpadding="0" border="0">
	  	<tr>
	  		<td >单位名称：</td>
	  		<td><input type="text" id="unit_name"  size="15"  name="unit_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	  		<td>单位属性：</td>
	  		<td><input type="text"  id="unit_property"  size="15"  name ="unit_property"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	  		<td>化学品名称：</td>
	  		<td><input type="text"  id="chemist_name"  size="15"   name ="chemist_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	  		<td>受理编号：</td>
	  		<td><input type="text"  id="acceptance_no"  size="15"  name ="acceptance_no"/>&nbsp;</td>
	  		<td><input class="scBtn" type="button" value="查询"  onclick = "findData()"/>&nbsp;&nbsp;</td>
	  		<td><input class="scBtn" type="button" value="清空"  onclick = "clearData()"/></td>
	  	</tr>
  	</table>
  	<table id="dg" class="scDg easyui-datagrid" style="height:350px;" toolbar="#toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
		        <th data-options="field:'chemist_name',width:80">化学品名称</th>
		        <th data-options="field:'unit_name',width:80">单位名称</th>
		        <th data-options="field:'unit_property',width:80">单位属性</th>
		        <th data-options="field:'executePeople',width:80">经办人</th>
		        <th data-options="field:'email',width:80">电子邮箱</th>
		        <th data-options="field:'phone',width:80">联系电话</th>
		        <th data-options="field:'scstatus',width:80, formatter:checkStatusFormatter">审核状态</th>                       
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="新增" onclick="formAdd()" />
	   	<input class="scBtn" type="button" value="修改" onclick="formEdit()" />
	   	<input class="scBtn" type="button" value="删除" onclick="dataDels()" />
	</div>
  </body>
</html>
