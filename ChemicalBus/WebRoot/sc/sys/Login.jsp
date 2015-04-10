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
<title>��¼</title>
<style type="text/css">
body {
	background: url(sc/img/login_bg.jpg) center top;
}

.logo {
	height: 150px;
	/*background: url(sc/img/logo.png) center no-repeat;*/
}

.inputs {
	width: 477px;
	height: 305px;
	margin: auto;
	background: url(sc/img/loginInput.png);
}

.inputs .ipt {
	width: 160px;
	height: 27px;
	outline: none;
	border:none;
	background: none;
}

#userCode {
	margin: 100px 0 0 255px;
}

#passWord {
	margin: 17px 0 20px 255px;
}

#remenberLabel {
	margin: 0 0 0 255px;
}

#loginBtn {
	
	background: url(sc/img/loginBtn.png);
	width: 75px;
	height: 38px;
	margin: 10px 0 0 253px;
	outline: none;
	border: none;
}

#registerBtn {
	
	background: url(sc/img/registerBtn.png);
	width: 75px;
	height: 38px;
	margin: 10px 0 0 10px;
	outline: none;
	border: none;
}

#loginBtn:active {
	background: url(sc/img/loginBtnS.png);
}

.footer {
	text-align: center;
	color: #fff;
	line-height: 25px;
	padding: 20px 0;
}
</style>
<script type="text/javascript">
var scClassName = "com.sc.sys.service.UserService";
var scDlg = "";
var formName = "��ҵע��";
var pageSize = 10;//ÿҳ��ʾ����
var pageNumber = 1;//��ʼ���������ݣ���1��ʼ��
var order = " order by scShowOrder";//�б�����ʽ
var filter = "";
$(function() {
	scDlg = $(".scDlg");
	//���ʳ�ʱ����ת
	if(window.top != window.self) {top.sc.logout();}
	
	initPage();
});
/**
 * ҳ���ʼ��
 */
var initPage = function() {
	//��ȡ����
	$("#userCode").focus();
	//��ȡcookie��ֵ
	var username = $.cookie("scUserCode");
	var password = $.cookie("scPassword");
	//����ȡ��ֵ������������
	$("#userCode").val(username);
	$("#passWord").val(password); 
	//ѡ�м�ס����ĸ�ѡ��
	if(username != null && username != "" && password != null && password != ""){
		$("#rememberMe").attr("checked",true);
	}
}
/**
 * ��ť-��¼
 */
var loginClick = function() {
	var userCode =$("#userCode").val();
	var password = $("#passWord").val();
	//�û����ǿ���֤
	if(!userCode){
		sc.alert("�������û���");
		return;
	}
	//����ǿ���֤
	if(!password){
		sc.alert("����������");
		return;
	}
	var d = dialog({
	    content: "��¼��..."
	});
	d.showModal();
	//�����֤
	$.ajax({
		type: "POST",
		url: sc.basePath + "servlet/LoginServlet",
		data: "userCode=" + userCode + "&password=" + password,
		async: true,
		success: function(data) {
			d.remove();
			if(data == null || data == "null") {
				//��֤ʧ��
				sc.alert("�û�������������");
			} else {
				//ѡ���ס����ʱ,Ϊ�䴴��cookie
				if($("#rememberMe").prop("checked") == true) {
					$.cookie("scUserCode", userCode, {expires:7});
					$.cookie("scPassword", password, {expires:7});
				} else {//ɾ��cookie
					$.cookie("scUserCode", "", {expires: -1});
					$.cookie("scPassword", "", {expires: -1});
				}
				//�ύ���Ĳ���
				window.location = sc.basePath + "sc/sys/Index.jsp";
			}
		},
		error: function(data) {
			d.remove();
			/*
			sc.alert("<h2>����������</h2><br/>" 
					+ "<a href='#'>֪ͨ����Ա</a>&nbsp;&nbsp;<a href='#'>ˢ������</a><br/>" 
					+ data.responseText);
			*/
			sc.alert("����������");
		}
	});
};

/**
 * ��ҵע��
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		scDlg.find("#orgid").val("69d7d7c4-634b-421a-9b41-fc0e317ee958");
		scDlg.find("#roleid").val("75a7ee97-481a-4499-8b42-80c8c807bd95");
		var Registerpass = $("#passwordShow").val();
		var passToMd5 = ServiceBreakSyn("com.sc.common.util.StrUtil","md5",[Registerpass]);
		scDlg.find("#password").val(passToMd5);
	},function() {
		sc.alert("ע��ɹ�");
	});
}
sc.form.dlgReset = function() {
	scDlg.find(".scSave").val("");
	scDlg.find("#scid").val("");
	scDlg.find(".sc").val("");
}
</script>
<script src="sc/res/jquery.cookie.js" type="text/javascript"></script>

</head>

<body>
	<div class="logo"></div>
	<div class="inputs" onkeydown="sc.enterClick(loginClick)">
		<input class="ipt" type="text" id="userCode" /><br /> 
		<input class="ipt" type="password" id="passWord" /><br /> 
		<label id="remenberLabel"> 
			<input type="checkbox" id="rememberMe">
			��ס���� 
		</label><br /> 
		<div>
		<input type="button" id="loginBtn" onClick="loginClick()" />
		<input type="button" id="registerBtn" onClick="sc.form.add(addSave)" />
		</div>
	</div>
	<div class="footer">
		�й�ʯ�����Ű�ȫ�����о�Ժ ��Ȩ���� �绰��86-532-83786201 ���棺86-532-83861318<br />
		����֧�֣��й�ʯ�����Ű�ȫ�����о�Ժ��Ϣ����<br />
	</div>
	
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<input type="hidden" class="scSave" id="orgid" />
    	<input type="hidden" class="scSave" id="roleid"/>
    	<input type="hidden" class="scSave" id="password"/>
    	<table>
    		<tr>
    			<td>�û�����</td>
    			<td><input type="text" class="scSave" id="username" /></td>
    		</tr>
    		<tr>
    			<td>�˺ţ�</td>
    			<td><input type="text" class="scSave" id="usercode" /></td>
    		</tr>
    		<tr>
    			<td>���룺</td>
    			<td><input type="text" class="sc" id="passwordShow" /></td>
    		</tr>
    	</table>
    </div>
</body>
</html>
