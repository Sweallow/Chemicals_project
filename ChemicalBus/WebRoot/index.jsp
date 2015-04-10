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
    <title>��ҳ</title>
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
		loadQyjbxx();//��ҵ��Ϣ
		loadFlbg();//���౨��
		loadJdzc();//�����ٲ�
		loadFlzc();//�����ٲ�
	});
	//��ҵ��Ϣ
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
	//���౨��
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
	//�����ٲ�
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
	//�����ٲ�
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
            	<div class="scLeft">��ҵ������Ϣ</div>
                <div class="scRight" onclick="gotyType('jbxx')">����</div>
                <div class="scClear"></div>
            </div>
            <table id="qyjbxx" class="ctx" cellpadding="0" cellspacing="0" width="95%" >
                <%--<tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">�ൺ��ȫ�����о�Ժ</a></td>
                    <td>�Ӱ���·218��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">�й�ʯ����������</a></td>
                    <td>ɽ������</td>
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
            	<div class="scLeft">���౨��</div>
                <div class="scRight" onclick="gotyType('flbg')">����</div>
                <div class="scClear"></div>
            </div>
            <table id="flbg" class="ctx" cellpadding="0" cellspacing="0" width="95%">
            <%-- <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">��������</a></td>
                    <td>��������</td>
                    <td>2014-12-23</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">Ũ����</a></td>
                    <td>�ൺ����Ժ</td>
                    <td>2014-12-22</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">����ϩ</a></td>
                    <td>�ൺ����Ժ</td>
                    <td>2014-12-22</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">Ũ����</a></td>
                    <td>�ൺ����Ժ</td>
                    <td>2014-12-22</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">������ϩ</a></td>
                    <td>�ൺ����Ժ</td>
                    <td>2014-12-22</td>
                </tr>
            --%>
            </table>
        </div>
        <div class="scClear"></div>
        <div class="scLeft typeData">
        	<div class="title">
            	<div class="scLeft">�����ٲ�</div>
                <div class="scRight" onclick="gotyType('jdzc')">����</div>
                <div class="scClear"></div>
            </div>
            <table id="jdzc" class="ctx" cellpadding="0" cellspacing="0" width="95%">
            <%--<tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">����������۵�</a></td>
                    <td>����Ժ��ѧƷ��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">����������۵�</a></td>
                    <td>����Ժ��ѧƷ��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">��������</a></td>
                    <td>����Ժ��ѧƷ��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">����������۵�</a></td>
                    <td>����Ժ��ѧƷ��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">������ϩ</a></td>
                    <td>����Ժ��ѧƷ��</td>
                    <td>86-532-83786201</td>
                </tr>--%>
            </table>
        </div>
        <div class="scRight typeData">
        	<div class="title">
            	<div class="scLeft">�����ٲ�</div>
                <div class="scRight" onclick="gotyType('flzc')">����</div>
                <div class="scClear"></div>
            </div>
            <table id="flzc" class="ctx" cellpadding="0" cellspacing="0" width="95%">
            <%--<tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">��������</a></td>
                    <td>����ԺHSE��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">����</a></td>
                    <td>����ԺHSE��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">�軯��</a></td>
                    <td>����ԺHSE��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">Ũ����</a></td>
                    <td>����ԺHSE��</td>
                    <td>86-532-83786201</td>
                </tr>
                <tr>
                    <td>&middot;&nbsp;&nbsp;<a href="#">�Ȼ���</a></td>
                    <td>����ԺHSE��</td>
                    <td>86-532-83786201</td>
                </tr>--%>
            </table>
        </div>
        <div class="scClear"></div>
    </div>
    <%@ include file="/footer.jsp"%>
  </body>
</html>
