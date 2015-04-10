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
    <title>化学品物理危险性分类仲裁结果通知书</title>
	<style type="text/css">
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
		}	
	</style>
	<script type="text/javascript">
		var scClassName = "com.sc.chemical.service.CategoryArbitralResultService";
		$(function() {
			top.sc.indexAutoHeight($(document).height());
			var scid = sc.getUrlQuery("scid");
			var appId=sc.getUrlQuery("appscid");
			if(scid) {
				//修改,加载页面数据
				loadPageData(scid);
				$("#scid").val(scid);
			} else {
				//新增
				$("#appId").val(appId);	
			}
		});	
	
		//返回
		var backForm=function(){
			var rs = sc.getUrlQuery("rs");
			if(rs == "sh"){
				window.location.href=sc.basePath+"sc/chemical/auditedSuccessList.jsp";
			}else{
				window.location.href = sc.basePath + "chemical/type/typeResultList.jsp";
			}
		};
	
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
				if(!data) return;
				for(var j = 0; j < data.columns.length; j++) {
					var column = data.columns[j];
					$("#" + column.columnName).val(column.columnValue);
				}
			});
		};
	
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
			window.location.href = sc.basePath + "chemical/type/typeResultList.jsp";
		};
	
		//按钮-打印
		var printClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
				sc.alert("打印失败，请重试！");
		    }
			//word文件的全路径，只支持.doc文件。不支持.docx文件
			var strWordPathFile = sc.basePath + "recourse/fj7.doc";
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
			strPrintCommand += "]";
			ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
		};
	
		//按钮-下载
		var downLoadClick = function() {
			//debugger;
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
				sc.alert("下载失败，请重试！");
		    }
			//word文件的全路径，只支持.doc文件。不支持.docx文件
			var strWordPathFile = sc.basePath + "recourse/fj7.doc";
			//表单内容的JSON数组
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
			strPrintCommand += "]";
			//alert(strPrintCommand);
		 	ctrl.ExportWord(strWordPathFile, strPrintCommand);
		};
	</script>
  </head>
  <body>
  	<div align="center">
  		<input type="hidden" id="scid" />
  		<input class="scSave ipt" type="hidden" id="appId" />
	  	<div class="rpt" align="left">
	 		<p style='text-align:center'>
	 			<span style='font-size:18.0pt;font-family:黑体'>化学品物理危险性分类仲裁结果通知书</span>
	 		</p>
			<p style='text-align:right'>
				<span >技委鉴仲[ </span>
				<input class="scSave ipt" type="text" name="acceptTime" id="acceptTime" style='width:30px' /> ]
				<input class="scSave ipt" type="text" name="acceptNumber" id="acceptNumber" style='width:30px'/>号
			<p>
			<p>
				<input class="scSave ipt" type="text" name="applicationEnterprise" id="applicationEnterprise"/>：
			</p>
			<p>
				<input class="scSave ipt" onclick="WdatePicker()" type="text" name="meetingTime" id="meetingTime">
				<span>，化学品物理危险鉴定与分类技术委员会召开会议，对你单位提出的化学品物理危险性分类仲裁申请进行研究，仲裁结果如下：</span>
			</p>
			<p>
				<textarea class="scSave ipt" rows="3" cols="110" name="arbitralResult" id="arbitralResult"></textarea>
			</p>
			<p>
				<span>参与分类仲裁的技术委员会委员：</span>
			</p>
			<p>
				<textarea class="scSave ipt" rows="3" cols="110" name="participant" id="participant"></textarea>
			</p>
			<p>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;特此通知。</span>
			</p>
			<p>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				联系人：<input class="scSave ipt" type="text" name="contactPerson" id="contactPerson"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				联系电话：<input class="scSave ipt" type="text" name="phone" id="phone"/>
			</p> 
			<br/>
			<p style='text-align:right'><span>（化学品物理危险性鉴定与分类技术委员会公章）</span></p>
			<p style='text-align:right'>
				<input class="scSave ipt" onclick="WdatePicker()" type="text" name="abstempelnTime" id="abstempelnTime"/>
			</p>
			
			<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
				CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
				codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT >  
				打印控件加载失败 
  			</OBJECT>
  			
			<div align="center" class="bt">
				<input class="scBtn" type="button" value="保存" onClick="saveData()" />
				<input class="scBtn" type="button" value="返回" onClick="backForm()" />
				<input class="scBtn" type="button" value="打印" onClick="printClick()" />
				<input class="scBtn" type="button" value="下载" onClick="downLoadClick()" />
			</div>
		</div>
	</div>
  </body>
</html>
