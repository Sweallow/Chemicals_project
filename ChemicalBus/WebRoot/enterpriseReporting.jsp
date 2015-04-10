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
    <title>��ҵ������Ϣ</title>
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
	//��ҳ
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
	//ĩҳ
	var endPage = function() {
		if(curPage < maxPage) {
			curPage = maxPage;
		}
	};
	var loadPageData = function() {
		
	};
</script>    

<script type="text/javascript">
	var scClassName = "com.sc.chemical.service.ApplicationEnterpriseInfoService";//���뵥λ
	var clClassName = "com.sc.chemical.service.AppraisalInfoService";//��ѧ��Ʒ����
	$(function() {
		var scid = sc.getUrlQuery("scid");
		if(scid) {
			//�޸�,����ҳ������
			loadPageData(scid);
			$("#scid").val(scid);
			//ʧȥ����
			$("input").attr({onfocus:"this.blur()"});
			for(var i=0; i<$(".alType").length; i++){
				$(".alType").eq(i).attr({onclick:"return false"});
			}
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
		//��ȡ�������ݣ���Ϊ����ֵ
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
	//��ť-��ӡ
	var printClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (!ctrl) {
			sc.alert("��ӡʧ�ܣ������ԣ�");
	    }
		//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
		var strWordPathFile = sc.basePath + "recourse/fj1.doc";
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
		
		//��װ��������
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
			//����ÿһ������ΪappraisalType�ĸ�ѡ������ѡ�е�ִ�к���    
			var types = ["��","��","��"];
			rows.eq(i).find('input[name="appraisalType"]:checked').each(function(){
				//Ϊѡ�е�types��ֵ  ��
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
	
	//��ť-����
	var downLoadClick = function() {
		var ctrl = document.getElementById('ctrl');
		if (!ctrl) {
			sc.alert("����ʧ�ܣ������ԣ�");
	   }
		//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
		var strWordPathFile = sc.basePath + "recourse/fj1.doc";
		//�����ݵ�JSON����
		var strPrintCommand = "[";
		//��װ��������
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
		
		//��װ��������
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
			//����ÿһ������ΪappraisalType�ĸ�ѡ������ѡ�е�ִ�к���    
			var types = ["��","��","��"];
			rows.eq(i).find('input[name="appraisalType"]:checked').each(function(){
				//Ϊѡ�е�types��ֵ  ��
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
  	<div class="title1">��ҵ������Ϣ</div>
	<table class="tab" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td rowspan="26">���뵥<br/><br/>λ��Ϣ</td>
		</tr>
		<tr>
			<td colspan="2">��λ����</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="enterpriseName" id="enterpriseName" />
			</td>
		</tr>
		<tr>
			<td colspan="2">��ַ</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="adress" id="adress" />
			</td>
		</tr>
		<tr>
			<td colspan="2">�ʱ�</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="email" id="email" />
			</td>
		</tr>
		<tr>
			<td colspan="2">������</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="operator" id="operator"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">��ϵ�绰</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="phone" id="phone"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">��λ����</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="enterpriseAttribute" id="enterpriseAttribute"/>
			</td>
		</tr>
		<tr >
			<td width="30px" align="center">���</td>
			<td width="70px" align="center">��ѧƷ<br/>����</td>
			<td align="center">������������</td>
			<td width="120px" align="center">��������<br/>ǩ������</td>
			<td width="100px" align="center">��������</td>
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
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>�������</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>���ϼ���</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>ϵ�м���</label><br />
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
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>�������</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>���ϼ���</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>ϵ�м���</label><br />
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
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>�������</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>���ϼ���</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>ϵ�м���</label><br />
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
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>�������</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>���ϼ���</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>ϵ�м���</label><br />
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
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>�������</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>���ϼ���</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>ϵ�м���</label><br />
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
				<label><input class="alType" type="checkbox" name="appraisalType" value="0"/>�������</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="1"/>���ϼ���</label><br />
				<label><input class="alType" type="checkbox" name="appraisalType" value="2"/>ϵ�м���</label><br />
			</td>
		</tr>										
		<tr>
			<td colspan="2">��������</td>
			<td colspan="3"><input class="scSave ipt" type="text" name="appraisalNumber" id="appraisalNumber"/>
			</td>
		</tr>
	</table>
	<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
		CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
		codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
		��ӡ�ؼ�����ʧ�� 
	</OBJECT>
	<div align="center" class="bt">
		<input class="scBtn" type="button" value="����" onClick="backForm()" />
		<input class="scBtn" type="button" value="��ӡ" onClick="printClick()" />
		<input class="scBtn" type="button" value="����" onClick="downLoadClick()" /> 
	</div>

		</div>
		<div class="scRight">213</div>
		<div class="scClear"></div>
    	
    </div>
	<%@ include file="/footer.jsp"%>
  </body>
</html>
