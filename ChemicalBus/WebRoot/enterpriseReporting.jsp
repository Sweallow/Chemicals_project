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
    <title>企业基本信息</title>
<link rel="stylesheet" href="css/index.css" />    
<style type="text/css">
body {
	
	padding:10px 0;
	
}
.rpt {
	font-size: 14px;
	width:600px;
	margin:auto; 
}
.title1 {
	text-align:center;
	font-weight: bold;
	font-size: 16px;
	padding:10px 0;
}
.tab {
	width:100%;
	border:1px #ccc solid;
}
.tab td {
	border:1px #ccc solid;
	padding:5px;
}
.tab .ipt {
	outline:none;
	border:none;
	background: none;
	width:95%;
	height:23px;
}
.tab .highIpt {
	height: 55px;
}
.bt {
	margin:20px;
}
</style>
<script type="text/javascript">
	var curPage = 1;
	var pageSize = 10;
	var maxPage = 1;
	
	$(document).ready(function() {
		var type = sc.getUrlQuery("t");
		//alert(type);
	});	
	//首页
	var topPage = function() {
		if(curPage > 1) {
			curPage = 1;
		}
	};
	var upPage = function() {
		if(curPage > 1) {
			curPage -= 1;
		}
	};
	var downPage = function() {
		if(curPage < maxPage) {
			curPage += 1;
		}
	};
	//末页
	var endPage = function() {
		if(curPage < maxPage) {
			curPage = maxPage;
		}
	};
	var loadPageData = function() {
		
	};
</script>    

