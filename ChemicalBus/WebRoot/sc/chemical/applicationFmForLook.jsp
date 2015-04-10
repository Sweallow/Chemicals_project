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
	<title>��ѧƷ����Σ���Է����ٲ������</title>
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
				//�޸�,����ҳ������
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
		
		//����
		var returnToMain = function() {
			var scStatus = sc.getUrlQuery("scStatus");
			if(scStatus == "0"){
	   			window.location.href= sc.basePath+ "sc/chemical/arbitrationAudit.jsp";
	   		} else if(scStatus == "1") {
	   			window.location.href= sc.basePath+ "sc/chemical/auditedSuccessList.jsp";
	   		}
		};
		
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
				if(!data) return;
				for(var j = 0; j < data.columns.length; j++) {
					var column = data.columns[j];
					$("#" + column.columnName).val(column.columnValue);
				}
				if($("#scStatus").val() == "1"){
					//����һ��input������ı��༭��ʧȥ����
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

		//��ť-��ӡ
		var printClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("��ӡʧ�ܣ��������ԣ�");
		    }
			//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
			strWordPathFile = sc.basePath + "recourse/fj6.doc";
			//�����ݵ�JSON����
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
		
		//��ť-����
		var downLoadClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("����ʧ�ܣ��������ԣ�");
		    }
			//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
			strWordPathFile = sc.basePath + "recourse/fj6.doc";
			//�����ݵ�JSON����
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
		<div id="rsn"><h3>����ԭ�����£�</h3></div>
  		<p>
  			<textarea rows="3" cols="70" class="scSave ipt" id="theReason" name="theReason"></textarea>
  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  		</p>
  	</div>
	<div align = "center" >
		��������: 
		<input class="scSave ipt" type="text" size="25" id="acceptanceDate" name="acceptanceDate" onclick="WdatePicker()" />		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		������: 
		<input class="scSave ipt" type="text" size="25" id="acceptanceCode" name="acceptanceCode" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<br /><br />	
	<div style="position:absolute;left:200px;right:375px">
		<table border="0" width="600">
			<tr>
				<td colspan="5" align="center" >
					<h1>��ѧƷ����Σ���Է����ٲ������</h1>				
				</td>		 
			</tr>
			<tr>
				<td align="right" width="25%">���뵥λ��</td>
				<td colspan="3" ><input class="scSave ipt" type="text" size="50" id="applyUnit" name="applyUnit" /></td>
			</tr>

			<tr>
				<td align="right" width="25%">��&nbsp;��&nbsp;�ˣ�</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="attn" name="attn" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">��ϵ�绰��</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="telNumber" name="telNumber" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">�ƶ��绰��</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="mobileNumber" name="mobileNumber" />
				</td>
			</tr>
			<tr>
				<td align="right" width="25%">��&nbsp;&nbsp;&nbsp;&nbsp;�棺</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="fax" name="fax" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">�������䣺</td>
				<td colspan="2" ><input class="scSave ipt" type="text" size="50" id="email" name="email" /></td>
			</tr>
			<tr>
				<td align="right" width="25%">������ڣ�</td>
				<td ><input class="scSave ipt" type="text" size="50" id="fillDate" name="fillDate" onclick="WdatePicker()"/></td>
			</tr>
			<tr>
				<td colspan="3" align="center"><h2>���Ұ�ȫ�����ල�����ܾ�����</h2>				
				</td>
			</tr>
			<tr>
				<td colspan="3" ><hr/>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center"><h1>��ѧƷ����Σ���Է����ٲ������</h1>			
				</td>
			</tr>
			<tr>
				<td colspan="3"><br/>	
				</td>						
			</tr>			
		</table>
		<table width="700" border="0"  >
			<tr>
				<td colspan="2"><h3>1����ѧƷ��Ϣ</h3>
				</td>
			</tr>
			<tr>
				<td align="right">��ѧƷ�������ƣ�</td>
				<td><input class="scSave ipt" type="text" size="60"id="chineseName" name="chineseName" /></td>
			</tr>
			<tr>
				<td align="right">��ѧƷӢ�����ƣ�</td>
				<td><input class="scSave ipt" type="text" size="60" id="englishName" name="englishName" /></td>
			</tr>
			<tr>
				<td align="right">��ѧƷ���ı�����</td>
				<td><input class="scSave ipt" type="text" size="60" id="aligChiName" name="aligChiName" /></td>
			</tr>
			<tr>
				<td align="right">��&nbsp;&nbsp;λ&nbsp;&nbsp;��&nbsp;&nbsp;�ƣ�</td>
				<td><input class="scSave ipt" type="text" size="60" id="unitName" name="unitName" /></td>
			</tr>
		</table>
		<br/><br/>

		<h3>2�������ٲ�����</h3>
		<p >
			�ҵ�λ��<input class="scSave ipt" type="text" size="28" id="arbitrationTime" name="arbitrationTime" onclick="WdatePicker()" />
			����Ұ�ȫ�����ල�����ֻܾ�ѧƷ�Ǽ������ύ��������ѧƷ������Σ���Է��౨�棬���౨����������Σ���Է�����Ϊ��
		</p>
		<br/>
		<textarea  class="scSave ipt" id="classificationResults" name="classificationResults" rows="4" cols="82"></textarea>
		
		<p>
			<input class="scSave ipt" type="text" size="28" id="noticeDate" name="noticeDate" onclick="WdatePicker()" />
			���Ұ�ȫ�����ල�����ֻܾ�ѧƷ�Ǽ��������ҵ�λ���������»�ѧƷ����Σ���Է��������֪ͨ�飨����Σ����[A]B�ţ���
		</p>
		<br/>
		<textarea  class="scSave ipt" id="auditNotice" name="auditNotice" rows="4" cols="82"></textarea>	
		
		<p>�ҵ�λ��Ϊ��</p>
		<br/>
			<textarea  class="scSave ipt" rows="6" id="unitThink" name="unitThink" cols="82"></textarea>
		<br/>
		<p>����������ʵ�����ύ��ѧƷ����Σ���Լ�������༼��ίԱ�������ٲá�</p>
		<br />
		
		<table width="600">
			<tr>
				<td>�����ˣ�ǩ�֣��� <input class="scSave ipt" type="text" size="28" id="attnPeople" name="attnPeople"></td>
			</tr>
			<tr>
				<td>��λ�����ˣ�ǩ�֣���<input class="scSave ipt" type="text" size="28" id="chargePeople" name="chargePeople"></td>
			</tr>
			<tr align="right">
				<td>�����뵥λ���£�</td>
			</tr>
			<tr align="right">
				<td><input class="scSave ipt" type="text" size="28" id="sealDate" name="sealDate" onclick="WdatePicker()" /></td>
			</tr>
		</table>
		
		<br /><br />
		<h3>3��������Ҫ˵��������</h3>
		<br/>
		<textarea  class="scSave ipt" id="otherMatters" name="otherMatters" rows="8" cols="82"></textarea>
		<br />
		<p>	
			������
			<input class="scSave ipt" type="text" size="3" id="count" name="count">
			�ݸ�������������Ϊ�� 
			<input class="scSave ipt" type="text" size="40" id="attachmentName" name="attachmentName">
			����������ٲõ�λӦ�Ը�������ʽ�ύ�������ٲõļ������桢�������֪ͨ�鼰��ز��ϡ���
		</p>
		<p>
			�����ˣ�ǩ�֣���
			<input class="scSave ipt" type="text" size="50" id="acceptPeople" name="acceptPeople">
		</p>
		<br /><br />
		
		<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
			CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
			codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
			��ӡ�ؼ�����ʧ�� 
  		</OBJECT>
  		
		<div align="center"  style="margin:20px">	
			<input class="scBtn" type="button" value="����" onclick="returnToMain()" />
			<input class="scBtn" type="button" value="��ӡ" onclick="printClick()" />
			<input class="scBtn" type="button" value="����" onclick="downLoadClick()" />
  		</div>
	</div>
  </body>
</html>