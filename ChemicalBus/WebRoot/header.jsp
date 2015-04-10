<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<script type="text/javascript">
var gotoTop = function() {
	window.location = sc.basePath + "index.jsp";
}
var gotoBackPage = function() {
	window.open(sc.basePath + "sc/sys/Index.jsp");
}
//更多
var gotyType = function(type) {
	window.location = sc.basePath + "type.jsp?t=" + type;
}

</script>
<div class="header">
    	<div class="mainWidth">
            <div class="scLeft logo" title="化学品物理危险性鉴定与分类信息管理系统"></div>
            <div class="scRight rightBg">
	            <a href="javascript:sc.setFrontPage()">设为首页</a>
	    		|
	    		<a href="javascript:sc.collectPage()">收藏本站</a>
	    		|
	    		<a href="javascript:gotoBackPage()">系统登录</a>
	    	</div>
            <div class="scClear"></div>
        </div>
    </div>
    <div class="navBar">
    	<div class="mainWidth">
	    	<table cellpadding="0" cellspacing="0" border="0"  width="100%">
	        	<tr>
	            	<td class="split"></td><td class="nav" onclick="gotoTop()">首 页</td><td class="split"></td>
	            	<td class="nav" onclick="gotyType('jbxx')">企业基本信息</td><td class="split"></td>
	                <td class="nav" onclick="gotyType('flbg')">分类报告</td><td class="split"></td>
	                <td class="nav" onclick="gotyType('jdzc')">鉴定仲裁</td><td class="split"></td>
	                <td class="nav" onclick="gotyType('flzc')">分类仲裁</td><td class="split"></td>
	            </tr>
	        </table>
        </div>
    </div>
