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
	   	<title>���౨��</title>
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
			.a{font-family:"����"}
			.cc{width:50px}
			th  {width:200px;height:60px;border:1px solid black;}
			td  {width:150px;height:40px;border:1px solid black;}
			table{border-collapse:collapse;border-spacing:0;border:1px solid #fff;}	
		</style>
		<script type="text/javascript">
			//��ת���Ľ���:
			var scClassName = "com.sc.report.service.InformationService";//��
			var clClassName = "com.sc.report.service.ExamineService";//��
			$(function() {
				top.sc.indexAutoHeight($(document).height());
				var scid = sc.getUrlQuery("scid");
				//��ȡ�����Ϣ��scid����ֵ��֪ͨ���appscid�ֶ�
				var appscid = sc.getUrlQuery("appscid");
				if(scid) {
					//�޸�,����ҳ������
					loadPageData(scid);
					$("#scid").val(scid);
				}else {
					//����
					$("#appscid").val(appscid);
				}
			});
			
			//���ر�
			function toForm(){
				//window.location.href=sc.basePath+"chemical/report/c_examine.jsp";
				var rs = sc.getUrlQuery("rs");
				if(rs == "sh"){
					window.location.href=sc.basePath+"chemical/dangerClassifyReport/checkedDangerClassifyReport.jsp";
				}else{
					window.location.href=sc.basePath+"chemical/report/c_examine.jsp";
				}
			}
			
			//-----------����-----------
			var saveData = function(){
				var d = dialog({
				   content: "������..."
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
				//����tr��class��ΪappraisalInfo����
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
			
			//-----------�޸�-----------
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
				ServiceBreak(clClassName, "getAppraisalInfoDatas", [scid], function(res) {
					if(res == null) return;
					for(var j = 0; j < res.length; j++) {
						var rows = $(".appraisalInfo");	
						var appraisalInfo = res[j];
						//var risk_categories = appraisalInfo.risk_categories;
						//rows.eq(j).find(".risk_categories").val(risk_categories);
						//����json�󣬶�Ӧ��ֵ�ŵ���Ӧλ��
						var classification_results = appraisalInfo.CLASSIFICATION_RESULTS;
						rows.eq(j).find(".classification_results").val(classification_results);
						var audit_opinion = appraisalInfo.AUDIT_OPINION;
						rows.eq(j).find(".audit_opinion").val(audit_opinion);
						var remarks = appraisalInfo.REMARKS;
						rows.eq(j).find(".remarks").val(remarks);
					}
				});		
			};
		
			//-----------��ť-��ӡ-----------
			var printClick = function() {
				var ctrl = document.getElementById('ctrl');
				if (ctrl == null) {
			        alert("null");
			    }
				//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
				var strWordPathFile = sc.basePath + "recourse/fj3.doc";
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
				//��������
				var rows = $(".appraisalInfo");
				//var risk_categories = "";
				var classification_results = "";
				var audit_opinion = "";
				var remarks = "";
				for(var i = 0; i < rows.length; i++) {
					var  data = "";
					//��ȡ����ֵ
					//risk_categories = rows.eq(i).find(".risk_categories").val();
					classification_results = rows.eq(i).find(".classification_results").val();
					audit_opinion = rows.eq(i).find(".audit_opinion").val();
					remarks = rows.eq(i).find(".remarks").val();
					//ƴ��
					//risk_categories = ",[\"1\",\"[risk_categories" + i +  "]\",\"" + risk_categories + "\"]";
					//data += risk_categories;
					classification_results = ",[\"1\",\"[classification_results" + i + "]\",\"" + classification_results + "\"]";
					data += classification_results;
					audit_opinion = ",[\"1\",\"[audit_opinion" + i + "]\",\"" + audit_opinion + "\"]";
					data += audit_opinion;
					remarks = ",[\"1\",\"[remarks" + i + "]\",\"" + remarks + "\"]";
					data += remarks;
					//��װ
					strPrintCommand += data;
				}
				strPrintCommand += "]";
				//alert(strPrintCommand);
				ctrl.PrintWordFile(strWordPathFile, strPrintCommand);
			};
		
			//-----------��ť-����-----------
			var downLoadClick = function() {
				//debugger;
				var ctrl = document.getElementById('ctrl');
				if (ctrl == null) {
			        alert("null");
			    }
				//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
				var strWordPathFile = sc.basePath + "recourse/fj3.doc";
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
				//var risk_categories = "";
				var classification_results = "";
				var audit_opinion = "";
				var remarks = "";
				for(var i = 0; i < rows.length; i++) {
					var  data = "";
					//��ȡ����ֵ
					//risk_categories = rows.eq(i).find(".risk_categories").val();
					classification_results = rows.eq(i).find(".classification_results").val();
					audit_opinion = rows.eq(i).find(".audit_opinion").val();
					remarks = rows.eq(i).find(".remarks").val();
					//ƴ��
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
			<div class="a" align="center"><h2>��ѧƷ����Σ���Է��������֪ͨ��</h2></div>     
	    	<div align="right">����Σ����[A]B��</div>
			<div align="left">
				<br /><br />
				<input class="scSave ipt" id="Userd" size="18"  type="text" /> : <br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������Ķ��㵥λ
				<input class= "Wdate scSave ipt" type="text" id="data1" onclick="WdatePicker()"/>
			 	<%--
			 		<input class="scSave ipt" id="data1" style="width:150px" size="18"  type="text" />
			 	 --%>
	               	�ύ<input class="scSave ipt" id="Chemical" size="15"  type="text" />
					��ѧƷ������Σ���Է��౨�棨�������ڣ�
					<input class= "Wdate scSave ipt" type="text" id="date_acceptance" onclick="WdatePicker()"/>
				<%--
					<input class="scSave ipt" id="date_acceptance" size="12"  type="text" />��
				 --%>
				�����ţ�
					<input class="scSave ipt" id="Acceptance_number" size="12"  type="text" />�������ۺ�����������ˣ�������£�<br />
					<textarea class="scSave ipt" id="Opinions" cols="74" rows="15" style="resize: none;"></textarea>
					<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					���㵥λ�����������������飬�������յ�������֮����15�������������ҵ�λ�����������<br />��ѧƷ����Σ���Լ�������༼��ίԱ�������ٲá�<br />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ش�֪ͨ��
					<br /><br /><br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ϵ�ˣ�
					<input class="scSave ipt" id="Contact" size="10"  type="text" />
				&nbsp;&nbsp;��ϵ�绰��
					<input class="scSave ipt" id="Telephone" size="15"  type="text" />
					<br /><br /><br /><br />
					<div align="right">
						�����Ұ�ȫ�����ල�����ֻܾ�ѧƷ�Ǽ����Ĺ��£�
					</div>
					<br />
					<div align="right">
						���ڣ�
						<input class= "Wdate scSave ipt" type="text" id="data2" onclick="WdatePicker()"/>
						<%--<input class="scSave ipt" id="data2" size="18"  type="text" /> --%>
					</div>
				<br /><br />
			</div>
			<div align="left">����</div>
			<br /><br />
			<table style="width:550px;" >
                <tr align="center" >
                    <th colspan="5" >��ѧƷ����Σ���Է��౨�����</th>
                </tr>
                
				<tr  align="center" valign="middle">
                    <td id="risk_categories" colspan="2"  >Σ�������</td>
                    <td id="classification_results" >������</td>
					<td id="audit_opinion" >������</td>
					<td id="remarks" >��ע</td>
                </tr>            
				<tr class="appraisalInfo" align="center" valign="middle">
                    <td class="cc">1</td>
                    <td class="DType">��ը��</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">2</td>
                    <td>��ȼ����</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">3</td>
                    <td>���ܽ�</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">4</td>
                    <td>����������</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">5</td>
                    <td>��ѹ����</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">6</td>
                    <td>��ȼҺ��</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">7</td>
                    <td>��ȼ����</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">8</td>
                    <td>�Է�Ӧ���ʺͻ����</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">9</td>
                    <td>����Һ��</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">10</td>
                    <td>�������</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">11</td>
                    <td>�������ʺͻ����</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">12</td>
                    <td>��ˮ�ų���ȼ��������ʺͻ����</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">13</td>
                    <td>������Һ��</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">14</td>
                    <td>�����Թ���</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">15</td>
                    <td>�л���������</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr >
				<tr class="appraisalInfo"  align="center" valign="middle">
                    <td class="cc">16</td>
                    <td>������ʴ��</td>
                    <td><input class="classification_results its" type="text" name="classification_results"/></td>
					<td><input class="audit_opinion its" type="text" name="audit_opinion"/></td>
					<td><input class="remarks its" type="text" name="remarks"/></td>
                </tr>
				      
				<tr >
                    <td colspan="5" id="ff"> </td>
                </tr>

			   	<tr >
                    <td colspan="5" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ˣ�
                    	<input class="scSave ipt" id="Audit1" size="18"  type="text" />
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	���ʱ�䣺
                    	<input class= "Wdate scSave ipt" type="text" id="data3" onclick="WdatePicker()"/>
                    </td>
                </tr>
            </table>			
			
			<%--
			<div class="a" align="center">
				<h3>��ѧƷ����Σ���Է��������֪ͨ���й�����˵��</h3>
				<br /><br />
			</div>		
			<div align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ѧƷ����Σ���Է������֪ͨ�顷�е�Ӣ����ĸ�ֱ��ʾΪ��<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A����ʾ��ݡ���2013����������д��2013����<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B����ʾ������˵ı�š���6��24������ĵ�8�����౨�棬����д��062408����<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C����ʾ�ύ������˱���Ļ�ѧƷ��λ��<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D����ʾ�ύ������˻�ѧƷ�����ƣ�<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E����ʾ����ѧƷ����Σ���Է����ʱ�䣻<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F����ʾ��ѧƷ����Σ���Է��౨�����ʱ�������ţ�<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G����ʾ��������<br />
				��֪ͨ��һʽ3�ݣ����Ұ�ȫ�����ල�����ֻܾ�ѧƷ�Ǽ����Ĵ浵1�ݣ���ѧƷ��λ2�ݡ�
			</div>
			 --%>
			 
			<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
				CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
				codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
				��ӡ�ؼ�����ʧ�� 
	  		</OBJECT>
			 
			<div align="center" style="margin:20px">
				<input class="scBtn" type="button" value="����" onclick="saveData()" />
				<input class="scBtn" type="button" value="����" onclick="toForm()" />
				<input class="scBtn" type="button" value="��ӡ" onclick="printClick()" />
				<input class="scBtn" type="button" value="����" onclick="downLoadClick()"/>
			</div>
		</div>
    </body>
</html>
