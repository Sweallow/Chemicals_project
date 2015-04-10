<%@ page language="java" import="java.util.*,com.sc.chemical.dao.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <%@ include file="/sc/common.jsp"%>
    <title>主页</title>
<link rel="stylesheet" href="css/index.css" />    
<style type="text/css">

.content {
	margin-top:10px;
	min-height:500px;
}
.banner {
	height:150px;
	background:url(sc/img/banner.jpg);
	background-size:100%;
}
.typeData {
	width:470px;
	border:1px #cccccc solid;
	margin-top:20px;
	padding-bottom:15px;
}
.typeData .title {
	background:url(sc/img/typeTitle.png);
	border-bottom:1px #cccccc solid;
}
.typeData .title .scLeft{
	font-size:14px;
	font-weight:bold;
	height: 32px;
	width: 126px;
	padding-left: 15px;
	line-height: 32px;
	background:url(sc/img/typeTitleL.png);
}
.typeData .title .scRight {
	padding-right:15px;
	line-height: 32px;
	text-decoration:underline;
	cursor:pointer;
}
.typeData .ctx {
	margin:auto;
}
.typeData td {
	padding:5px;
	border-bottom:1px #ccc dotted;
}
.typeData a {
	color:#444;
}
</style>	

<script type="text/javascript">
	$(function() {
		loadQyjbxx();//企业信息
		loadFlbg();//分类报告
		loadJdzc();//鉴定仲裁
		loadFlzc();//分类仲裁
	});
	//企业信息
	var loadQyjbxx = function() {
		ServiceBreak("com.sc.chemical.service.ApplicationEnterpriseInfoService", 
				"getTableData", [ 0, 5, "", "order by scCreatedate desc"], 
				function(pager) {
			if(pager != null && pager != 'null') {//debugger;
				var str = "";
				for(var i= 0; i < 5; i++) {
					if(i < pager.rows.length){
						var obj = pager.rows[i];
						var hrefUrl = sc.basePath + "enterpriseReporting.jsp?scid=" + obj.scid;
						str += "<tr><td>&middot;&nbsp;&nbsp;<a href='" + hrefUrl + "'>" 
							+ obj.enterpriseName + "</a></td><td>" + obj.adress + "</td><td>" 
							+ obj.operator + "</td><td>" + obj.phone + "</td></tr>";
					}else{
						str += "<tr><td>&middot;&nbsp;&nbsp;</td><td></td><td></td></tr>";
					}
				}
				$("#qyjbxx").html(str);
			}
		});
	};
	//分类报告
	var loadFlbg = function() {
		ServiceBreak("com.sc.report.service.InformationService", 
				"getTableData", [ 0, 5, "", "order by scCreatedate desc"], 
				function(pager) {
			if(pager != null && pager != 'null') {//debugger;
				var str = "";
				for(var i= 0; i < 5 ; i++) {
					if(i < pager.rows.length){
						var obj = pager.rows[i];
						var hrefUrl = sc.basePath + "classifyReport.jsp?scid=" + obj.scid;
						str += "<tr><td>&middot;&nbsp;&nbsp;<a href='" + hrefUrl + "'>" 
						+ obj.Chemical + "</a></td><td>" + obj.Userd + "</td><td>" 
						+ obj.Acceptance_number + "</td><td>" + obj.data3 + "</td></tr>";
					}else{
						str += "<tr><td>&middot;&nbsp;&nbsp;</td><td></td><td></td></tr>";
					}
				}
				$("#flbg").html(str);
			} 
		});
	};
	//鉴定仲裁
	var loadJdzc = function() {
		ServiceBreak("chemical.service.ResultNoticeService", 
				"getTableData", [ 0, 5, "", "order by scCreatedate desc"], 
				function(pager) {
			if(pager != null && pager != 'null') {//debugger;
				var str = "";
				for(var i= 0; i < 5; i++) {
					if(i< pager.rows.length){
						var obj = pager.rows[i];
						var hrefUrl = sc.basePath + "identificationArbitration.jsp?scid=" + obj.scid;
						str += "<tr><td>&middot;&nbsp;&nbsp;<a href='" + hrefUrl + "'>" 
						+ obj.unitName + "</a></td><td>" + obj.chemicalName + "</td><td>" 
						+ obj.identificationProject + "</td><td>" + obj.telNumber + "</td></tr>";
					}else{
						str += "<tr><td>&middot;&nbsp;&nbsp;</td><td></td><td></td></tr>";
					}
				}
				$("#jdzc").html(str);
			} 
		});
	};
	//分类仲裁
	var loadFlzc = function() {
		ServiceBreak("com.sc.chemical.service.CategoryArbitralResultService", 
				"getTableData", [ 0, 5, "", "order by scCreatedate desc"], 
				function(pager) {
			if(pager != null && pager != 'null') {//debugger;
				var str = "";
				for(var i= 0; i < 5; i++) {
					if(i < pager.rows.length){
						var obj = pager.rows[i];
						var hrefUrl = sc.basePath + "classificationArbitration.jsp?scid=" + obj.scid;
						str += "<tr><td>&middot;&nbsp;&nbsp;<a href='" + hrefUrl + "'>" 
						+ obj.applicationEnterprise + "</a></td><td>" + obj.arbitralResult 
						+ "</td><td>"+obj.contactPerson + "</td><td>" + obj.phone + "</td></tr>";
					}else{
						str += "<tr><td>&middot;&nbsp;&nbsp;</td><td></td><td></td></tr>";
					}
				}
				$("#flzc").html(str);
			} 
		});
	};
