<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<base href="<%=basePath%>">
<%@ include file="/sc/common.jsp"%>
<title>��ѧƷ����Σ���Լ����ٲý��֪ͨ��</title>
<style type="text/css">
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

p{
text-indent: 2em; /*em����Ե�λ��2em������һ���ִ�С������*/
 line-height:20px;
}
</style>
<script type="text/javascript">
	$(function(){
	 	top.sc.indexAutoHeight($(document).height());
	 });
 
	var returnToMain=function(){
		var rs = sc.getUrlQuery("rs");
		if(rs == "sh"){
			window.location.href=sc.basePath+"chemical/arbitrationApply/secretarySortShowList.jsp";
		}else{
			window.location.href=sc.basePath+"sc/chemical/physicalDangerR.jsp";
		}
	}
</script>

<script type="text/javascript">
	var scClassName = "chemical.service.ResultNoticeService";
	$(function() {
		top.sc.indexAutoHeight($(document).height());
		var appScid = sc.getUrlQuery("appScid");
		if(appScid){
			$("#appscid").val(appScid);
		}
		var scid = sc.getUrlQuery("scid");
		if(scid){
			//�޸�
			loadPageData(scid);
			$("#scid").val(scid);
		}else{
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
		//��ȡ�����ݣ���Ϊ����ֵ
		ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
			if(data == null) return;
			for(var j = 0; j < data.columns.length; j++) {
				var column = data.columns[j];
				$("#" + column.columnName).val(column.columnValue);
			}
		});
	}
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
		var rs = sc.getUrlQuery("rs");
		if(rs == "sh"){
			window.location.href=sc.basePath+"chemical/arbitrationApply/secretarySortShowList.jsp";
		}else{
			window.location.href=sc.basePath+"chemical/arbitrationApply/secretaryExamShowList.jsp";
		}
		//window.location.href = sc.basePath + "sc/chemical/physicalDangerR.jsp";
	}
	//��ť-��ӡ
	var printClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (ctrl == null) {
	        sc.alert("��ӡʧ�ܣ��������ԣ�");
	    }
		//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
		var strWordPathFile = sc.basePath + "recourse/fj5.doc";
		//�����ݵ�JSON����
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
	}
	//��ť-����
	var downLoadClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (ctrl == null) {
	        sc.alert("����ʧ�ܣ��������ԣ�");
	    }
		//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
		var strWordPathFile = sc.basePath + "recourse/fj5.doc";
		//�����ݵ�JSON����
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
	 	ctrl.ExportWord(strWordPathFile, strPrintCommand);
	}
</script>

</head>  
  <body>
		<input type="hidden" id="scid" />
		<input class="scSave ipt" type="hidden" id="appscid" />
       <div style="position: absolute;left: 200px;right: 350px">
       <h1 align="center">��ѧƷ����Σ���Լ����ٲý��֪ͨ��</h1>
		<p align="right"><!-- <font face="Arial" size="+1"> --><span>��ί����[<input class="scSave ipt" type="text" size="4" id="particularYear" name="particularYear" />]
	    <input class="scSave ipt"  type="text" size="4" id="auditNumber" name="auditNumber" />��</span></p>
		<!-- <font face="Arial" size="+1"> -->
			<input class="scSave ipt"  type="text" size="30" id="unitName" name="unitName" />��<br/>
			<p>  ��ѧƷ����Σ�ռ�������༼��ίԱ��ָ��
			<input class="scSave ipt"  type="text" size="30" id="identificationAgency" name="identificationAgency" />
			������������
			<input class="scSave ipt"  type="text" size="30" id="chemicalName" name="chemicalName" />
			���е�
			<input class="scSave ipt"  type="text" size="30" id="identificationProject" name="identificationProject" />
			����Σ�����ٲü�����������£�</p>	
			<br/><textarea class="scSave ipt" rows="6" cols="85" id="identificationResult" name="identificationResult"></textarea>		
			<p>��ѧƷ����Σ�ռ�������༼��ίԱ�����ݻ�ѧƷ����Σ���Լ�����ر�׼������
			<input class="scSave ipt"  type="text" size="30" id="originalAgency" name="originalAgency" />
			��ԭ�����������ƣ������ļ��������
			<input class="scSave ipt"  type="text" size="30" id="specifiedAgency" name="specifiedAgency" />
			��ָ�������������ƣ������ļ�����������ۺϷ������ٲý�����£�	</p>	
			<br/><textarea  class="scSave ipt" rows="6" cols="85" name="arbitrationResult" id="arbitrationResult"></textarea>	
			<br/>
			<p>��������ٲõļ���ίԱ��ίԱ��</p>
			<br/><textarea class="scSave ipt" rows="3" cols="85" name="committeeMember" id="committeeMember"></textarea>
	
		    <br/><p>�ش�֪ͨ��</p>
		<p>
			��ϵ��:<input class="scSave ipt"  type="text" size="20" id="people" name="people" />
			��ϵ�绰:<input class="scSave ipt"  type="text" size="20" id="telNumber" name="telNumber" />
		</p> 
		<br/>
		<p align="right">����ѧƷ����Σ���Լ�������༼��ίԱ�ṫ�£�</p>
		<p align="right"><input class="scSave ipt" type="text" id="sealDate"  onfocus="WdatePicker({firstDayOfWeek:1})" />
		<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
			CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
			codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
			��ӡ�ؼ�����ʧ�� 
  		</OBJECT>
		<div align="center" class="bt">	
				<input class="scBtn" type="button" value="����" onclick="saveData()" />
				<input class="scBtn" type="button" value="����" onclick="returnToMain()" />		 	
			 	<input class="scBtn" type="button" value="��ӡ" onclick="printClick()"  />
			 	<input class="scBtn" type="button" value="����" onclick="downLoadClick()"  />
	  	</div>
	</div>
	
  </body>
</html>