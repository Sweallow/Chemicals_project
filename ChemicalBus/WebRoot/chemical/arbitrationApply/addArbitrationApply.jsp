<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML >
<html>
  <head>
  	<base href="<%=basePath%>">
	<%@ include file="/sc/common.jsp"%>
    <title>化学品物理危险性鉴定仲裁申请表</title>
    <style type="text/css">
		input {
			text-align:center ;
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
	</style>
    <script type="text/javascript">
    	var scClassName = "com.sc.arbitrationApply.service.ArbirtationApplyService";
	   $(function(){
	   		top.sc.indexAutoHeight($(document).height());
	   		var scid = sc.getUrlQuery("scid");
			if(scid) {
				//加载页面数据
				loadPageData(scid);
				$("#scid").val(scid);
			} else {
				//新增
				$("#userName").val(sc.user.scid);
				$("#scstatus").val("0");
				$("#rsn").attr({style:"display:none"});
				$("#theReason").attr({style:"display:none"});
			}
	   });
	   
	   //load数据到修改页面
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
			//alert(JSON.stringify(tableObj));
			//读取表单数据，并为表单赋值
			ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
				if(data == null) return;
				for(var j = 0; j < data.columns.length; j++) {
					var column = data.columns[j];
					$("#" + column.columnName).val(column.columnValue);
				}
				if($("#scstatus").val() == "1"){
					//sc.alert("记录已审核不能进行修改！");
					//设置一般input输入框及文本编辑框失去焦点
					$("input").attr({onfocus:"this.blur()"});
					$("textarea").attr({onfocus:"this.blur()"});
					//设置时间输入框的onclick事件为空
					$("#executeDate").attr({onclick:"''"});
					$("#createtabledate").attr({onclick:"''"});
					$("#applydate").attr({onclick:"''"});
					$("#report_finish_date").attr({onclick:"''"});
					$("#seal_date").attr({onclick:"''"});
					//$("#saveBut").attr({onclick:"''"});
					$("#saveBut").attr({style:"display:none"});
				}
				if($("#scstatus").val() != "-1"){
					$("#rsn").attr({style:"display:none"});
					$("#theReason").attr({style:"display:none"});
				}
			});
		}
		//保存
		var saveData = function() {
			var scid = $("#scid").val();
			var scstatus = $("#scstatus").val();
			var columnArr = new Array($(".scSave").length);
			for(var i = 0; i < $(".scSave").length; i++) {
				var columnName = $(".scSave").eq(i).attr("id");
				var columnValue = $(".scSave").eq(i).val();
				var column = {columnName: columnName, columnValue: columnValue};
				columnArr[i] = column;
			}
			var tableObj = {scid: scid, columns: columnArr};
			ServiceBreakSyn(scClassName, "saveFormData", [JSON.stringify(tableObj)]);
			if(scstatus == "-1"){
				//alert("这是一条驳回数据");
				ServiceBreakSyn(scClassName, "updateScstatus", ["0",scid]);
			}
			window.location.href = sc.basePath + "chemical/arbitrationApply/arbitrationApplyShowList.jsp";
		}
		//返回
	   goBack = function(){
			window.location.href=sc.basePath+"chemical/arbitrationApply/arbitrationApplyShowList.jsp";
		}
		//打印
		var printClick = function() {//debugger
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("打印失败，请您重试！");
		    }
			//word文件的全路径，只支持.doc文件。不支持.docx文件
			var strWordPathFile = sc.basePath + "recourse/fj4.doc";
			//表单内容的JSON数组
			var strPrintCommand = "[";
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
			//alert(strPrintCommand);
			ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
		}
		//下载
		var downLoadClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("下载失败，请您重试！");
		    }
			//word文件的全路径，只支持.doc文件。不支持.docx文件
			var strWordPathFile = sc.basePath + "recourse/fj4.doc";
			//表单内容的JSON数组
			var strPrintCommand = "[";
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
			//alert(strPrintCommand);
		 	ctrl.ExportWord(strWordPathFile, strPrintCommand);
		}
	</script>
  </head>
  
  <body>
	<div>
		<div align="center"><br/><br/>
		<input class="scSave ipt"  type="hidden" id="userName"  name="userName" value="" />
		<input type="hidden" id="scid" />
		<input class="scSave ipt"  type="hidden" id="scstatus"  name="scstatus" value=""/>
		<div id="rsn">
			<h3>驳回原因如下：</h3>
		</div>
   		<p><textarea rows="4" cols="70" class="scSave ipt" id="theReason"   name="theReason"></textarea></p>
		受理日期：<input class="scSave ipt"  type="text" id="executeDate"  name="executeDate" onclick="WdatePicker()"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		受理编号：<input class="scSave ipt"  type="text" id="projectNum"  name="projectNum"/><br/><br/>
	   </div>
		  <h1 align = "center">化学品物理危险性鉴定仲裁申请表</h1>
		<div>
			<table border="0" align="center" width="500">
				<tr>
					<td width="80">申请单位：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="applyCom" size="50"   name="applyCom"/>
					</td>
				</tr>
				<tr>
					<td>经&nbsp;办&nbsp;人：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="executePeople" size="50"  name="executePeople"/>
					</td>
				</tr>
				<tr>
					<td>联系电话：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="phone" size="50"  name="phone"/>
					</td>
				</tr>
				<tr>
					<td>移动电话：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="mobilePhone"  size="50" name="mobilePhone"/>
					</td>
				</tr>
				<tr>
					<td>传&nbsp;&nbsp;真：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="fax" size="50"  name="fax"  />
					</td>
				</tr>
				<tr>
					<td>电子邮箱：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="email" size="50"  name="email"/>
					</td>
				</tr>
				<tr>
					<td>填表日期：</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="createtabledate" name="createtabledate" size="50" onclick="WdatePicker()" />
					</td>
				</tr>
			</table>
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
    	</div>
	</div>
    <div style="position:absolute;left:270px;top:400px;right:300px">
    	<h2 align = "center">国家安全生产监督管理总局制样</h2><hr/>
   	</div>
   		<div style="position:absolute;left:270px;top:500px;right:350px">
   			<h1 align = "center">化学品物理危险性鉴定仲裁申请表</h1>
   			<table  border="0" align="center" width="700">
		    	<tr>
		    		<td colspan="2"><h3>1、化学品信息</h3></td>
		    	</tr>
		    	<tr>
		    		<td width="100"> 化学品中文名称：</td>
		    		<td><input  class="scSave ipt"   type="text" size="52" id="chnName"   name="chnName"/></td>
		    	</tr>
		    	<tr>
		    		<td>化学品英文名称：</td>
		    		<td><input class="scSave ipt"  type="text" size="52" id="chnEngName"   name="chnEngName" /></td>
		    	</tr>
		    	<tr>
		    		<td>化学品中文别名：</td>
		    		<td><input class="scSave ipt"  type="text" size="52" id="chnAlies"   name="chnAlies"/></td>
		    	</tr>
	    	</table>
   			<h3>2、申请鉴定仲裁内容</h3>
   			<p>
   				 我单位于<input class="scSave ipt"  type="text" id="applydate" name="applydate" size="6" onclick="WdatePicker()" />年/月/日
   				 向化学品物理危险性鉴定机构<input class="scSave ipt"  type="text" size="20" id="authentication_institution"   name="authentication_institution"  /> 
   				 申请对上述化学品进行物理危险性鉴定，鉴定项目为<input class="scSave ipt"  type="text" size="26" id="authentication_project"   name="authentication_project"  /> ，
				该鉴定机构于
   				<input class="scSave ipt"  type="text" id="report_finish_date" name="report_finish_date" size="6" onclick="WdatePicker()" />年/月/日
   				 向我单位出具了鉴定报告，报告编号<input class="scSave ipt"  type="text" size="11" id="report_no"   name="report_no" />，
   				 鉴定结果如下：
			</p>
  			<p><textarea rows="4" cols="70" class="scSave ipt" id="authentication_result"   name="authentication_result"></textarea></p>
   			<p>我单位认为：</p>
   			<p><textarea rows="4" cols="70" class="scSave ipt" id="our_suggestion"   name="our_suggestion"></textarea></p>
			&nbsp;&nbsp;&nbsp;&nbsp;基于以上情况，特提交化学品物理危险性鉴定与分类技术委员会予以仲裁。                                              
			<br/><br/>
			<table width="550">
				<tr>
					<td>经办人（签字）：<input class="scSave ipt" type="text" id="executePeopleqz" name="executePeopleqz"/></td>
				</tr>
				<tr>
					<td>单位负责人（签字）：<input class="scSave ipt" type="text" id="responsible_person" name="responsible_person" /></td>
				</tr>
				<tr><td></td></tr>
				<tr>
					<td align="right">（申请单位公章）</td>
				</tr>
				<tr>
					<td align="right">
						<input class="scSave ipt" type="text" id="seal_date" name="seal_date" size="12" onclick="WdatePicker()" />年/月/日   
					</td>
				</tr>
			</table>
			<br/><br/>
			<h3>3、其他需要说明的事项</h3>
				<p>
					<textarea rows="7" class="scSave ipt" cols="70" id="instructions" name="instructions"></textarea>
				</p>
				<p>&nbsp;&nbsp;&nbsp;
				   附：共<input class="scSave ipt"  type="text" size="6" id="file_count"  name="file_count" />份附件，
				   附件名称： <input class="scSave ipt"  type="text"  size="30" id="filename"  name="filename" />
				</p>
				<p>&nbsp;&nbsp;（申请鉴定仲裁单位应以附件的形式提交有助于仲裁的鉴定报告及相关材料）</p>
				<p align="right">受理人（签字）：
					<input class="scSave ipt" type="text" id="acceptance_pepple" name="acceptance_pepple" />
				</p>
				<p>
					<h5>注：如果是系列鉴定，且仲裁送检样品超过1个时，“化学品信息”栏中的“化学品中文名称”应填写所有送检样品的名称，“化学品英文名称”、“其他名称”可以不填。</h5>
				</p>
			 	
		 	<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
				CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
				codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
				打印控件加载失败 
	  		</OBJECT>
	  		
		 	<div align="center" class="bt">	
				<input id="saveBut" class="scBtn" type="button" value="保存" onclick="saveData()" />
				<input class="scBtn" type="button" value="返回" onclick="goBack()" />
			 	<input class="scBtn" type="button" value="打印" onclick="printClick()" />
			 	<input class="scBtn" type="button" value="下载" onclick="downLoadClick()"/>
	  		</div>  
   		</div>
  </body>
</html>
