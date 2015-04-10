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
	<title>化学品物理危险性分类仲裁申请表</title>
	<style type="text/css">
		input {
			border-top-width: 0px;
			border-right-width: 0px;
			border-bottom-width: 1px;
			border-left-width: 0px;
			border-top-style: dashed;
			border-right-style: dashed;
			border-left-style: dashed;
			border-top-color: #000000;
			border-right-color: #000000;
			border-bottom-color: #000000;
			border-left-color: #000000;
		}
		p {
			text-indent: 2em;
		 	line-height:20px;
		}
	</style>
	<script type="text/javascript">
		var scClassName = "chemical.service.ChemicalApplicationService";
		
		$(function() {
			top.sc.indexAutoHeight($(document).height());
			var scid = sc.getUrlQuery("scid");		
			if(scid) {
				//修改,加载页面数据
				loadPageData(scid);
				$("#scid").val(scid);
				$("#rsn").attr({style:"display:none"});
				$("#theReason").attr({style:"display:none"});
				$("#acceptanceDate").attr({onclick:"''"});
				$("#fillDate").attr({onclick:"''"});
				$("#arbitrationTime").attr({onclick:"''"});
				$("#noticeDate").attr({onclick:"''"});
				$("#sealDate").attr({onclick:"''"});
			} else {
				$("#userCode").val(sc.user.scid);
			}
		});
		
		//返回
		var returnToMain = function() {
			var scStatus = sc.getUrlQuery("scStatus");
			if(scStatus == "0"){
	   			window.location.href= sc.basePath+ "sc/chemical/arbitrationAudit.jsp";
	   		} else if(scStatus == "1") {
	   			window.location.href= sc.basePath+ "sc/chemical/auditedSuccessList.jsp";
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
				if($("#scStatus").val() == "1"){
					//设置一般input输入框及文本编辑框失去焦点
					$("input").attr({onfocus:"this.blur()"});
					$("textarea").attr({onfocus:"this.blur()"});
					$("#saveBtn").attr({style:"display:none"});
				}
				if($("#scStatus").val() != "-1"){
					$("#rsn").attr({style:"display:none"});
					$("#theReason").attr({style:"display:none"});
				}
			});
		};

		//按钮-打印
		var printClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("打印失败，请您重试！");
		    }
			//word文件的全路径，只支持.doc文件。不支持.docx文件
			strWordPathFile = sc.basePath + "recourse/fj6.doc";
			//表单内容的JSON数组
			strPrintCommand = "[";
			var columnArr = new Array($(".scSave").length);
			for(var i = 0; i < $(".scSave").length; i++) {
				var columnName = $(".scSave").eq(i).attr("id");
				var columnValue = $(".scSave").eq(i).val();
				var column = ",[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
				if(i == 0 || i == 1 || i == 2){
					column = "";
				}else if(i == 3) {
					column = "[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
				}
				strPrintCommand += column;
			}
			strPrintCommand += "]";
			ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
		};
		
		//按钮-下载
		var downLoadClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("下载失败，请您重试！");
		    }
			//word文件的全路径，只支持.doc文件。不支持.docx文件
			strWordPathFile = sc.basePath + "recourse/fj6.doc";
			//表单内容的JSON数组
			strPrintCommand = "[";
			var columnArr = new Array($(".scSave").length);
			for(var i = 0; i < $(".scSave").length; i++) {
				var columnName = $(".scSave").eq(i).attr("id");
				var columnValue = $(".scSave").eq(i).val();
				var column = ",[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
				if(i == 0 || i == 1 || i == 2){
					column = "";
				}else if(i == 3) {
					column = "[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
				}
				strPrintCommand += column;
			}
			strPrintCommand += "]";
		 	ctrl.ExportWord(strWordPathFile, strPrintCommand);
		};
	</script>
  </head>
  <body>
	<input type="hidden" id="scid" />
	<input class="scSave" type="hidden" id="userCode" />
	<input class="scSave ipt"  type="hidden" id="scStatus"  name="scStatus" value=""/>
	<div align = "center" >
		<div id="rsn"><h3>驳回原因如下：</h3></div>
  		<p>
  			<textarea rows="3" cols="70" class="scSave ipt" id="theReason" name="theReason"></textarea>
  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  		</p>
  	</div>
	<div align = "center" >
		受理日期: 
		<input class="scSave ipt" type="text" size="25" id="acceptanceDate" name="acceptanceDate" onclick="WdatePicker()" />		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		受理编号: 
		<input class="scSave ipt" type="text" size="25" id="acceptanceCode" name="acceptanceCode" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<br /><br />	
	<div style="position:absolute;left:200px;right:375px">
		<table border="0" width="600">
			<tr>
				<td colspan="5" align="center" >
					<h1>化学品物理危险性分类仲裁申请表</h1>				
				</td>		 
			</tr>
			<tr>
				<td align="right" width="25%">申请单位：</td>
				<td colspan="3" ><input class="scSave ipt" type="text" size="50" id="applyUnit" name="applyUnit" /></td>
			</tr>

			<tr>
				<td align="right" width="25%">经&nbsp;办&nbsp;人：</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="attn" name="attn" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">联系电话：</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="telNumber" name="telNumber" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">移动电话：</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="mobileNumber" name="mobileNumber" />
				</td>
			</tr>
			<tr>
				<td align="right" width="25%">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="fax" name="fax" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">电子邮箱：</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="email" name="email" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">填表日期：</td>
				<td ><input class="scSave ipt" type="text" size="50" id="fillDate" name="fillDate" onclick="WdatePicker()"/></td>
			</tr>
			<tr>
				<td colspan="3" align="center"><h2>国家安全生产监督管理总局制样</h2>				
				</td>
			</tr>
			<tr>
				<td colspan="3" ><hr/>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center"><h1>化学品物理危险性分类仲裁申请表</h1>			
				</td>
			</tr>
			<tr>
				<td colspan="3"><br/>	
				</td>						
			</tr>			
		</table>
		<table width="700" border="0"  >
			<tr>
				<td colspan="2"><h3>1、化学品信息</h3>
				</td>
			</tr>
			<tr>
				<td align="right">化学品中文名称：</td>
				<td><input class="scSave ipt" type="text" size="60"id="chineseName" name="chineseName" /></td>
			</tr>
			<tr>
				<td align="right">化学品英文名称：</td>
				<td><input class="scSave ipt" type="text" size="60" id="englishName" name="englishName" /></td>
			</tr>
			<tr>
				<td align="right">化学品中文别名：</td>
				<td><input class="scSave ipt" type="text" size="60" id="aligChiName" name="aligChiName" /></td>
			</tr>
			<tr>
				<td align="right">单&nbsp;&nbsp;位&nbsp;&nbsp;名&nbsp;&nbsp;称：</td>
				<td><input class="scSave ipt" type="text" size="60" id="unitName" name="unitName" /></td>
			</tr>
		</table>
		<br/><br/>

		<h3>2、分类仲裁申请</h3>
		<p >
			我单位于<input class="scSave ipt" type="text" size="28" id="arbitrationTime" name="arbitrationTime" onclick="WdatePicker()" />
			向国家安全生产监督管理总局化学品登记中心提交了上述化学品的物理危险性分类报告，分类报告中其物理危险性分类结果为：
		</p>
		<br/>
		<textarea  class="scSave ipt" id="classificationResults" name="classificationResults" rows="4" cols="82"></textarea>
		
		<p>
			<input class="scSave ipt" type="text" size="28" id="noticeDate" name="noticeDate" onclick="WdatePicker()" />
			国家安全生产监督管理总局化学品登记中心向我单位出具了如下化学品物理危险性分类结果审核通知书（化登危分字[A]B号）：
		</p>
		<br/>
		<textarea  class="scSave ipt" id="auditNotice" name="auditNotice" rows="4" cols="82"></textarea>	
		
		<p>我单位认为：</p>
		<br/>
			<textarea  class="scSave ipt" rows="6" id="unitThink" name="unitThink" cols="82"></textarea>
		<br/>
		<p>基于上述事实，特提交化学品物理危险性鉴定与分类技术委员会予以仲裁。</p>
		<br />
		
		<table width="600">
			<tr>
				<td>经办人（签字）： <input class="scSave ipt" type="text" size="28" id="attnPeople" name="attnPeople"></td>
			</tr>
			<tr>
				<td>单位负责人（签字）：<input class="scSave ipt" type="text" size="28" id="chargePeople" name="chargePeople"></td>
			</tr>
			<tr align="right">
				<td>（申请单位公章）</td>
			</tr>
			<tr align="right">
				<td><input class="scSave ipt" type="text" size="28" id="sealDate" name="sealDate" onclick="WdatePicker()" /></td>
			</tr>
		</table>
		
		<br /><br />
		<h3>3、其他需要说明的事项</h3>
		<br/>
		<textarea  class="scSave ipt" id="otherMatters" name="otherMatters" rows="8" cols="82"></textarea>
		<br />
		<p>	
			附：共
			<input class="scSave ipt" type="text" size="3" id="count" name="count">
			份附件，附件名称为： 
			<input class="scSave ipt" type="text" size="40" id="attachmentName" name="attachmentName">
			（申请分类仲裁单位应以附件的形式提交有助于仲裁的鉴定报告、分类审核通知书及相关材料。）
		</p>
		<p>
			受理人（签字）：
			<input class="scSave ipt" type="text" size="50" id="acceptPeople" name="acceptPeople">
		</p>
		<br /><br />
		
		<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
			CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
			codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
			打印控件加载失败 
  		</OBJECT>
  		
		<div align="center"  style="margin:20px">	
			<input class="scBtn" type="button" value="返回" onclick="returnToMain()" />
			<input class="scBtn" type="button" value="打印" onclick="printClick()" />
			<input class="scBtn" type="button" value="下载" onclick="downLoadClick()" />
  		</div>
	</div>
  </body>
</html>