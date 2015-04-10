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
    <title>化学品物理危险性鉴定与分类信息管理系统-首页</title>
<style type="text/css">
html, body {
	background: url(sc/img/bg.png);
}
.header {
	height:100px;
	/*background:#fff url(sc/img/headerRight.png) right top no-repeat;*/
}
.logo {
	margin-left:30px;
	height:100px;
	font-family:'黑体';
	font-weight:bold;
	width:677px;
	background: url(sc/img/logo.png) center no-repeat;
}
.header .rightBg {
	/*background:url(sc/img/headerRight.png) right top no-repeat;*/
	width:350px;
	height:95px;
	text-align: right;
	margin-top:20px;
	padding:5px 10px 0 0;
}
.header .rightBg a {
	color: #444;
	text-decoration: none;
	margin-right:10px
}
.header .rightBg img {
	border:0;
}
#userInfo {
	margin-top:50px;
	background: url(sc/img/userIcon3.png) center left no-repeat;
	padding-left:20px;
	margin-right:10px;
	font-weight: bold;
}
.navStart {
	width:120px;
	height: 45px;
	background:url(sc/img/navStart.jpg);
}
.navEnd {
	height: 45px;
	background:url(sc/img/navEnd.png) top right no-repeat;
}

.content {
	margin-top:10px;
	min-height:450px;
}

.menus {
	width:213px;
	height:428px;
	padding-left: 10px;
	color:#fff;
}
.menus .title {
	background:url(sc/img/new/userInfoBg.jpg);
	height:54px;
	padding-right:10px;
	font-size:13px;
	font-weight:bold;
	line-height:54px;
	margin-bottom: 20px;
	text-align: right;
}
.menus .topMenu {
	line-height: 54px;
	padding-right:10px;
	text-align:right;
	cursor: pointer;
	font-size: 13px;
	background:url(sc/img/new/menuBg.jpg);
	margin-top: 10px;
	font-weight: bold;
}
.menus .subMenus .subMenu{
	line-height: 26px;
	margin-top: 8px;
	background:rgb(50,126,176);
	cursor: pointer;
	margin-left:5px;
	text-align:right;
	padding-right:10px;
}
.menus .subMenus{
	display:none;
	font-size: 13px;
	padding-right:10px;
	
}
/*
.menus .topMenu:hover {
	font-weight: bold;
}*/

.main {
	width:500px;
	height:440px;
}

.footer {
	margin-top:20px;
	background:#EAEAEA;
	text-align:center;
	color:#4C566F;
	line-height:25px;
	padding:10px 0;
	display: none;
}

</style>
<script type="text/javascript">
$(document).ready(function(e) {
    initPage();//页面初始化
});

//页面初始化
var initPage = function() {
	var menusW = $(".menus").width();
	var contentW = $(".content").width();
	$(".main").width(contentW - menusW - 40);
	
	initMenu();//初始化顶部菜单
	initToggle();
}
/**
 * 初始化菜单HTML
 */
var initMenu = function(){
	//初始化title
	var title = $(".title")[0];
	title.textContent = sc.user.username;
	var data = ServiceBreakSyn("com.sc.sys.service.MenuService", "getTopMenu", ["scUser"]);
		if(data && data.length > 0) {
			var menuHtml = "";
			var subMenuHtml = "";
			for(var i = 0; i < data.length; i++){
				var obj = data[i];
				//拼接topMenu
				menuHtml +="<div class='menuItem'>"
				menuHtml += "<div class='topMenu' onclick='toggleMenu()'>"+obj.menuName+"</div>";
				menuHtml +="<div class='subMenus'>";
				subMenuHtml="";
				//拼接subMenu
				var subData = ServiceBreakSyn("com.sc.sys.service.MenuService", "getChildMenu", [obj.scid, "scUser"]);
				if(subData && subData.length > 0){
					for(var j = 0;j < subData.length; j++){
						subMenuHtml += "<div class=\"subMenu\" onclick=\"subMenuClick('" + subData[j].url 
									+ "')\"> " + subData[j].menuName + "</div>";
					}
					menuHtml+= subMenuHtml;
				}
				menuHtml+="</div></div>";
			}
		}
	$("#subMenu").html(menuHtml);
}
/**
 * 菜单点击折叠事件
 */