</script>

  </head>
  
  <body>
    <%@ include file="/header.jsp"%>
	<div class="mainWidth content">
    	<div class="banner">
        	
        </div>
    	<div class="scLeft typeData">
        	<div class="title">
            	<div class="scLeft">企业基本信息</div>
                <div class="scRight" onclick="gotyType('jbxx')">更多</div>
                <div class="scClear"></div>
            </div>
            <table id="qyjbxx" class="ctx" cellpadding="0" cellspacing="0" width="95%" >
                <%--<tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">青岛安全工程研究院</a></td>
                    <td>延安三路218号</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">中国石化济南炼化</a></td>
                    <td>山东济南</td>
                    <td>0531-82356998</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;</td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;</td>
                    <td></td>
                    <td></td>
                </tr>
            --%>
            </table>
        </div>
        <div class="scRight typeData">
        	<div class="title">
            	<div class="scLeft">分类报告</div>
                <div class="scRight" onclick="gotyType('flbg')">更多</div>
                <div class="scClear"></div>
            </div>
            <table id="flbg" class="ctx" cellpadding="0" cellspacing="0" width="95%">
            <%-- <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">发烟硫酸</a></td>
                    <td>济南炼化</td>
                    <td>2014-12-23</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">浓硝酸</a></td>
                    <td>青岛安工院</td>
                    <td>2014-12-22</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">聚乙烯</a></td>
                    <td>青岛安工院</td>
                    <td>2014-12-22</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">浓硝酸</a></td>
                    <td>青岛安工院</td>
                    <td>2014-12-22</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">聚氯乙烯</a></td>
                    <td>青岛安工院</td>
                    <td>2014-12-22</td>
                </tr>
            --%>
            </table>
        </div>
        <div class="scClear"></div>
        <div class="scLeft typeData">
        	<div class="title">
            	<div class="scLeft">鉴定仲裁</div>
                <div class="scRight" onclick="gotyType('jdzc')">更多</div>
                <div class="scClear"></div>
            </div>
            <table id="jdzc" class="ctx" cellpadding="0" cellspacing="0" width="95%">
            <%--<tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">二氧化硅的熔点</a></td>
                    <td>安工院化学品室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">二氧化硅的熔点</a></td>
                    <td>安工院化学品室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">发烟硫酸</a></td>
                    <td>安工院化学品室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">二氧化硅的熔点</a></td>
                    <td>安工院化学品室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">聚氯乙烯</a></td>
                    <td>安工院化学品室</td>
                    <td>86-532-83786201</td>
                </tr>--%>
            </table>
        </div>
        <div class="scRight typeData">
        	<div class="title">
            	<div class="scLeft">分类仲裁</div>
                <div class="scRight" onclick="gotyType('flzc')">更多</div>
                <div class="scClear"></div>
            </div>
            <table id="flzc" class="ctx" cellpadding="0" cellspacing="0" width="95%">
            <%--<tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">二氧化硅</a></td>
                    <td>安工院HSE室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">白磷</a></td>
                    <td>安工院HSE室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">氰化钾</a></td>
                    <td>安工院HSE室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">浓硫酸</a></td>
                    <td>安工院HSE室</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">氯化氢</a></td>
                    <td>安工院HSE室</td>
                    <td>86-532-83786201</td>
                </tr>--%>
            </table>
        </div>
        <div class="scClear"></div>
    </div>
    <%@ include file="/footer.jsp"%>
  </body>
</html>
