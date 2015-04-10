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
    <title>化学品物理危险性分类审核归档</title>
    <script type="text/javascript">
		var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "化学品物理危险性分类审核归档";//表单名称
		var order = " order by scShowOrder desc";//列表排序方式
		
		$(document).ready(function() {
			//加载页面过滤条件
			filter = "";
		  	var userId = sc.user.scid;
			if(userId){
				//scstatus = 1 为审核通过的
		  		filter += "and scstatus = 1 and userId like '%"+userId+"%' ";
		  	}
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
			top.sc.indexAutoHeight();
		});
	</script>
	<script type="text/javascript">
	 	//模糊查询
		var findData = function(){
		  	filter = "";
		  	var userId = sc.user.scid;
			if(userId){
		  		filter += "and scstatus = 1 and userId like '%"+userId+"%' ";
		  	}
			var unit_name= $("#unit_name").val();
			if(unit_name){
				filter += " and scstatus = 1 and unit_name like '%"+unit_name+"%'";
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
		
		//清空查询框
		function clearData(){
			$("#unit_name").val("");
			$("#unit_property").val("");
			$("#chemist_name").val("");
			$("#acceptance_no").val("");
		}
		
		//选择数据进查看页面
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要查看的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能查看一条数据。");
				return;
			} else {
				window.location.href = sc.basePath 
					+ "chemical/dangerClassifyReport/showDangerClassifyReportInfo.jsp?scid=" + row[0].scid+"&scstatus="+row[0].scstatus;
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
		
		//审核通知按钮
		var showRst = function(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择一条数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能选择一条数据。");
				return;
			} else {
				var appScid=row[0].scid;
			 	if(appScid) {
					ServiceBreak(scClassName, "isNotice", [appScid], function(data){
						if(data){
							window.location.href=sc.basePath+"chemical/report/reportD.jsp?scid="+data+"&rs=sh";
						}else{
							var d = dialog({
							    content: "您还未填写通知书，请填写通知书！",
							    okValue: "确定",
							    ok: function() {
							    	//window.location.href = sc.basePath + "chemical/report/reportD.jsp?appScid="+appScid+"&rs=sh";
							    	window.location.href = sc.basePath + "chemical/report/reportD.jsp?appscid="+ row[0].scid+"&rs=sh";
							    }
							});
							d.showModal();
						}
					});
				}
			}
		};
	</script> 
  </head>
  <body>
	<div class="scTitle">化学品物理危险性分类审核归档</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>单位名称：</td>
    		<td><input type="text" id="unit_name"  size="15"  name="unit_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>单位属性：</td>
    		<td><input type="text"  id="unit_property"  size="15"  name ="unit_property"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>化学品名称：</td>
    		<td><input type="text"  id="chemist_name"  size="15"  name ="chemist_name"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>受理编号：</td>
    		<td><input type="text"  id="acceptance_no"  size="15"  name ="acceptance_no"/>&nbsp;</td>
    		<td><input class="scBtn" type="button" value="查询"  onclick = "findData()"/>&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="清空"  onclick = "clearData()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"toolbar="#toolbar" pagination="true"
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
                <th data-options="field:'scstatus',width:75,formatter:checkStatusFormatter">审核状态</th>                     
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="审核通知" onclick="showRst()" />
    	<input class="scBtn" type="button" value="查看" onclick="formEdit()" />
	</div> 
  </body>
</html>