<script type="text/javascript">
	var scClassName = "com.sc.chemical.service.ApplicationEnterpriseInfoService";//申请单位
	var clClassName = "com.sc.chemical.service.AppraisalInfoService";//化学物品鉴定
	$(function() {
		var scid = sc.getUrlQuery("scid");
		if(scid) {
			//修改,加载页面数据
			loadPageData(scid);
			$("#scid").val(scid);
			//失去焦点
			$("input").attr({onfocus:"this.blur()"});
			for(var i=0; i<$(".alType").length; i++){
				$(".alType").eq(i).attr({onclick:"return false"});
			}
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
		//读取副表数据，并为副表赋值
		ServiceBreak(clClassName, "getAppraisalInfoDatas", [scid], function(data) {
			if(data == null) return;
			for(var j = 0; j < data.length; j++) {//debugger;
				var rows = $(".appraisalInfo");
				var appraisalInfo = data[j];
				var index = appraisalInfo.NUMB;
				rows.eq(j).find(".xuHao").val(index);
				//alert(rows.eq(j).find(".xuHao").val(index));
				var clName = appraisalInfo.CHEMICALNAME;
				rows.eq(j).find(".clName").val(clName);
				var orgName = appraisalInfo.APPRAISALORGANIZATIONNAME;
				rows.eq(j).find(".orgName").val(orgName);
				var rptDate = appraisalInfo.REPORTISSUEDDATE;
				rows.eq(j).find(".rptDate").val(rptDate);
				var alTypes = appraisalInfo.APPRAISALTYPE;	
				if(alTypes.indexOf("0") > -1) {
				 rows.eq(j).find('input[name="appraisalType"]').eq(0).attr('checked', true);
				}
				if(alTypes.indexOf("1") > -1) {
				 rows.eq(j).find('input[name="appraisalType"]').eq(1).attr('checked', true);
				}
				if(alTypes.indexOf("2") > -1) {
				 rows.eq(j).find('input[name="appraisalType"]').eq(2).attr('checked', true);
				}
			}

		});
	};
	//按钮-打印
	var printClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (!ctrl) {
			sc.alert("打印失败，请重试！");
	    }
		//word文件的全路径，只支持.doc文件。不支持.docx文件
		var strWordPathFile = sc.basePath + "recourse/fj1.doc";
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
		
		//封装副表内容
		var rows = $(".appraisalInfo");
		var index = "";
		var clName = "";
		var orgName = "";
		var rptDate = "";
		for(var i = 0; i < rows.length; i++) {
			var alTypes = "";
			var  data = "";
			index = rows.eq(i).find(".xuHao").val();
			clName = rows.eq(i).find(".clName").val();
			orgName = rows.eq(i).find(".orgName").val();
			rptDate = rows.eq(i).find(".rptDate").val();
			//遍历每一个名字为appraisalType的复选框，其中选中的执行函数    
			var types = ["□","□","□"];
			rows.eq(i).find('input[name="appraisalType"]:checked').each(function(){
				//为选中的types赋值  √
				types[$(this).val()] = "{@}";
	        });
			index = ",[\"1\",\"[numb" + i +  "]\",\"" + index + "\"]";
			data += index;
			clName = ",[\"1\",\"[chemicalName" + i + "]\",\"" + clName + "\"]";
			data += clName;
			orgName = ",[\"1\",\"[appraisalOrganizationName" + i + "]\",\"" + orgName + "\"]";
			data += orgName;
			rptDate = ",[\"1\",\"[reportIssuedDate" + i + "]\",\"" + rptDate + "\"]";
			data += rptDate;
			//alTypes = ",[\"1\",\"[appraisalType" + i + "]\",\"" + alTypes.substring(1) + "\"]";
	        for(var j = 0; j < 3; j++){
	        	alTypes += ",[\"1\",\"[" + i + "-" + j + "]\",\"" + types[j] + "\"]";
		    }
			data += alTypes;
			strPrintCommand += data;
		}
		strPrintCommand += "]";
		ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
	};
	
	//按钮-下载
	var downLoadClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (!ctrl) {
			sc.alert("下载失败，请重试！");
	   }
		//word文件的全路径，只支持.doc文件。不支持.docx文件
		var strWordPathFile = sc.basePath + "recourse/fj1.doc";
		//表单内容的JSON数组
		var strPrintCommand = "[";
		//封装主表数据
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
		
		//封装副表数据
		var rows = $(".appraisalInfo");
		var index = "";
		var clName = "";
		var orgName = "";
		var rptDate = "";
		for(var i = 0; i < rows.length; i++) {
			var alTypes = "";
			var  data = "";
			index = rows.eq(i).find(".xuHao").val();
			clName = rows.eq(i).find(".clName").val();
			orgName = rows.eq(i).find(".orgName").val();
			rptDate = rows.eq(i).find(".rptDate").val();
			//遍历每一个名字为appraisalType的复选框，其中选中的执行函数    
			var types = ["□","□","□"];
			rows.eq(i).find('input[name="appraisalType"]:checked').each(function(){
				//为选中的types赋值  √
				types[$(this).val()] = "{@}";
				//alTypes += "," + $(this).val(); 
	        });
			index = ",[\"1\",\"[numb" + i +  "]\",\"" + index + "\"]";
			data += index;
			clName = ",[\"1\",\"[chemicalName" + i + "]\",\"" + clName + "\"]";
			data += clName;
			orgName = ",[\"1\",\"[appraisalOrganizationName" + i + "]\",\"" + orgName + "\"]";
			data += orgName;
			rptDate = ",[\"1\",\"[reportIssuedDate" + i + "]\",\"" + rptDate + "\"]";
			data += rptDate;
			for(var k = 0;k < 3; k++){
				alTypes += ",[\"1\",\"[" + i + "-" + k + "]\",\"" + types[k] + "\"]";
       			//alTypes += ",[\"1\",\"[appraisalType" + k + "]\",\"" + types[k] + "\"]";
			}
			//alTypes = ",[\"1\",\"[appraisalType" + i + "]\",\"" + alTypes.substring(1) + "\"]";
			data += alTypes;
			strPrintCommand += data;
		}
		strPrintCommand += "]";
		//alert(strPrintCommand);
		ctrl.ExportWord(strWordPathFile, strPrintCommand);
	};
	
	function backForm(){
		window.location.href = sc.basePath + "index.jsp";}
</script>
  </head>
  
  <body>
	<%@ include file="/header.jsp"%>
	<div class="mainWidth content">
	
		<input type="hidden" id="scid" />
		<input class="scSave ipt"  type="hidden" id="userName"  name="userName" value="" />
		<input class="scSave ipt" type="hidden" id="scStatus" name="scStatus"  value=""/>

