<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<script type="text/javascript">
var gotoTop = function() {
	window.location = sc.basePath + "index.jsp";
}
var gotoBackPage = function() {
	window.open(sc.basePath + "sc/sys/Index.jsp");
}
//����
var gotyType = function(type) {
	window.location = sc.basePath + "type.jsp?t=" + type;
}

</script>
<div class="header">
    	<div class="mainWidth">
            <div class="scLeft logo" title="��ѧƷ����Σ���Լ����������Ϣ����ϵͳ"></div>
            <div class="scRight rightBg">
	            <a href="javascript:sc.setFrontPage()">��Ϊ��ҳ</a>
	    		|
	    		<a href="javascript:sc.collectPage()">�ղر�վ</a>
	    		|
	    		<a href="javascript:gotoBackPage()">ϵͳ��¼</a>
	    	</div>
            <div class="scClear"></div>
        </div>
    </div>
    <div class="navBar">
    	<div class="mainWidth">
	    	<table cellpadding="0" cellspacing="0" border="0"  width="100%">
	        	<tr>
	            	<td class="split"></td><td class="nav" onclick="gotoTop()">�� ҳ</td><td class="split"></td>
	            	<td class="nav" onclick="gotyType('jbxx')">��ҵ������Ϣ</td><td class="split"></td>
	                <td class="nav" onclick="gotyType('flbg')">���౨��</td><td class="split"></td>
	                <td class="nav" onclick="gotyType('jdzc')">�����ٲ�</td><td class="split"></td>
	                <td class="nav" onclick="gotyType('flzc')">�����ٲ�</td><td class="split"></td>
	            </tr>
	        </table>
        </div>
    </div>
