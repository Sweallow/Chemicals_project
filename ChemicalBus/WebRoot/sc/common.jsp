<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String _path = request.getContextPath();
String _basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+_path+"/";
%>
<link rel="stylesheet" href="sc/css/common.css" />
<link rel="stylesheet" href="sc/css/form.css" />

<script src="sc/res/artDialog-master/lib/jquery-1.10.2.js"></script>
<%--<script type="text/javascript" src="sc/res/jquery-1.5.2.js"></script>
--%><script type="text/javascript" src="sc/res/json2.js"></script>

<!-- easyui 列表 -->
<link rel="stylesheet" type="text/css" href="sc/res/jquery-easyui-1.3.5/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="sc/res/jquery-easyui-1.3.5/themes/icon.css" />
<script type="text/javascript" src="sc/res/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="sc/res/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js"></script>

<!-- artDialog 对话框 -->
<link rel="stylesheet" href="sc/res/artDialog-master/css/ui-dialog.css">
<script src="sc/res/artDialog-master/dist/dialog-min.js"></script>
<!-- 日期时间元件 -->
<script src="<%=_basePath %>sc/res/My97Date/WdatePicker.js"></script>
<%
//本机IP
String _ip = request.getHeader("x-forwarded-for");
if(_ip == null || _ip.length() == 0 || "unknown".equalsIgnoreCase(_ip)) {
	_ip = request.getHeader("Proxy-Client-IP");
}
if(_ip == null || _ip.length() == 0 || "unknown".equalsIgnoreCase(_ip)) {
	_ip = request.getHeader("WL-Proxy-Client-IP");
}
if(_ip == null || _ip.length() == 0 || "unknown".equalsIgnoreCase(_ip)) {
	_ip = request.getRemoteAddr();
}
 %>
<script type="text/javascript">
var sc = {};
sc.appName = "<%=_path%>".replace("/", "");
sc.basePath = "<%=_basePath%>";
sc.user = JSON.parse('<%=request.getSession().getAttribute("scuser")%>');
sc.localIp = "<%=_ip%>";

//跳转至登录界面
sc.logout = function() {
	window.location = sc.basePath + "sc/sys/Login.jsp";
}
</script>

<!-- 平台自有 -->
<%--<script src="sc/js/base64.js" type="text/javascript"></script>
--%><script type="text/javascript" src="sc/js/serviceBreak.js"></script>
<script type="text/javascript" src="sc/js/common.js"></script>
<script type="text/javascript" src="sc/js/form.js"></script>