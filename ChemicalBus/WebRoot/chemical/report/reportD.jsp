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
	   	<title>分类报告</title>
		<style type="text/css">
			body{margin:0;}
			#ff{height:1px;}
			#container {margin: 0 auto; width:550px;}
			.ipt {
				outline:none;
				border:none;
				background: none;	
				height:24px;
				BORDER-RIGHT:0px solid; 
				BORDER-TOP:0px solid; 
				BORDER-LEFT:0px solid; 
				BORDER-BOTTOM:1px solid;
			}
			.its {
				outline:none;
				border:none;
				background: none;	
				height:24px;
				BORDER-RIGHT:0px solid; 
				BORDER-TOP:0px solid; 
				BORDER-LEFT:0px solid;
				BORDER-BOTTOM:0px solid;
			}
			.a{font-family:"黑体"}
			.cc{width:50px}
			th  {width:200px;height:60px;border:1px solid black;}
			td  {width:150px;height:40px;border:1px solid black;}
			table{border-collapse:collapse;border-spacing:0;border:1px solid #fff;}	
		</style>
		<script type="text/javascript">
			//跳转到的界面:
			var scClassName = "com.sc.report.service.InformationService";//主
			var clClassName = "com.sc.report.service.ExamineService";//附
			$(function() {
				top.sc.indexAutoHeight($(document).height());
				var scid = sc.getUrlQuery("scid");
				//获取审核信息的scid并赋值给通知书的appscid字段
				var appscid = sc.getUrlQuery("appscid");
				if(scid) {
					//修改,加载页面数据
					loadPageData(scid);
					$("#scid").val(scid);
				}else {
					//新增
					$("#appscid").val(appscid);
				}
			});
			
			//返回表单
			function toForm(){
				//window.location.href=sc.basePath+"chemical/report/c_examine.jsp";
				var rs = sc.getUrlQuery("rs");
				if(rs == "sh"){
					window.location.href=sc.basePath+"chemical/dangerClassifyReport/checkedDangerClassifyReport.jsp";
				}else{
					window.location.href=sc.basePath+"chemical/report/c_examine.jsp";
				}
			}
			
			//-----------保存-----------
			var saveData = function(){
				var d = dialog({
				   content: "保存中..."
				});
				d.showModal();		
				var scid = $("#scid").val();
				var columnArr = new Array($(".scSave").length);
				for(var i = 0; i < $(".scSave").length; i++) {
					var columnName = $(".scSave").eq(i).attr("id");
					var columnValue = $(".scSave").eq(i).val();
					var column = {columnName: columnName, columnValue: columnValue};
					columnArr[i] = column;
				}
				var tableObj = {scid: scid, columns: columnArr};
				//所有tr中class名为appraisalInfo的行
				var rows = $(".appraisalInfo");
				var list = new Array();
				for(var i = 0; i < rows.length; i++) {
					var risk_categories = rows.eq(i).find(".risk_categories").val();
					var classification_results = rows.eq(i).find(".classification_results").val();
					var audit_opinion = rows.eq(i).find(".audit_opinion").val();
					var remarks = rows.eq(i).find(".remarks").val();
					if(classification_results) {
						var data = {scid: '', 
								risk_categories: risk_categories, 
								classification_results : classification_results, 
								audit_opinion: audit_opinion, 
								remarks: remarks};
						list[i] = data;
					}
				}
				ServiceBreak(clClassName, "dataSave", [JSON.stringify(tableObj), JSON.stringify(list)], function() {
					d.remove();
					var rs = sc.getUrlQuery("rs");
					if(rs == "sh"){
						window.location.href=sc.basePath+"chemical/dangerClassifyReport/checkedDangerClassifyReport.jsp";
					}else{
						window.location.href=sc.basePath+"chemical/dangerClassifyReport/checkingDangerClassifyReport.jsp";
					}
				});
			};
			
			//-----------修改-----------
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
				ServiceBreak(clClassName, "getAppraisalInfoDatas", [scid], function(res) {
					if(res == null) return;
					for(var j = 0; j < res.length; j++) {
						var rows = $(".appraisalInfo");	
						var appraisalInfo = res[j];
						//var risk_categories = appraisalInfo.risk_categories;
						//rows.eq(j).find(".risk_categories").val(risk_categories);
						//解析json后，对应的值放到对应位置
						var classification_results = appraisalInfo.CLASSIFICATION_RESULTS;
						rows.eq(j).find(".classification_results").val(classification_results);
						var audit_opinion = appraisalInfo.AUDIT_OPINION;
						rows.eq(j).find(".audit_opinion").val(audit_opinion);
						var remarks = appraisalInfo.REMARKS;
						rows.eq(j).find(".remarks").val(remarks);
					}
				});		
			};
		
			//-----------按钮-打印-----------
			var printClick = function() {
				var ctrl = document.getElementById('ctrl');
				if (ctrl == null) {
			        alert("null");
			    }
				//word文件的全路径，只支持.doc文件。不支持.docx文件
				var strWordPathFile = sc.basePath + "recourse/fj3.doc";
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
				//附表内容
				var rows = $(".appraisalInfo");
				//var risk_categories = "";
				var classification_results = "";
				var audit_opinion = "";
				var remarks = "";
				for(var i = 0; i < rows.length; i++) {
					var  data = "";
					//获取数据值
					//risk_categories = rows.eq(i).find(".risk_categories").val();
					classification_results = rows.eq(i).find(".classification_results").val();
					audit_opinion = rows.eq(i).find(".audit_opinion").val();
					remarks = rows.eq(i).find(".remarks").val();
					//拼接
					//risk_categories = ",[\"1\",\"[risk_categories" + i +  "]\",\"" + risk_categories + "\"]";
					//data += risk_categories;
					classification_results = ",[\"1\",\"[classification_results" + i + "]\",\"" + classification_results + "\"]";
					data += classification_results;
					audit_opinion = ",[\"1\",\"[audit_opinion" + i + "]\",\"" + audit_opinion + "\"]";
					data += audit_opinion;
					remarks = ",[\"1\",\"[remarks" + i + "]\",\"" + remarks + "\"]";
					data += remarks;
					//封装
					strPrintCommand += data;
				}
				strPrintCommand += "]";
				//alert(strPrintCommand);
				ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
			};
		
			//-----------按钮-下载-----------
			var downLoadClick = function() {
				//debugger;
				var ctrl = document.getElementById('ctrl');
				if (ctrl == null) {
			        alert("null");
			    }
				//word文件的全路径，只支持.doc文件。不支持.docx文件
				var strWordPathFile = sc.basePath + "recourse/fj3.doc";
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
				//var risk_categories = "";
				var classification_results = "";
				var audit_opinion = "";
				var remarks = "";
				for(var i = 0; i < rows.length; i++) {
					var  data = "";
					//获取数据值
					//risk_categories = rows.eq(i).find(".risk_categories").val();
					classification_results = rows.eq(i).find(".classification_results").val();
					audit_opinion = rows.eq(i).find(".audit_opinion").val();
					remarks = rows.eq(i).find(".remarks").val();
					//拼接
					//risk_categories = ",[\"1\",\"[risk_categories" + i +  "]\",\"" + risk_categories + "\"]";
					//data += risk_categories;
					classification_results = ",[\"1\",\"[classification_results" + i + "]\",\"" + classification_results + "\"]";
					data += classification_results;
					audit_opinion = ",[\"1\",\"[audit_opinion" + i + "]\",\"" + audit_opinion + "\"]";
					data += audit_opinion;
					remarks = ",[\"1\",\"[remarks" + i + "]\",\"" + remarks + "\"]";
					data += remarks;
					strPrintCommand += data;
				}
				strPrintCommand += "]";
				//alert(strPrintCommand);
				ctrl.ExportWord(strWordPathFile, strPrintCommand);
			};
		</script>   
	</head>
	<body>
		<input type="hidden" id="scid" />
		<input class="scSave ipt" type="hidden" id="appscid" />
	  	<div id="container" >
			<div class="a" align="center"><h2>化学品物理危险性分类结果审核通知书</h2></div>     
	    	<div align="right">化登危分字[A]B号</div>
			<div align="left">
				<br /><br />
				<input class="scSave ipt" id="Userd" size="18"  type="text" /> : <br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经我中心对你单位
				<input class= "Wdate scSave ipt" type="text" id="data1" onclick="WdatePicker()"/>
			 	<%--
			 		<input class="scSave ipt" id="data1" style="width:150px" size="18"  type="text" />
			 	 --%>
	               	提交<input class="scSave ipt" id="Chemical" size="15"  type="text" />
					化学品的物理危险性分类报告（受理日期：
					<input class= "Wdate scSave ipt" type="text" id="date_acceptance" onclick="WdatePicker()"/>
				<%--
					<input class="scSave ipt" id="date_acceptance" size="12"  type="text" />，
				 --%>
				受理编号：
					<input class="scSave ipt" id="Acceptance_number" size="12"  type="text" />）进行综合性评估与审核，意见如下：<br />
					<textarea class="scSave ipt" id="Opinions" cols="74" rows="15" style="resize: none;"></textarea>
					<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					如你单位对以上审核意见有异议，可以在收到审核意见之日起15个工作日内向我单位提出，或者向<br />化学品物理危险性鉴定与分类技术委员会申请仲裁。<br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;特此通知。
					<br /><br /><br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系人：
					<input class="scSave ipt" id="Contact" size="10"  type="text" />
				&nbsp;&nbsp;联系电话：
					<input class="scSave ipt" id="Telephone" size="15"  type="text" />
					<br /><br /><br /><br />
					<div align="right">
						（国家安全生产监督管理总局化学品登记中心公章）
					</div>
					<br />
					<div align="right">
						日期：
						<input class= "Wdate scSave ipt" type="text" id="data2" onclick="WdatePicker()"/>
						<%--<input class="scSave ipt" id="data2" size="18"  type="text" /> --%>
					</div>
				<br /><br />
			</div>
			<div align="left">附件</div>
			<br /><br />
			<table style="width:550px;" >
                <tr align="center" >
                    <th colspan="5" >化学品物理危险性分类报告审核</th>
                </tr>
                
				<tr  align="center" valign="middle">
                    <td id="risk_categories" colspan="2"  >危险性类别</td>
                    <td id="classification_results" >分类结果</td>
					<td id="audit_opinion" >审核意见</td>
					<td id="remarks" >备注</td>
                </tr>            
				<tr class="appraisalInfo" align="center" valign="middle">
                    <td class="cc">1</td>
                    <td class="DType">爆炸物</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">2</td>
                    <td>易燃气体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">3</td>
                    <td>气溶胶</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">4</td>
                    <td>氧化性气体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">5</td>
                    <td>加压气体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">6</td>
                    <td>易燃液体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">7</td>
                    <td>易燃固体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">8</td>
                    <td>自反应物质和混合物</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">9</td>
                    <td>发火液体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">10</td>
                    <td>发火固体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">11</td>
                    <td>自热物质和混合物</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">12</td>
                    <td>遇水放出易燃气体的物质和混合物</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">13</td>
                    <td>氧化性液体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">14</td>
                    <td>氧化性固体</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">15</td>
                    <td>有机过氧化物</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr >
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">16</td>
                    <td>金属腐蚀物</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				      
				<tr >
                    <td colspan="5" id="ff"> </td>
                </tr>

			   	<tr >
                    <td colspan="5" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;审核人：
                    	<input class="scSave ipt" id="Audit1" size="18"  type="text" />
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	审核时间：
                    	<input class= "Wdate scSave ipt" type="text" id="data3" onclick="WdatePicker()"/>
                    </td>
                </tr>
            </table>			
			
			<%--
			<div class="a" align="center">
				<h3>化学品物理危险性分类结果审核通知书有关内容说明</h3>
				<br /><br />
			</div>		
			<div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;《化学品物理危险性分类审核通知书》中的英文字母分别表示为：<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A—表示年份。如2013年受理，即填写“2013”；<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B—表示受理审核的编号。如6月24日受理的第8个分类报告，即填写“062408”；<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C—表示提交分类审核报告的化学品单位；<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D—表示提交分类审核化学品的名称；<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E—表示受理化学品物理危险性分类的时间；<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F—表示化学品物理危险性分类报告审核时的受理编号；<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G—表示审核意见。<br />
				本通知书一式3份，国家安全生产监督管理总局化学品登记中心存档1份，化学品单位2份。
			</div>
			 --%>
			 
			<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
				CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
				codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
				打印控件加载失败 
	  		</OBJECT>
			 
			<div align="center" style="margin:20px">
				<input class="scBtn" type="button" value="保存" onclick="saveData()" />
				<input class="scBtn" type="button" value="返回" onclick="toForm()" />
				<input class="scBtn" type="button" value="打印" onclick="printClick()" />
				<input class="scBtn" type="button" value="下载" onclick="downLoadClick()"/>
			</div>
		</div>
    </body>
</html>