<div class="rpt">
  	<div class="title1">企业基本信息</div>
	<table class="tab" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td rowspan="26">申请单<br/><br/>位信息</td>
		</tr>
		<tr>
			<td colspan="2">单位名称</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="enterpriseName" id="enterpriseName" />
			</td>
		</tr>
		<tr>
			<td colspan="2">地址</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="adress" id="adress" />
			</td>
		</tr>
		<tr>
			<td colspan="2">邮编</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="email" id="email" />
			</td>
		</tr>
		<tr>
			<td colspan="2">经办人</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="operator" id="operator"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">联系电话</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="phone" id="phone"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">单位属性</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="enterpriseAttribute" id="enterpriseAttribute"/>
			</td>
		</tr>
		<tr >
			<td width="30px" align="center">序号</td>
			<td width="70px" align="center">化学品<br/>名称</td>
			<td align="center">鉴定机构名称</td>
			<td width="120px" align="center">鉴定报告<br/>签发日期</td>
			<td width="100px" align="center">鉴定类型</td>
		</tr>
		<tr class="appraisalInfo">
			<td><input class=" xuHao ipt highIpt" type="text" name="numb" />
			</td>
			<td><input class=" clName ipt highIpt" type="text" name="chemicalName" />
			</td>
			<td><input class=" orgName ipt highIpt" type="text" name="appraisalOrganizationName" />
			</td>
			<td><input class=" rptDate ipt highIpt" type="text" name="reportIssuedDate" />
			</td>
			<td class=" alTypes">
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>常规鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>联合鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>系列鉴定</label><br />
			</td>
		</tr>
		<tr class="appraisalInfo">
			<td><input class=" xuHao ipt highIpt" type="text" name="numb"/>
			</td>
			<td><input class=" clName ipt highIpt" type="text" name="chemicalName"/>
			</td>
			<td><input class=" orgName ipt highIpt" type="text" name="appraisalOrganizationName"/>
			</td>
			<td><input class=" rptDate ipt highIpt" type="text" name="reportIssuedDate"/>
			</td>
			<td class=" alTypes">
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>常规鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>联合鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>系列鉴定</label><br />
			</td>
		</tr>
		<tr class="appraisalInfo">
			<td><input class=" xuHao ipt highIpt" type="text" name="numb"/>
			</td>
			<td><input class=" clName ipt highIpt" type="text" name="chemicalName"/>
			</td>
			<td><input class=" orgName ipt highIpt" type="text" name="appraisalOrganizationName"/>
			</td>
			<td><input class=" rptDate ipt highIpt" type="text" name="reportIssuedDate"/>
			</td>
			<td class=" alTypes">
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>常规鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>联合鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>系列鉴定</label><br />
			</td>
		</tr>
		<tr class="appraisalInfo">
			<td><input class=" xuHao ipt highIpt" type="text" name="numb"/>
			</td>
			<td><input class=" clName ipt highIpt" type="text" name="chemicalName"/>
			</td>
			<td><input class=" orgName ipt highIpt" type="text" name="appraisalOrganizationName"/>
			</td>
			<td><input class=" rptDate ipt highIpt" type="text" name="reportIssuedDate"/>
			</td>
			<td class=" alTypes">
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>常规鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>联合鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>系列鉴定</label><br />
			</td>
		</tr>
		<tr class="appraisalInfo">
			<td><input class=" xuHao ipt highIpt" type="text" name="numb"/>
			</td>
			<td><input class=" clName ipt highIpt" type="text" name="chemicalName"/>
			</td>
			<td><input class=" orgName ipt highIpt" type="text" name="appraisalOrganizationName"/>
			</td>
			<td><input class=" rptDate ipt highIpt" type="text" name="reportIssuedDate"/>
			</td>
			<td class=" alTypes">
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>常规鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>联合鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>系列鉴定</label><br />
			</td>
		</tr>
		<tr class="appraisalInfo">
			<td><input class=" xuHao ipt highIpt" type="text" name="numb"/>
			</td>
			<td><input class=" clName ipt highIpt" type="text" name="chemicalName"/>
			</td>
			<td><input class=" orgName ipt highIpt" type="text" name="appraisalOrganizationName"/>
			</td>
			<td><input class=" rptDate ipt highIpt" type="text" name="reportIssuedDate"/>
			</td>
			<td class=" alTypes">
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>常规鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>联合鉴定</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>系列鉴定</label><br />
			</td>
		</tr>										
		<tr>
			<td colspan="2">鉴定个数</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="appraisalNumber" id="appraisalNumber"/>
			</td>
		</tr>
	</table>
	<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
		CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
		codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
		打印控件加载失败 
	</OBJECT>
	<div align="center" class="bt">
		<input class="scBtn" type="button" value="返回" onClick="backForm()" />
		<input class="scBtn" type="button" value="打印" onClick="printClick()" />
		<input class="scBtn" type="button" value="下载" onClick="downLoadClick()" /> 
	</div>

		</div>
		<div class="scRight">213</div>
		<div class="scClear"></div>
    	
    </div>
	<%@ include file="/footer.jsp"%>
  </body>
</html>
