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
    <title>化学品物理危险性鉴定仲裁申请</title>
	  <script type="text/javascript">
	  var scClassName = "com.sc.arbitrationApply.service.ArbirtationApplyService";
	  var filter = "";
	  var scDlg = "";
	  var pageSize = 10;//每页显示条数
	  var pageNumber = 1;//起始数据条数据（从1开始）
	  var formName = "企业填报";//表单名称
	  var order = " order by scShowOrder";//列表排序方式
	
	  $(document).ready(function() {
	  	filter = "";
	  	var name = sc.user.scid;
  		if(name){
	  		filter += "and userName like '%"+name+"%'";
	  		order = "order by case when (scstatus = '0') then 0 when (scstatus = '-1') then 1 else 2 end,createtabledate desc";
	  	}
		sc.form.dgDataLoad();//列表数据加载
		scDlg = $(".scDlg");//得到对话框
		sc.form.dgPagerInit();//分页初始化
	  	top.sc.indexAutoHeight();
	  });
	  </script>
	  <script type="text/javascript">

		/**
		 *新增
		 */
		function add(){
    		window.location.href=sc.basePath+"chemical/arbitrationApply/addArbitrationApply.jsp";
    	}
		
		/**
		 *查询
		 */
		var searchClick = function(){
			filter = "";
		  	var name = sc.user.scid;
		  	if(name){
		  		filter += "and userName like '%"+name+"%'";
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
		  	sc.form.dgDataLoad();//列表数据加载
		}
		
		/**
		 *清除
		 */
		var cleanClick = function(){
			$("#applyCom").val("");
			$("#executePeople").val("");
			$("#chnName").val("");
		}
		
		/**
		 *修改
		 */
		function formEdit(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要修改的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能修改一条数据。");
				return;
			} else {
				window.location.href = sc.basePath + "chemical/arbitrationApply/addArbitrationApply.jsp?scid=" + row[0].scid;
			};
		};
		
		/**
		 *审核状态显示
		 */
		var checkStatusFormatter = function(val, rec){
			var res = "";
			if(val == "-1"){
				res = "驳回";
			}else if(val == "0"){
				res = "待审核";
			}else if(val == "1"){
				res = "审核通过";
			}
			return res;
		}
		
	</script>  
  </head>

   <body>
    <div class="scTitle">化学品物理危险性鉴定仲裁申请管理</div>
    	<table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
	    	<tr>
	    		<td>化学品中文名：</td>
	    		<td><input type="text" size="12" id="chnName" name="chnName"/></td>
	    		<td>&nbsp;&nbsp;&nbsp;&nbsp;申请单位：</td>
	    		<td><input type="text" size="12" id="applyCom" name="applyCom" /></td>
	    		<td>&nbsp;&nbsp;&nbsp;&nbsp;经办人：</td>
	    		<td><input type="text" size="12" id="executePeople" name="executePeople"/></td>
	    		<td>&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"/></td>
	    		<td>&nbsp;&nbsp;</td>
	    		<td><input class="scBtn" type="button" value="清空" onclick="cleanClick()"/></td>
	    	</tr>
	    </table>
	    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'chnName',width:40">化学品中文名</th>
	                <th data-options="field:'applyCom',width:50">申请单位</th>
	                <th data-options="field:'executePeople',width:25">经办人</th>
	                <th data-options="field:'mobilePhone',width:40">移动电话</th>
	                <th data-options="field:'email',width:50">电子邮箱</th>
	                <th data-options="field:'fax',width:40">传真</th>
	                <th data-options="field:'createtabledate',width:40">填表日期</th>
	                <th data-options="field:'responsible_person',width:25">单位负责人</th>
	                <th data-options="field:'acceptance_pepple',width:25">受理人</th>
	                <th data-options="field:'scstatus',width:25,formatter:checkStatusFormatter">审核状态</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<input class="scBtn" type="button" value="新增" onclick="add()" />
	    	<input class="scBtn" type="button" value="修改" onclick="formEdit()" />
	    	<input class="scBtn" type="button" value="删除" onclick="sc.form.del()" />
		</div>
  </body>
</html>
