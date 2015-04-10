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
    <title>��ѧƷ����Σ���Լ����ٲ������</title>
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
				//����ҳ������
				loadPageData(scid);
				$("#scid").val(scid);
			} else {
				//����
				$("#userName").val(sc.user.scid);
				$("#scstatus").val("0");
				$("#rsn").attr({style:"display:none"});
				$("#theReason").attr({style:"display:none"});
			}
	   });
	   
	   //load���ݵ��޸�ҳ��
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
			//alert(JSON.stringify(tableObj));
			//��ȡ�����ݣ���Ϊ����ֵ
			ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
				if(data == null) return;
				for(var j = 0; j < data.columns.length; j++) {
					var column = data.columns[j];
					$("#" + column.columnName).val(column.columnValue);
				}
				if($("#scstatus").val() == "1"){
					//sc.alert("��¼����˲��ܽ����޸ģ�");
					//����һ��input������ı��༭��ʧȥ����
					$("input").attr({onfocus:"this.blur()"});
					$("textarea").attr({onfocus:"this.blur()"});
					//����ʱ��������onclick�¼�Ϊ��
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
		//����
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
				//alert("����һ����������");
				ServiceBreakSyn(scClassName, "updateScstatus", ["0",scid]);
			}
			window.location.href = sc.basePath + "chemical/arbitrationApply/arbitrationApplyShowList.jsp";
		}
		//����
	   goBack = function(){
			window.location.href=sc.basePath+"chemical/arbitrationApply/arbitrationApplyShowList.jsp";
		}
		//��ӡ
		var printClick = function() {//debugger
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("��ӡʧ�ܣ��������ԣ�");
		    }
			//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
			var strWordPathFile = sc.basePath + "recourse/fj4.doc";
			//�����ݵ�JSON����
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
		//����
		var downLoadClick = function() {
			var ctrl = document.getElementById('ctrl');
			if (ctrl == null) {
		        sc.alert("����ʧ�ܣ��������ԣ�");
		    }
			//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
			var strWordPathFile = sc.basePath + "recourse/fj4.doc";
			//�����ݵ�JSON����
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
			<h3>����ԭ�����£�</h3>
		</div>
   		<p><textarea rows="4" cols="70" class="scSave ipt" id="theReason"   name="theReason"></textarea></p>
		�������ڣ�<input class="scSave ipt"  type="text" id="executeDate"  name="executeDate" onclick="WdatePicker()"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		�����ţ�<input class="scSave ipt"  type="text" id="projectNum"  name="projectNum"/><br/><br/>
	   </div>
		  <h1 align = "center">��ѧƷ����Σ���Լ����ٲ������</h1>
		<div>
			<table border="0" align="center" width="500">
				<tr>
					<td width="80">���뵥λ��</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="applyCom" size="50"   name="applyCom"/>
					</td>
				</tr>
				<tr>
					<td>��&nbsp;��&nbsp;�ˣ�</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="executePeople" size="50"  name="executePeople"/>
					</td>
				</tr>
				<tr>
					<td>��ϵ�绰��</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="phone" size="50"  name="phone"/>
					</td>
				</tr>
				<tr>
					<td>�ƶ��绰��</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="mobilePhone"  size="50" name="mobilePhone"/>
					</td>
				</tr>
				<tr>
					<td>��&nbsp;&nbsp;�棺</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="fax" size="50"  name="fax"  />
					</td>
				</tr>
				<tr>
					<td>�������䣺</td>
					<td colspan="7">
						<input class="scSave ipt"  type="text" id="email" size="50"  name="email"/>
					</td>
				</tr>
				<tr>
					<td>������ڣ�</td>
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
    	<h2 align = "center">���Ұ�ȫ�����ල�����ܾ�����</h2><hr/>
   	</div>
   		<div style="position:absolute;left:270px;top:500px;right:350px">
   			<h1 align = "center">��ѧƷ����Σ���Լ����ٲ������</h1>
   			<table  border="0" align="center" width="700">
		    	<tr>
		    		<td colspan="2"><h3>1����ѧƷ��Ϣ</h3></td>
		    	</tr>
		    	<tr>
		    		<td width="100"> ��ѧƷ�������ƣ�</td>
		    		<td><input  class="scSave ipt"   type="text" size="52" id="chnName"   name="chnName"/></td>
		    	</tr>
		    	<tr>
		    		<td>��ѧƷӢ�����ƣ�</td>
		    		<td><input class="scSave ipt"  type="text" size="52" id="chnEngName"   name="chnEngName" /></td>
		    	</tr>
		    	<tr>
		    		<td>��ѧƷ���ı�����</td>
		    		<td><input class="scSave ipt"  type="text" size="52" id="chnAlies"   name="chnAlies"/></td>
		    	</tr>
	    	</table>
   			<h3>2����������ٲ�����</h3>
   			<p>
   				 �ҵ�λ��<input class="scSave ipt"  type="text" id="applydate" name="applydate" size="6" onclick="WdatePicker()" />��/��/��
   				 ��ѧƷ����Σ���Լ�������<input class="scSave ipt"  type="text" size="20" id="authentication_institution"   name="authentication_institution"  /> 
   				 �����������ѧƷ��������Σ���Լ�����������ĿΪ<input class="scSave ipt"  type="text" size="26" id="authentication_project"   name="authentication_project"  /> ��
				�ü���������
   				<input class="scSave ipt"  type="text" id="report_finish_date" name="report_finish_date" size="6" onclick="WdatePicker()" />��/��/��
   				 ���ҵ�λ�����˼������棬������<input class="scSave ipt"  type="text" size="11" id="report_no"   name="report_no" />��
   				 ����������£�
			</p>
  			<p><textarea rows="4" cols="70" class="scSave ipt" id="authentication_result"   name="authentication_result"></textarea></p>
   			<p>�ҵ�λ��Ϊ��</p>
   			<p><textarea rows="4" cols="70" class="scSave ipt" id="our_suggestion"   name="our_suggestion"></textarea></p>
			&nbsp;&nbsp;&nbsp;&nbsp;����������������ύ��ѧƷ����Σ���Լ�������༼��ίԱ�������ٲá�                                              
			<br/><br/>
			<table width="550">
				<tr>
					<td>�����ˣ�ǩ�֣���<input class="scSave ipt" type="text" id="executePeopleqz" name="executePeopleqz"/></td>
				</tr>
				<tr>
					<td>��λ�����ˣ�ǩ�֣���<input class="scSave ipt" type="text" id="responsible_person" name="responsible_person" /></td>
				</tr>
				<tr><td></td></tr>
				<tr>
					<td align="right">�����뵥λ���£�</td>
				</tr>
				<tr>
					<td align="right">
						<input class="scSave ipt" type="text" id="seal_date" name="seal_date" size="12" onclick="WdatePicker()" />��/��/��   
					</td>
				</tr>
			</table>
			<br/><br/>
			<h3>3��������Ҫ˵��������</h3>
				<p>
					<textarea rows="7" class="scSave ipt" cols="70" id="instructions" name="instructions"></textarea>
				</p>
				<p>&nbsp;&nbsp;&nbsp;
				   ������<input class="scSave ipt"  type="text" size="6" id="file_count"  name="file_count" />�ݸ�����
				   �������ƣ� <input class="scSave ipt"  type="text"  size="30" id="filename"  name="filename" />
				</p>
				<p>&nbsp;&nbsp;����������ٲõ�λӦ�Ը�������ʽ�ύ�������ٲõļ������漰��ز��ϣ�</p>
				<p align="right">�����ˣ�ǩ�֣���
					<input class="scSave ipt" type="text" id="acceptance_pepple" name="acceptance_pepple" />
				</p>
				<p>
					<h5>ע�������ϵ�м��������ٲ��ͼ���Ʒ����1��ʱ������ѧƷ��Ϣ�����еġ���ѧƷ�������ơ�Ӧ��д�����ͼ���Ʒ�����ƣ�����ѧƷӢ�����ơ������������ơ����Բ��</h5>
				</p>
			 	
		 	<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
				CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
				codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  
				��ӡ�ؼ�����ʧ�� 
	  		</OBJECT>
	  		
		 	<div align="center" class="bt">	
				<input id="saveBut" class="scBtn" type="button" value="����" onclick="saveData()" />
				<input class="scBtn" type="button" value="����" onclick="goBack()" />
			 	<input class="scBtn" type="button" value="��ӡ" onclick="printClick()" />
			 	<input class="scBtn" type="button" value="����" onclick="downLoadClick()"/>
	  		</div>  
   		</div>
  </body>
</html>
