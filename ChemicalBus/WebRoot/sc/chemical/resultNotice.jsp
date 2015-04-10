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
<title>化学品物理危险性鉴定仲裁结果通知书</title>
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
text-indent: 2em; /*em是相对单位，2em即现在一个字大小的两倍*/
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
			//修改
			loadPageData(scid);
			$("#scid").val(scid);
		}else{
			//新增
			
		} 
	});

	//修改
	var loadPageData = function(scid) {
		//得到并封装数据字段
		var columnArr = new Array($(".scSave").length);
		for(var i = 0; i < $(".scSave").length; i++) {
			var columnName = $(".scSave").eq(i).attr("id");
			var columnValue = $(".scSave").eq(i).val();
			var column = {columnName: columnName, columnValue: columnValue};
			columnArr[i] = column;
		}
		var tableObj = {scid: scid, columns: columnArr};
		//读取表单数据，并为表单赋值
		ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
			if(data == null) return;
			for(var j = 0; j < data.columns.length; j++) {
				var column = data.columns[j];
				$("#" + column.columnName).val(column.columnValue);
			}
		});
	}
	//保存
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
	//按钮-打印
	var printClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (ctrl == null) {
	        sc.alert("打印失败，请您重试！");
	    }
		//word文件的全路径，只支持.doc文件。不支持.docx文件
		var strWordPathFile = sc.basePath + "recourse/fj5.doc";
		//表单内容的JSON数组
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
	//按钮-下载
	var downLoadClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (ctrl == null) {
	        sc.alert("下载失败，请您重试！");
	    }
		//word文件的全路径，只支持.doc文件。不支持.docx文件
		var strWordPathFile = sc.basePath + "recourse/fj5.doc";
		//表单内容的JSON数组
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
       <h1 align="center">化学品物理危险性鉴定仲裁结果通知书</h1>
		<p align="right"><!-- <font face="Arial" size="+1"> --><span>技委鉴仲[<input class="scSave ipt" type="text" size="4" id="particularYear" name="particularYear" />]
	    <input class="scSave ipt"  type="text" size="4" id="auditNumber" name="auditNumber" />号</span></p>
		<!-- <font face="Arial" size="+1"> -->
			<input class="scSave ipt"  type="text" size="30" id="unitName" name="unitName" />：<br/>
			<p>  化学品物理危险鉴定与分类技术委员会指定
			<input class="scSave ipt"  type="text" size="30" id="identificationAgency" name="identificationAgency" />
			鉴定机构，对
			<input class="scSave ipt"  type="text" size="30" id="chemicalName" name="chemicalName" />
			进行的
			<input class="scSave ipt"  type="text" size="30" id="identificationProject" name="identificationProject" />
			物理危险性仲裁鉴定，结果如下：</p>	
			<br/><textarea class="scSave ipt" rows="6" cols="85" id="identificationResult" name="identificationResult"></textarea>		
			<p>化学品物理危险鉴定与分类技术委员会依据化学品物理危险性鉴定相关标准，经对
			<input class="scSave ipt"  type="text" size="30" id="originalAgency" name="originalAgency" />
			（原鉴定机构名称）给出的鉴定结果和
			<input class="scSave ipt"  type="text" size="30" id="specifiedAgency" name="specifiedAgency" />
			（指定鉴定机构名称）给出的鉴定结果进行综合分析，仲裁结果如下：	</p>	
			<br/><textarea  class="scSave ipt" rows="6" cols="85" name="arbitrationResult" id="arbitrationResult"></textarea>	
			<br/>
			<p>参与分类仲裁的技术委员会委员：</p>
			<br/><textarea class="scSave ipt" rows="3" cols="85" name="committeeMember" id="committeeMember"></textarea>
	
		    <br/><p>特此通知。</p>
		<p>
			联系人:<input class="scSave ipt"  type="text" size="20" id="people" name="people" />
			联系电话:<input class="scSave ipt"  type="text" size="20" id="telNumber" name="telNumber" />
		</p> 
		<br/>
		<p align="right">（化学品物理危险性鉴定与分类技术委员会公章）</p>
		<p align="right"><input class="scSave ipt" type="text" id="sealDate"  onfocus="WdatePicker({firstDayOfWeek:1})" />
		<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
			CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
			codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
			打印控件加载失败 
  		</OBJECT>
		<div align="center" class="bt">	
				<input class="scBtn" type="button" value="保存" onclick="saveData()" />
				<input class="scBtn" type="button" value="返回" onclick="returnToMain()" />		 	
			 	<input class="scBtn" type="button" value="打印" onclick="printClick()"  />
			 	<input class="scBtn" type="button" value="下载" onclick="downLoadClick()"  />
	  	</div>
	</div>
	
  </body>
</html>