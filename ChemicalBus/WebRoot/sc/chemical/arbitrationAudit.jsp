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
    <title>化学品物理危险性分类仲裁审核</title>
	<script type="text/javascript">
		var scClassName = "chemical.service.ChemicalApplicationService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "化学品物理危险性分类仲裁审核";//表单名称
		var order = " order by scShowOrder";//列表排序方式
	
		$(document).ready(function() {
		  	filter = "";
		  	var name = sc.user.scid;
	  		if(name){
		  		filter += "and scStatus like '0' and userCode like '%"+name+"%'";
		  	}
		  	scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
		  	top.sc.indexAutoHeight();
		});

		//查看详细
		var checkDetail=function(){
			var row = $('#dg').datagrid('getSelections');
			if(row.length == 0) {
				sc.alert("请选择要查看的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能查看一条数据。");
				return;
			} else {			
				 window.location.href=sc.basePath
				 	+"sc/chemical/applicationFmForLook.jsp?scid="+row[0].scid+"&scStatus="+row[0].scStatus;
			}
		};
		
		//查询
		var searchClick = function(){
		    filter = "";
		  	var code = sc.user.scid;
			if(code){
			  	filter += " and scStatus = 0 and userCode like '%" + code + "%'";
			}
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

		//重置
		var clearSearch =function(){
			$("#applyUnit").val("");
			$("#acceptanceDate").val("");	
			$("chineseName").val("");
			window.location.href=sc.basePath+"sc/chemical/arbitrationAudit.jsp";
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
				if(i == 1) {
					ServiceBreak(scClassName, "updateScstatus", [i, row[0].scid], function(data){
						if(data == "success") {
							var d = dialog({
							    content: "审核成功，请填写通知书！",
							    okValue: "确定",
							    ok: function() {
							    	window.location.href = sc.basePath 
							    		+ "chemical/type/categoryArbitralResult.jsp?appscid="+row[0].scid;
							    }
							});
							d.showModal();
						} else {
							showMsg();
						}
					});
				} else if(i == -1) {
					dlgShow(i,row[0].scid);
				}
			};
		}
		
		//审核失败提示信息
		function showMsg(){
			var d = dialog({
			    content: "审核失败！",
			    okValue: "确定",
			    ok: function() {
			    	window.location.href = sc.basePath + "sc/chemical/arbitrationAudit.jsp";
			    }
			});
			d.showModal();
		}
		
		//驳回原因填写
		var dlgShow = function(i,scid) {
			var d = dialog({
				lock:true,
			    title: '驳回原因',
			    content: "<textarea id = 'theReason' rows='6' cols='50'></textarea>",
			    okValue: "提交",
			    ok: function() {
					var rs = $("#theReason").val();
					ServiceBreak(scClassName, "updateReason", [rs, scid], function(data){
						if(data){
							//sc.alert("数据已成功驳回！");
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
							    	window.location.href = sc.basePath+"sc/chemical/arbitrationAudit.jsp";
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
	
		/**
		*  审核状态格式化
		*/
		var checkStatusFormmater=function(val,rec) {
			var res="";
			if (val == "-1") {
				res = "驳回";
			} else if(val == "0") {
				res = "待审核";
			} else if(val == "1") {
				res = "审核通过";
			}
			return res;
		};
	</script>  
  </head>
  <body>
    <div class="scTitle">化学品物理危险性分类仲裁审核</div>
    <table class="scSearcher" cellspace="0" cellpadding="0" border="0">
    	<tr>
    		<td>申请单位：</td>
    		<td><input type="text" id="applyUnit" /></td>
    		<td>&nbsp;&nbsp;受理日期：</td>
    		<td><input type="text" id="acceptanceDate"  onclick="WdatePicker()" /></td>
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
		<input class="scBtn" type="button" value="审核通过" onclick="secretaryExam(1)" />
    	<input class="scBtn" type="button" value="审核驳回" onclick="secretaryExam(-1)" />
    	<input class="scBtn" type="button" value="查看" onclick="checkDetail()" />
	</div>
  </body>
</html>
