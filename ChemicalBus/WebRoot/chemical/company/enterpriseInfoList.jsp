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
    <title>企业信息管理</title>
    
<script type="text/javascript">
	var scClassName = "com.sc.chemical.service.ApplicationEnterpriseInfoService";
	var filter = "";
	var scDlg = "";
	var pageSize = 10;//每页显示条数
	var pageNumber = 1;//起始数据条数据（从1开始）
	var formName = "企业基本信息";//表单名称
	var order = " order by scShowOrder";//列表排序方式
	
	$(document).ready(function() {
	    var name = sc.user.scid;
		if(name){
	  		filter += "and userName like '%" + name + "%'";
	  		order = " order by case when (scStatus = 0) then 0 when (scStatus = -1) then 1 else 2 end,scCreatedate desc ";
	  	}
		scDlg = $(".scDlg");//得到对话框
		sc.form.dgPagerInit();//分页初始化
		
		sc.form.dgDataLoad();//列表数据加载
		top.sc.indexAutoHeight();
	});
	//查询
	var searchClick = function(){
		filter = "";
	  	var name = sc.user.scid;
		if(name){
		  	filter += " and userName like '%" + name + "%'";
		} 
		var enterpriseName = $("#enterpriseName").val();
		var enterpriseAttribute = $("#enterpriseAttribute").val();
		if(enterpriseName){
			filter += " and enterpriseName like '%" + enterpriseName + "%'";
		}
		if(enterpriseAttribute){
			filter += " and enterpriseAttribute like '%" + enterpriseAttribute + "%'";
		}
		sc.form.dgDataLoad();//列表数据加载
	};
	//重置
	var resetClick = function(){
		$("#enterpriseName").val("");
		$("#enterpriseAttribute").val("");
		window.location.href = sc.basePath + "chemical/company/enterpriseInfoList.jsp";
	};
	
	//审核显示
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
</script>  
  </head>
  
  <body>
     <div class="scTitle">企业基本信息</div>
    <table class="scSearcher" cellspacing="0" cellpadding="0" border="0">
    	<tr>
    		<td>单位名称：</td>
    		<td><input type="text" id="enterpriseName" /></td>
    		<td> &nbsp;&nbsp;单位属性：</td>
    		<td><input type="text" id="enterpriseAttribute"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="查询" onclick="searchClick()"/></td>
    		<td> &nbsp;&nbsp;</td>
    		<td><input class="scBtn" type="button" value="清空" onclick="resetClick()"/></td>
    	</tr>
    </table>
    <table id="dg" class="scDg easyui-datagrid" style="height:350px;"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'enterpriseName',width:80">单位名称</th>
                <th data-options="field:'enterpriseAttribute',width:80">单位属性</th>
                <th data-options="field:'adress',width:80">地址</th>
                <th data-options="field:'email',width:70">邮编</th>
                <th data-options="field:'appraisalNumber',width:70">鉴定个数</th>
                <th data-options="field:'operator',width:70">经办人</th> 
                <th data-options="field:'phone',width:80">联系电话</th>
                <th data-options="field:'scStatus',width:80,formatter:checkStatusFormatter">审核状态</th>
                                          
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="新增" onclick="formAdd()" />
    	<input class="scBtn" type="button" value="修改" onclick="formEdit()" />
    	<input class="scBtn" type="button" value="删除" onclick="delData()" />
    	
	</div>
	<script type="text/javascript">
		//新增
	  	function formAdd(){
			window.location.href = sc.basePath + "chemical/company/companyD.jsp";
		};
		//修改
	  	function formEdit(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("请选择要修改的数据。");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("一次只能修改一条数据。");
	  			return;
	  		}else {
	  			window.location.href = sc.basePath + "chemical/company/companyD.jsp?scid=" + row[0].scid;
	  		};
		};
		//删除
		function delData(){
			//debugger;
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
  </body>
</html>
