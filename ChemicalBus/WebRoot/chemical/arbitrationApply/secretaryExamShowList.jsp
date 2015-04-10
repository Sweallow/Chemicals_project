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
	  		filter += "and scstatus like '0' and userName like '%"+name+"%'";
	  	}
	  	scDlg = $(".scDlg");//得到对话框
		sc.form.dgPagerInit();//分页初始化
		sc.form.dgDataLoad();//列表数据加载
	  	top.sc.indexAutoHeight();
	  });
	  </script>
	  <script type="text/javascript">
		
		/**
		 *查询
		 */
		var searchClick = function(){
		  filter = "";
		  	var name = sc.user.scid;
	  		if(name){
		  		filter += "and scstatus like '0' and userName like '%"+name+"%'";
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
		 *查看
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
				window.location.href = sc.basePath + "chemical/arbitrationApply/secretaryExamDetail.jsp?scid=" + row[0].scid+"&scstatus="+row[0].scstatus;
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
		
		/**
		 *驳回原因填写
		 */
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
							    	window.location.href = sc.basePath + "chemical/arbitrationApply/secretaryExamShowList.jsp";
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
		}
		
		/**
		 *审核失败提示信息
		 */
		function showMsg(){
			var d = dialog({
			    content: "审核失败！",
			    okValue: "确定",
			    ok: function() {
			    	window.location.href = sc.basePath + "chemical/arbitrationApply/secretaryExamShowList.jsp";
			    }
			});
			d.showModal();
		}
		
		/**
		 *审核
		 */
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
							    content: "审核成功，请填写通知书！",
							    okValue: "确定",
							    ok: function() {
							    	window.location.href = sc.basePath + "sc/chemical/resultNotice.jsp?appScid="+row[0].scid;
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
    <div class="scTitle">化学品物理危险性鉴定仲裁秘书处审核</div>
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
	    	<input class="scBtn" type="button" value="审核通过" onclick="secretaryExam(1)" />
	    	<input class="scBtn" type="button" value="审核驳回" onclick="secretaryExam(-1)" />
	    	<input class="scBtn" type="button" value="查看" onclick="formEdit()" />
		</div>
  </body>
</html>
