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
    <title>分类信息</title>
<link rel="stylesheet" href="css/index.css" />    
<style type="text/css">

.content {
	margin-top:10px;
	min-height:500px;
}
.content .scLeft {
	width: 760px;
}
.pager {
	text-align: center;
	margin: 10px;
}
.pager a {
	color: #20769f;
	text-decoration: underline;
}
.list td {
	text-align: center;
	padding:10px;
	border-bottom: 1px #ccc dotted;
}

.content .scRight {
	width: 200px;
}
</style>    
	<script type="text/javascript">
	var curPage = 1;
	var pageSize = 10;
	var maxPage = 2;
	var total = 20;
	var scClassName = "";
	var filter = "";
	//var pageNumber = 1;
	var order = "ORDER BY SCCREATEDATE DESC";
	$(document).ready(function() {
		loadPageData();
	});	
	//首页
	var topPage = function() {
		if(curPage > 1) {
			curPage = 1;
			loadPageData();
		}
		
	}
	var upPage = function() {
		if(curPage > 1) {
			curPage -= 1;
			loadPageData();
		}
	}
	var downPage = function() {
		if(curPage < maxPage) {
			curPage += 1;
			loadPageData();
		}
	}
	//末页
	var endPage = function() {
		if(curPage < maxPage) {
			curPage = maxPage;
			loadPageData();
		}
	}
	var searchClick = function(){
		curPage = 1;
		loadPageData();
	}
	var loadPageData = function() {
		var types = sc.getUrlQuery("t");
		var startIndex = (curPage - 1) * pageSize;
		var keyWord = $("#scKeyWord").val();
		filter = "";
		if(types == "jdzc"){
			if(keyWord){
		 		filter = "and (chemicalName like '%" + keyWord + "%' or unitName like '%" + keyWord + "%' or sealDate like '%" + keyWord + "%')";
		 	}
			scClassName = "chemical.service.ResultNoticeService";
			ServiceBreak(scClassName, "getTableData", [startIndex + "", pageSize + "", filter, order], 
				function(pager) {
					total = pager.total;
					maxPage = Math.ceil(total/pageSize);
					if(pager != null && pager != 'null') {
						var str = "<tr><th width=\"32px\">序号</th><th>化学品名称</th><th>申请单位</th><th>通知书日期</th></tr>";
						for(var i = 0; i < pager.rows.length; i++) {
							row = pager.rows[i];
							var hrefUrl = sc.basePath + "identificationArbitration.jsp?scid=" + row.scid;
							str += "<tr><td>" + (i + 1) + "</td><td><a href="+hrefUrl+">"+row.chemicalName+"</a></td><td>"+row.unitName+"</td><td>"+row.sealDate+"</td></tr>";
						}
						$("#dataTab").html(str);
						if(total<pageSize){$("#toolbar").attr({style:"display:none"});}
					}
				});
		}else if(types == "flbg"){
			if(keyWord){
		 		filter = "and (Chemical like '%" + keyWord + "%' or Userd like '%" + keyWord + "%' or data2 like '%" + keyWord + "%')";
		 	}
			scClassName = "com.sc.report.service.InformationService";
			ServiceBreak(scClassName, "getTableData", [startIndex + "", pageSize + "", filter, order], 
				function(pager) {//alert(JSON.stringify(pager));
					total = pager.total;
					maxPage = Math.ceil(total/pageSize);
					if(pager != null && pager != 'null') {
						var str = "<tr><th width=\"32px\">序号</th><th>化学品名称</th><th>申请单位</th><th>通知书日期</th></tr>";
						for(var i = 0; i < pager.rows.length; i++) {
							row = pager.rows[i];
							var hrefUrl = sc.basePath + "classifyReport.jsp?scid=" + row.scid;
							str += "<tr><td>" + (i + 1) + "</td><td><a href="+hrefUrl+">"+row.Chemical+"</a></td><td>"+row.Userd+"</td><td>"+row.data2+"</td></tr>";
						}
						$("#dataTab").html(str);
						if(total<pageSize){$("#toolbar").attr({style:"display:none"});}
					}
				});
		}else if(types == "jbxx"){
			if(keyWord){
		 		filter = "and (enterpriseName like '%" + keyWord + "%' or adress like '%" + keyWord + "%' or enterpriseAttribute like '%" + keyWord + "%')";
		 	}
			scClassName = "com.sc.chemical.service.ApplicationEnterpriseInfoService";
			ServiceBreak(scClassName, "getTableData", [startIndex + "", pageSize + "", filter, order], 
				function(pager) {//alert(JSON.stringify(pager));
					total = pager.total;
					/*if(total%pageSize == 0){
						maxPage = total/pageSize;
					}else{
						maxPage = pager.total/pageSize + 1;
					}*/
					maxPage = Math.ceil(total/pageSize); 
					if(pager != null && pager != 'null') {
						var str = "<tr><th width=\"32px\">序号</th><th>单位名称</th><th>单位地址</th><th>企业性质</th></tr>";
						for(var i = 0; i < pager.rows.length; i++) {
							row = pager.rows[i];
							var hrefUrl = sc.basePath + "enterpriseReporting.jsp?scid=" + row.scid;
							str += "<tr><td>" + (i + 1) + "</td><td><a href="+hrefUrl+">"+row.enterpriseName+"</a></td><td>"+row.adress+"</td><td>"+row.enterpriseAttribute+"</td></tr>";
						}
						$("#dataTab").html(str);
						if(total<pageSize){$("#toolbar").attr({style:"display:none"});}
					}
				});
		}else if(types == "flzc"){
			if(keyWord){
		 		filter = "and (acceptNumber like '%" + keyWord + "%' or applicationEnterprise like '%" + keyWord + "%' or abstempelnTime like '%" + keyWord + "%')";
		 	}
			scClassName = "com.sc.chemical.service.CategoryArbitralResultService";
			ServiceBreak(scClassName, "getTableData", [startIndex + "", pageSize + "", filter, order], 
				function(pager) {//alert(JSON.stringify(pager));
					total = pager.total;
					maxPage = Math.ceil(total/pageSize);
					if(pager != null && pager != 'null') {
						
						var str = "<tr><th width=\"32px\">序号</th><th>化学品受理编号</th><th>申请单位</th><th>通知书日期</th></tr>";
						for(var i = 0; i < pager.rows.length; i++) {
							row = pager.rows[i];
							var hrefUrl = sc.basePath + "classificationArbitration.jsp?scid=" + row.scid;
							str += "<tr><td>" + (i + 1) + "</td><td><a href="+hrefUrl+">"+row.acceptNumber+"</a></td><td>"+row.applicationEnterprise+"</td><td>"+row.abstempelnTime+"</td></tr>";
						}
						$("#dataTab").html(str);
						if(total<pageSize){$("#toolbar").attr({style:"display:none"});}
					}
				});
		}
		var s = " <a href='javascript:void(0)' onclick='topPage()'>首页</a>&nbsp;&nbsp;"+
		        "<a href='javascript:void(0)' onclick='upPage()'>上一页</a>&nbsp;&nbsp;"+
		        "<a href='javascript:void(0)' onclick='downPage()'>下一页</a>&nbsp;&nbsp;"+
		        "<a href='javascript:void(0)' onclick='endPage()'>末页</a>";
		$("#toolbar").html("共"+total+"条&nbsp;&nbsp;分"+maxPage+"页&nbsp;&nbsp;当前第"+curPage+"页&nbsp;&nbsp;"+s);
	}
</script>    
  </head>
  
  <body>
	<%@ include file="/header.jsp"%>
	<div class="mainWidth content" >
		<div class="scLeft">
			<table class="scSearcher" cellspace="0" cellpadding="0" border="0">
		    	<tr>
		    		<td>关键词：</td>
		    		<td><input type="text" id="scKeyWord" /></td>
		    		<td><input class="scBtn" type="button" value="搜索"  onclick="searchClick()" /></td>
		    	</tr>
		    </table>
		    <table id="dataTab" class="list" cellspace="0" cellpadding="0" border="0" width="100%"></table>
    		<div class="pager" id="toolbar">
    		</div>
		</div>
		<div class="scRight">213</div>
		<div class="scClear"></div>
    	
    </div>
	<%@ include file="/footer.jsp"%>
  </body>
</html>