var initToggle = function() {
	$(".topMenu").click(function(e) {
        $(this).next(".subMenus").slideToggle();
    });
}
/**
 * 子菜单点击
 */
var subMenuClick = function(url) {
	$(".content .main").attr("src", url);
}
//自动高度
sc.indexAutoHeight = function(height) {
	if(!height) {
		height = 510;
	}
	$(".content .main").height(height);
}

/**
 * 退出登录
 */
var logout = function() {
	window.location = sc.basePath + "/servlet/LogoutServlet";
}
/**
 * 修改密码
 */
var changePassword = function() {
	$("#changePwdDlg").show();
	var d = dialog({
		lock:true,
	    title: '修改密码',
	    content: changePwdDlg,
	    okValue: "确定",
	    ok: function() {
			return changePwd();
	    },
	    cancelValue: "取消",
		cancel: function () {} 
	});
	d.showModal();
}
/**
 * 修改密码
 */
var changePwd = function() {
	var pwd = $("#oldPwd").val();
	var newPwd = $("#newPwd").val();
	var confirmPwd = $("#confirmPwd").val();
	if(pwd == null || pwd == "") {
		sc.alert("原密码不能为空");
		return false;
	}
	if(newPwd == null || newPwd == "") {
		sc.alert("新密码不能为空");
		return false;
	}
	if(confirmPwd == null || confirmPwd == "") {
		sc.alert("确认密码不能为空");
		return false;
	}
	if(confirmPwd != newPwd) {
		sc.alert("新密码和确认密码不相同");
		return false;
	}
	if(newPwd == pwd) {
		sc.alert("原密码和新密码相同");
		return false;
	}
	var res = ServiceBreakSyn("com.sc.sys.service.UserService", "pwdChange", 
			["scUser", pwd, newPwd]);
	if(res) {
		sc.alert(res);
		return true;
	}
}
</script>
</head>

<body>
    <div class="header">
    	<div class="scLeft logo" title="化学品物理危险性鉴定与分类信息管理系统"></div>
    	<div class="scRight rightBg">
    		<div style="height:30px">
    			<a href="javascript:sc.setFrontPage()">
    				<img src="sc/img/setFront-icon.png"/>
    			</a>
    			<a href="javascript:sc.collectPage()">
    				<img src="sc/img/collect-icon.png"/>
    			</a>
    			<a href="javascript:logout()">
    				<img src="sc/img/logout-icon.png"/>
    			</a>
    			<a href="javascript:changePassword()">
    				<img src="sc/img/changePassword-icon.png"/>
    			</a>
    		</div>
    	</div>
        <div class="scClear"></div>
    </div>
    <div class="navBar">
    	<table cellpadding="0" cellspacing="0" border="0" width="100%">
        	<tr>
            	<%--<td class="nav">首 页</td><td class="split"></td>
            	<td class="nav">企业基本信息</td><td class="split"></td>
                <td class="nav">分类报告</td><td class="split"></td>
                <td class="nav">鉴定仲裁</td><td class="split"></td>
                <td class="nav">分类仲裁</td><td class="split"></td>
                <td class="nav">系统管理</td><td class="split"></td>
            --%></tr>
        </table>
    </div>
	<div class="content">
    	<div class="scLeft menus">
        	<div class="title">管理员</div>
            <div id="subMenu">
            	
            </div>
        </div>
        <iframe class="scRight main" src="chemical/company/enterpriseInfoList.jsp" frameborder="0" scoll="none"></iframe>
        <div class="scClear"></div>
    </div>
	<div class="footer">
    	中国石化集团安全工程研究院 版权所有 电话：86-532-83786201 传真：86-532-83861318<br/>
		技术支持：中国石化集团安全工程研究院信息中心<br/>
    </div>
    
    <div class="scDlg" id="changePwdDlg">
    	<table>
    		<tr>
    			<td>原密码：</td>
    			<td><input id="oldPwd" type="password" /></td>
    		</tr>
    		<tr>
    			<td>新密码：</td>
    			<td><input id="newPwd" type="password" /></td>
    		</tr>
    		<tr>
    			<td>确认密码：</td>
    			<td><input id="confirmPwd" type="password" /></td>
    		</tr>
    	</table>
    	
    </div>
</body>
</html>

