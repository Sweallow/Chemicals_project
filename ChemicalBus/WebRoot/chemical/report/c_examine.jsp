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
    <title>分类审核通知书</title>
	<script type="text/javascript">
		var scClassName = "com.sc.report.service.InformationService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "分类审核通知书";//表单名称
		var order = " order by scShowOrder";//列表排序方式

		$(document).ready(function() {
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
			top.sc.indexAutoHeight();
		});
		
		//跳转到新增页面
		function toAdd(){
			window.location.href=sc.basePath+"chemical/report/reportD.jsp";
			window.event.returnValue = false; 
		}

		//模糊查询
		var searchClick = function(){
		  	filter = "";
			var Userd= $("#Userd").val();
			if(Userd){
				filter += "and Userd like '%"+Userd+"%'";
			}
			var Chemical=$("#Chemical").val();
			if(Chemical){
				filter +="and Chemical like '%"+Chemical+"%'";
			}
			var Acceptance_number=$("#Acceptance_number").val();
			if(Acceptance_number){
				filter +="and Acceptance_number like '%"+Acceptance_number+"%'";
			}
			var Contact=$("#Contact").val();
			if(Contact){
				filter +="and Contact like '%"+Contact+"%'";
			}
			sc.form.dgDataLoad();//列表数据加载
		};
		
		//清空按钮
		 var clearSearch = function(){
			  $("#Userd").val("");
			  $("#Chemical").val("");
			  $("#Acceptance_number").val("");
			  $("#Contact").val("");
		};

		//列表页面修改
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要修改的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能修改一条数据。");
				return;
			} else {
				window.location.href = sc.basePath + "chemical/report/reportD.jsp?scid=" + row[0].scid;
				window.event.returnValue = false;
			};
		};

		//删除
		var delData = function(){
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
						ServiceBreakSyn(scClassName, "delFormData", [ids.substring(1)]);
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
    <div class="scTitle">分类审核通知书</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>单位名：</td>
    		<td><input type="text" size="15"  id="Userd" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>化学品：</td>
    		<td><input type="text" size="15"  id="Chemical" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>受理编号：</td>
    		<td><input type="text" size="15"  id="Acceptance_number" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
    		<td>联系人：</td>
    		<td><input type="text" size="15"  id="Contact" />&nbsp;</td>
    		<td><input class="scBtn" type="button" value="查询" onclick="searchClick()" />&nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="清空" onclick="clearSearch()" /></td>
    	</tr>
    </table>
    
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;" toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
		 	<tr>
             	<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'Userd',width:10">单位名</th>
                <th data-options="field:'Chemical',width:10">化学品</th>
                <th data-options="field:'Acceptance_number',width:10">受理编号</th>
                <th data-options="field:'Contact',width:10">联系人</th>
                <th data-options="field:'Audit1',width:10">审核人</th>
                <th data-options="field:'data3',width:10">审核时间</th>
			</tr>
		</thead>
	</table>	
	<div id="toolbar">
		<!-- <input class="scBtn" type="button" value="新增" onclick="toAdd()" /> -->
		<input class="scBtn" type="button" value="修改" onclick="formEdit()" />
    	<input class="scBtn" type="button" value="删除" onclick="delData()" />	
	</div>
  </body>
</html>
