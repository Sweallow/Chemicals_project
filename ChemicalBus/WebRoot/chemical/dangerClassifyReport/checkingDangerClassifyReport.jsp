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
    <title>化学品物理危险性分类登记中心审核</title>
    <script type="text/javascript">
		var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
		var filter = "";
		var scDlg = "";
		var pageSize = 10;//每页显示条数
		var pageNumber = 1;//起始数据条数据（从1开始）
		var formName = "化学品物理危险性分类登记中心审核";//表单名称
		var order = " order by scShowOrder desc";//列表排序方式

		$(document).ready(function() {
			filter = "";
			//登录人的id
		  	var userId = sc.user.scid;
			if(userId){
				//过滤只显示scstatus为0的数据，即只显示待审核的
			  	filter += "and scstatus = 0  and userId like '%"+userId+"%' ";
			}
			scDlg = $(".scDlg");//得到对话框
			sc.form.dgPagerInit();//分页初始化
			sc.form.dgDataLoad();//列表数据加载
			top.sc.indexAutoHeight();
		});
		
		//根据查询条件查询数据，显示列表
		var findData = function(){
			filter = "";
			var userId = sc.user.scid;
			if(userId){
				//过滤只显示scstatus为0的数据，即只显示待审核的
			  	filter += "and scstatus = 0  and userId like '%"+userId+"%' ";
			}
			var unit_name= $("#unit_name").val();
			if(unit_name){
				filter += " and scstatus = 0 and unit_name like '%"+unit_name+"%'";
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
		
		//清空查询框数据
		function clearData() {
			$("#unit_name").val("");
			$("#unit_property").val("");
			$("#chemist_name").val("");
			$("#acceptance_no").val("");
		}
		
		//驳回原因填写
		var dlgShow = function(i,scid) {
			var d = dialog({
				lock:true,
			    title: '驳回原因',
			    content: "<textarea id = 'reason' rows='6' cols='50'></textarea>",
			    okValue: "提交",
			    ok: function() {
					var rs = $("#reason").val();
					ServiceBreak(scClassName, "updateReason", [rs, scid],function(data){
						if(data){
							//sc.alert("数据已成功驳回！");
						}else{
							showMsg();
						}
					});
					ServiceBreak(scClassName, "updateScstatus", [i, scid],function(data){
						if(data == "success"){
							var d = dialog({
							    content: "数据已成功驳回！",
							    okValue: "确定",
							    ok: function() {
							    	window.location.href = sc.basePath 
							    		+ "chemical/dangerClassifyReport/checkingDangerClassifyReport.jsp";
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
			    	window.location.href = sc.basePath 
			    		+ "chemical/dangerClassifyReport/checkingDangerClassifyReport.jsp";
			    }
			});
			d.showModal();
		}
		
		//状态判断
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
				sc.alert("请选择要审核/驳回的数据。");
				return;
			} else if(row.length > 1) {
				sc.alert("一次只能审核/驳回一条数据。");
				return;
			} else {
				if(i == 1){
					ServiceBreak(scClassName, "updateScstatus", [i, row[0].scid], function(data){
						if(data == "success") {
							var d = dialog({
							    content: "审核成功，请填写通知书！",
							    okValue: "确定",
							    ok: function() {
							    	window.location.href = sc.basePath + "chemical/report/reportD.jsp?appscid=" + row[0].scid;
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
		
		//查看
		function formSelect(){
	  		var row = $('#dg').datagrid('getSelections');
	  		if(row.length == 0) {
	  			sc.alert("请选择要查看的记录。");
	  			return;
	  		} else if(row.length > 1) {
	  			sc.alert("一次只能查看一条记录。");
	  			return;
	  		} else {
	  			window.location.href = sc.basePath 
	  			+ "chemical/dangerClassifyReport/showDangerClassifyReportInfo.jsp?scid=" + row[0].scid+"&scstatus="+row[0].scstatus;
	  		};
		};
	</script>
  </head>
  <body>
	<div class="scTitle">化学品物理危险性分类登记中心审核</div>
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
                <th data-options="field:'scstatus',width:80,formatter:checkStatusFormatter">审核状态</th>                        
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<input class="scBtn" type="button" value="审核通过" onclick="secretaryExam(1)" />
	    <input class="scBtn" type="button" value="审核驳回" onclick="secretaryExam(-1)" />
	    <input class="scBtn" type="button" value="查看" onclick="formSelect()" />  	
	</div>   
  </body>
</html>
