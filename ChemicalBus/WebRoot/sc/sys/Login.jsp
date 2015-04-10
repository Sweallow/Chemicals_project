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
<title>登录</title>
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
var formName = "企业注册";
var pageSize = 10;//每页显示条数
var pageNumber = 1;//起始数据条数据（从1开始）
var order = " order by scShowOrder";//列表排序方式
var filter = "";
$(function() {
	scDlg = $(".scDlg");
	//访问超时，跳转
	if(window.top != window.self) {top.sc.logout();}
	
	initPage();
});
/**
 * 页面初始化
 */
var initPage = function() {
	//获取焦点
	$("#userCode").focus();
	//获取cookie的值
	var username = $.cookie("scUserCode");
	var password = $.cookie("scPassword");
	//将获取的值填充入输入框中
	$("#userCode").val(username);
	$("#passWord").val(password); 
	//选中记住密码的复选框
	if(username != null && username != "" && password != null && password != ""){
		$("#rememberMe").attr("checked",true);
	}
}
/**
 * 按钮-登录
 */
var loginClick = function() {
	var userCode =$("#userCode").val();
	var password = $("#passWord").val();
	//用户名非空验证
	if(!userCode){
		sc.alert("请输入用户名");
		return;
	}
	//密码非空验证
	if(!password){
		sc.alert("请输入密码");
		return;
	}
	var d = dialog({
	    content: "登录中..."
	});
	d.showModal();
	//身份验证
	$.ajax({
		type: "POST",
		url: sc.basePath + "servlet/LoginServlet",
		data: "userCode=" + userCode + "&password=" + password,
		async: true,
		success: function(data) {
			d.remove();
			if(data == null || data == "null") {
				//验证失败
				sc.alert("用户名或密码有误");
			} else {
				//选择记住密码时,为其创建cookie
				if($("#rememberMe").prop("checked") == true) {
					$.cookie("scUserCode", userCode, {expires:7});
					$.cookie("scPassword", password, {expires:7});
				} else {//删除cookie
					$.cookie("scUserCode", "", {expires: -1});
					$.cookie("scPassword", "", {expires: -1});
				}
				//提交表单的操作
				window.location = sc.basePath + "sc/sys/Index.jsp";
			}
		},
		error: function(data) {
			d.remove();
			/*
			sc.alert("<h2>服务器错误。</h2><br/>" 
					+ "<a href='#'>通知管理员</a>&nbsp;&nbsp;<a href='#'>刷新重试</a><br/>" 
					+ data.responseText);
			*/
			sc.alert("服务器错误。");
		}
	});
};

/**
 * 企业注册
 */
var addSave = function() {
	sc.form.dlgSave(function() {
		scDlg.find("#orgid").val("69d7d7c4-634b-421a-9b41-fc0e317ee958");
		scDlg.find("#roleid").val("75a7ee97-481a-4499-8b42-80c8c807bd95");
		var Registerpass = $("#passwordShow").val();
		var passToMd5 = ServiceBreakSyn("com.sc.common.util.StrUtil","md5",[Registerpass]);
		scDlg.find("#password").val(passToMd5);
	},function() {
		sc.alert("注册成功");
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
			记住密码 
		</label><br /> 
		<div>
		<input type="button" id="loginBtn" onClick="loginClick()" />
		<input type="button" id="registerBtn" onClick="sc.form.add(addSave)" />
		</div>
	</div>
	<div class="footer">
		中国石化集团安全工程研究院 版权所有 电话：86-532-83786201 传真：86-532-83861318<br />
		技术支持：中国石化集团安全工程研究院信息中心<br />
	</div>
	
    <div class="scDlg">
    	<input type="hidden" id="scid" />
    	<input type="hidden" class="scSave" id="orgid" />
    	<input type="hidden" class="scSave" id="roleid"/>
    	<input type="hidden" class="scSave" id="password"/>
    	<table>
    		<tr>
    			<td>用户名：</td>
    			<td><input type="text" class="scSave" id="username" /></td>
    		</tr>
    		<tr>
    			<td>账号：</td>
    			<td><input type="text" class="scSave" id="usercode" /></td>
    		</tr>
    		<tr>
    			<td>密码：</td>
    			<td><input type="text" class="sc" id="passwordShow" /></td>
    		</tr>
    	</table>
    </div>
</body>
</html>
