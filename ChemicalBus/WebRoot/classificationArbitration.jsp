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
    <title>�����ٲ�</title>
<link rel="stylesheet" href="css/index.css" />  
<style type="text/css">
#container {margin: 0 auto; width:550px;}
input {
    border-top-width: 0px;
    border-right-width: 0px;
    border-bottom-width: 1px;
    border-left-width: 0px;
    border-top-style: dashed;
    border-right-style: dashed;
    /* border-bottom-style: dashed; */
    border-left-style: dashed;
    border-top-color: #000000;
    border-right-color: #000000;
    border-bottom-color: #000000;
    border-left-color: #000000;
}
</style>
<!-- <style type="text/css">
body {
	background: #fff;
	padding:10px 0;
	overflow: hidden;
}
.rpt {
	font-size: 14px;
	width:800px;
	margin:auto;
}
.bt {
	margin:20px;
}
input {
    border-top-width: 0px;
    border-right-width: 0px;
    border-bottom-width: 1px;
    border-left-width: 0px;
    border-top-style: solid;
    border-right-style: solid;
    border-bottom-style: solid;
    border-left-style: solid;
    border-top-color: #000000;
    border-right-color: #000000;
    border-bottom-color: #000000;
    border-left-color: #000000;
}	 -->

<script type="text/javascript">
	var scClassName = "com.sc.chemical.service.CategoryArbitralResultService";
	$(function() {
		var scid = sc.getUrlQuery("scid");
		if(scid) {
			//�޸�,����ҳ������
			loadPageData(scid);
			$("#scid").val(scid);
		} else {
			//����
		}
	});
	
	//�޸�
	var loadPageData = function(scid) {
		//�õ�����װ�����ֶ�
		var columnArr = new Array($(".scSave").length);
		for(var i = 0; i < $(".scSave").length; i++) {
			var columnName = $(".scSave").eq(i).attr("id");
			var columnValue = $(".scSave").eq(i).val();
			
			var column = {columnName: columnName, columnValue: columnValue};
			columnArr[i] = column;
		}
		var tableObj = {scid: scid, columns: columnArr};
		//��ȡ�������ݣ���Ϊ������ֵ
		ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
			if(data == null) return;
			for(var j = 0; j < data.columns.length; j++) {
				var column = data.columns[j];
				$("#" + column.columnName).val(column.columnValue);
			}
		});
	};
	//����
	var saveData = function() {
		var scid = $("#scid").val();
		var columnArr = new Array($(".scSave").length);
		for(var i = 0; i < $(".scSave").length; i++) {
			var columnName = $(".scSave").eq(i).attr("id");
			var columnValue = $(".scSave").eq(i).val();
			var column = {columnName: columnName, columnValue: columnValue};
			columnArr[i] = column;
		}
		var tableObj = {scid: scid, columns: columnArr};
		ServiceBreakSyn(scClassName, "saveFormData", [JSON.stringify(tableObj)]);
		
		window.location.href = sc.basePath + "chemical/type/typeResultList.jsp";
	};
	
	
	//��ť-��ӡ
	var printClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (ctrl == null) {
	        alert("null");
	   }
		//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
		var strWordPathFile = sc.basePath + "recourse/fj7.doc";
		//�������ݵ�JSON����
		var strPrintCommand = "[";
		var columnArr = new Array($(".scSave").length);
		for(var i = 0; i < $(".scSave").length; i++) {
			var columnName = $(".scSave").eq(i).attr("id");
			var columnValue = $(".scSave").eq(i).val();
			
			var column = ",[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
			if(i == 0) {
				column = "[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
			}
			strPrintCommand += column;
		}
		strPrintCommand += "]";//alert(strPrintCommand);
		ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
	};
	//��ť-����
	var downLoadClick = function() {debugger;
		var ctrl = document.getElementById('ctrl');
		if (ctrl == null) {
	        alert("null");
	    }
		//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
		var strWordPathFile = sc.basePath + "recourse/fj7.doc";
		//�������ݵ�JSON����
		strPrintCommand = "[";
		var columnArr = new Array($(".scSave").length);
		for(var i = 0; i < $(".scSave").length; i++) {
			var columnName = $(".scSave").eq(i).attr("id");
			var columnValue = $(".scSave").eq(i).val();
			
			var column = ",[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
			if(i == 0) {
				column = "[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
			}
			strPrintCommand += column;
		}
		strPrintCommand += "]";//alert(strPrintCommand);
	 	ctrl.ExportWord(strWordPathFile, strPrintCommand);
	};
</script>
<script type="text/javascript">
	function backForm(){
		window.location.href = sc.basePath + "index.jsp";
	};
</script>

  </head>
  
  <body>
	<%@ include file="/header.jsp"%>
	<div class="mainWidth content">
		<div id="container">
  		
	  	<div class="rpt" align="left">
	 		<p style='text-align:center'>
	 			<span style='font-size:18.0pt;font-family:����'>��ѧƷ����Σ���Է����ٲý��֪ͨ��</span>
	 		</p>
			<p style='text-align:right'>
				<span >��ί����[ </span>
				<input class="scSave ipt" type="text" name="acceptTime" id="acceptTime" style='width:30px' /> ]
				<input class="scSave ipt" type="text" name="acceptNumber" id="acceptNumber" style='width:30px'/>��
			<p>
			<p>
				<input class="scSave ipt" type="text" name="applicationEnterprise" id="applicationEnterprise"/>��
			</p>
			<p>
				<input class="scSave ipt" onclick="WdatePicker({firstDayOfWeek:1})" type="text" name="meetingTime" id="meetingTime">
				<span>����ѧƷ����Σ�ռ�������༼��ίԱ���ٿ����飬���㵥λ����Ļ�ѧƷ����Σ���Է����ٲ���������о����ٲý�����£�</span>
			</p>
			<p>
				<textarea class="scSave ipt" rows="3" cols="85" name="arbitralResult" id="arbitralResult"></textarea>
			</p>
			<p>
				<span>��������ٲõļ���ίԱ��ίԱ��</span>
			</p>
			<p>
				<textarea class="scSave ipt" rows="3" cols="85" name="participant" id="participant"></textarea>
			</p>
			<p>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ش�֪ͨ��</span>
			</p>
			<p>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				��ϵ�ˣ�<input class="scSave ipt" type="text" name="contactPerson" id="contactPerson"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				��ϵ�绰��<input class="scSave ipt" type="text" name="phone" id="phone"/>
			</p> 
			<br/>
			<p style='text-align:right'><span>����ѧƷ����Σ���Լ�������༼��ίԱ�ṫ�£�</span></p>
			<p style='text-align:right'>
				<input class="scSave ipt" onclick="WdatePicker({firstDayOfWeek:1})"  type="text" name="abstempelnTime" id="abstempelnTime"/>
			</p>
			<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
				CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
				codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT >  
				��ӡ�ؼ�����ʧ�� 
  			</OBJECT>
			<div align="center" class="bt">
				<input class="scBtn" type="button" value="����" onClick="backForm()" />
				<input class="scBtn" type="button" value="��ӡ" onClick="printClick()" />
				<input class="scBtn" type="button" value="����" onClick="downLoadClick()" />
			</div>
		</div>
	</div>
		<div class="scRight">213</div>
		<div class="scClear"></div>
    	
    </div>
	<%@ include file="/footer.jsp"%>
  </body>
</html>