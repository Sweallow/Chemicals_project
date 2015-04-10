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
    <title>企业基本信息审核</title>
    
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
		  	filter += " and scStatus = 0 and userName like '%" + name + "%'";
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
		  	filter += " and scStatus = 0 and userName like '%" + name + "%'";
		} 
		var enterpriseName = $("#enterpriseName").val();
		if(enterpriseName){
			filter += " and enterpriseName like '%" + enterpriseName + "%'";
		}
		var enterpriseAttribute = $("#enterpriseAttribute").val();
		if(enterpriseAttribute){
			filter +=" and enterpriseAttribute like '%" + enterpriseAttribute + "%'";
		}
		  	sc.form.dgDataLoad();//列表数据加载
	};
	//重置
	var resetClick = function(){
		$("#enterpriseName").val("");
		$("#enterpriseAttribute").val("");
		window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
	};
	
	//驳回原因填写
	var dlgShow = function(i,scid) {
		var d = dialog({
			lock:true,
		    title: '驳回原因',
		    content: "<textarea id = 'reason' rows='6' cols='50'></textarea>",
		    okValue: "提交",
		    ok: function() {
				var rs = $("#reason").val();
				ServiceBreak(scClassName, "updateReason", [rs, scid], function(data){
					if(data){
					}else{
						showMsg();
					}
				});
				ServiceBreak(scClassName, "updateScstatus", [i, scid], function(data){
					if(data == "success"){
						var d = dialog({
						    content: "数据已成功驳回！",
						    okValue: "确定",
						    ok: function() {
						    	window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
						    }
						});
						d.showModal();
					}else{
						showMsg();
					}
				});
				
		    },
		    cancelValue: "取消",
			cancel: function () {} 
		});
		d.showModal();
	};
	//审核失败提示信息
	function showMsg(){
		var d = dialog({
		    content: "审核失败！",
		    okValue: "确定",
		    ok: function() {
		    	window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
		    }
		});
		d.showModal();
	}
	
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
	
	
	//审核
	function secretaryExam(i){
		var row = $('#dg').datagrid('getSelections');
		if(row.length == 0) {
			sc.alert("请选择要审核的数据。");
			return;
		} else if(row.length > 1) {
			sc.alert("一次只能审核一条数据。");
			return;
		} else {
			if(i == 1){
				ServiceBreak(scClassName, "updateScstatus", [i, row[0].scid], function(data){
					if(data == "success"){
						var d = dialog({
						    content: "审核成功！",
						    okValue: "确定",
						    ok: function() {
						    	window.location.href = sc.basePath + "chemical/company/enterpriseInfoAuditing.jsp";
						    }
						});
						d.showModal();
					}else{
						showMsg();
					}
				});
			}else if(i == -1){
				dlgShow(i,row[0].scid);
			}
		};
	}
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
                <th data-options="field:'operator',width:75">经办人</th> 
                <th data-options="field:'phone',width:80">联系电话</th>
                <th data-options="field:'scStatus',width:80,formatter:checkStatusFormatter">审核状态</th>
                                          
			</tr>
		</thead>
	</table>
		<div id="toolbar">
	    	<input class="scBtn" type="button" value="审核通过" onclick="secretaryExam(1)" />
	    	<input class="scBtn" type="button" value="审核驳回" onclick="secretaryExam(-1)" />
	    	<input class="scBtn" type="button" value="查看" onclick="formSelect()" />
		</div>
	<script type="text/javascript">
	  	function formSelect(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("请选择要查看的记录。");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("一次只能查看一条记录。");
	  			return;
	  		} else {
	  			window.location.href = sc.basePath + "chemical/company/companyExamine.jsp?scid=" + row[0].scid;
	  		};
			
		};
	 </script>   
  </body>
</html>
