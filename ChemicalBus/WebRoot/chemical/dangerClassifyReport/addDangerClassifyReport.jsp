<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML >
<html>
  <head>
    <title>��ӻ�ѧƷ����Σ���Է��౨��</title>
	    <base href="<%=basePath%>">
	    <%@ include file="/sc/common.jsp"%>
	    <style type="text/css">
			input[type="text"]{
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
			body {
				background: #fff;
				padding:10px 0;
				overflow: hidden;
				font-size:12px;
			}
			.title1 {
				text-align:center;
				font-weight: bold;
				font-size: 30px;
				padding:20px 0;
			}
			.front {
				text-align:center;
				font-weight: 400;
				font-size: 14px;
				padding:3px 0;
			}
			.title2 {
				text-align:center;
				font-weight: bold;
				font-size: 22px;
				padding:10px 0;
			}
			.tab {
				width:670px;
				border:1px #ccc solid;
			}
			.tab td {
				border:1px #ccc solid;
				padding:2px 5px;
			}
			td .ipt {
				width: 90%;
				outline: none;
				text-align: left;
			}
			.subTab td {
				border: none;
			}
		</style>
		<script type="text/javascript">
			var scClassName = "com.sc.dangerClassifyReport.service.DangerClassifyReportService";
			$(function() {
				top.sc.indexAutoHeight(3400);
				$("#userId").val(sc.user.scid);
				var scid = sc.getUrlQuery("scid");
				if (scid) {
					//�޸�,����ҳ������
					loadPageData(scid);
					$("#scid").val(scid);
				} else {
					//����
					$("#userId").val(sc.user.scid);
					//������Ĭ��Ϊ�����
					$("#scstatus").val("0");
					//�����Ĳ���ʾ����ԭ��
					$("#rsn").attr({style:"display:none"});
					$("#back_reason").attr({style:"display:none"});
				}
			});
			
			//�޸�
			var loadPageData = function(scid) {
				//�õ�����װ�����ֶ�
				var columnArr = new Array($(".scSave").length);
				for (var i = 0; i < $(".scSave").length; i++) {
					var columnName = $(".scSave").eq(i).attr("id");
					var columnValue = $(".scSave").eq(i).val();
					var column = {
						columnName : columnName,
						columnValue : columnValue
					};
					columnArr[i] = column;
				}
				var tableObj = {
					scid : scid,
					columns : columnArr
				};
				//��ȡ�����ݣ���Ϊ����ֵ
				ServiceBreak(scClassName, "loadFormData", [ JSON.stringify(tableObj) ],
						function(data) {
							if (data == null)
								return;
							for (var j = 0; j < data.columns.length; j++) {
								var column = data.columns[j];
								$("#" + column.columnName).val(column.columnValue);
								//��ȡ��ѡ��ť��ֵ�����ö�ѡ��ť��ѡ״̬
								var box = $("[type='checkbox']");
								for (var i = 0; i < box.length; i++) {
									if ( box[i].value=="0") {
										box[i].checked = true;
									}
								}
							}
							//�ж����״̬����1��Ϊ���ͨ����
							if($("#scstatus").val() == "1"){
								//sc.alert("�ü�¼����˽���,�����ٽ����޸�!");
								
								//����һ��input������ı��༭��ʧȥ����
								$("input").attr({onfocus:"this.blur()"});
								$("textarea").attr({onfocus:"this.blur()"});
								//����ʱ��������onclick�¼�Ϊ��
								$("#acceptance_date").attr({onclick:"''"});
								$("#compile_date").attr({onclick:"''"});
								$("#seal_date").attr({onclick:"''"});
								//���ر��水ť
								$("#saveButton").attr({style:"display:none"});
							}
							//��-1��Ϊ���ص�,�ǲ��ص���������back_reason�ı���
							if($("#scstatus").val() != "-1"){
								$("#rsn").attr({style:"display:none"});
								$("#back_reason").attr({style:"display:none"});
							}
						});
			};
			
			//����
			var saveForm = function() {
				//���ý�����
				var d = dialog({
				    content: "������...",
				});
				//��ʾ������
				d.showModal();
				var scid = $("#scid").val();
				//��ȡ״ֵ̬
				var scstatus = $("#scstatus").val();
				//��ѡ��1��ʾδѡ�У�0��ʾѡ�С�
				var box = $("[type='checkbox']");
				for (var i = 0; i < box.length; i++) {
					if ( box[i].checked) {
						box[i].value = "0";
					} else {
						box[i].value = "1";
					}
				}
				var columnArr = new Array($(".scSave").length);
				for (var i = 0; i < $(".scSave").length; i++) {
					var columnName = $(".scSave").eq(i).attr("id");
					var columnValue = $(".scSave").eq(i).val();
					var column = {
						columnName : columnName,
						columnValue : columnValue
					};
					columnArr[i] = column;
				}
				var tableObj = {
					scid : scid,
					columns : columnArr
				};
				//ȡ��������
				d.remove();
				//1���ȱ�������
				ServiceBreakSyn(scClassName, "saveFormData",[JSON.stringify(tableObj)]);
				//2���ٸ������״̬
				if(scstatus == "-1"){
					//alert("����һ����������");
					ServiceBreakSyn(scClassName, "updateScstatus", ["0",scid]);
				}
				window.location.href = sc.basePath 
					+ "chemical/dangerClassifyReport/dangerClassifyReportShowList.jsp";
			};
			
			//======�����б����==========
			function backToList() {
				window.location = sc.basePath
						+ "chemical/dangerClassifyReport/dangerClassifyReportShowList.jsp";
			}
			
			//===========��ӡ===========
			var printClick = function() {
				var ctrl = document.getElementById('ctrl');
				if (!ctrl) {
			        sc.alert("����ʧ�ܣ������ԣ�");
			    }
				//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
				var strWordPathFile = sc.basePath + "recourse/fj2.doc";
				//�����ݵ�JSON����
				var strPrintCommand = "[";
				var columnArr = new Array($(".scSave").length);
				for(var i = 0; i < $(".scSave").length; i++) {
					var columnName = $(".scSave").eq(i).attr("id");
					var columnValue = $(".scSave").eq(i).val();
					if(i == 0 || i == 1){
						column = "";
					}
					else if(i == 2) {
						column = "[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
					}else{
						var input = document.getElementsByTagName("input");
						//�ж�input�Ƿ�Ϊ��ѡ��
			            if (input[i].type == "checkbox") {
			                if(input[i].checked){
								strKong = "{@}";
								column = ",[\"1\",\"[" + columnName + "]\",\"" + strKong + "\"]";
							} else {
								strKong="��";
								column = ",[\"1\",\"[" + columnName + "]\",\"" + strKong + "\"]";
							}
			            }else{
							column = ",[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
						}
					}
					strPrintCommand += column;
				}
				strPrintCommand += "]";
				alert(strPrintCommand);
			 	ctrl.ExportWord(strWordPathFile, strPrintCommand);
			};
			
			//===========����===========
			function downLoadClick() {
				var ctrl = document.getElementById('ctrl');
				if (!ctrl) {
			        sc.alert("����ʧ�ܣ������ԣ�");
			    }
				//word�ļ���ȫ·����ֻ֧��.doc�ļ�����֧��.docx�ļ�
				var strWordPathFile = sc.basePath + "recourse/fj2.doc";
				//�����ݵ�JSON����
				var strPrintCommand = "[";
				var columnArr = new Array($(".scSave").length);
				for(var i = 0; i < $(".scSave").length; i++) {
					var columnName = $(".scSave").eq(i).attr("id");
					var columnValue = $(".scSave").eq(i).val();
					if(i == 0 || i == 1) {
						column = "";
					} else if(i == 2) {
						column = "[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
					} else {
						var input = document.getElementsByTagName("input");
						//�ж�input�Ƿ�Ϊ��ѡ��
			            if (input[i].type == "checkbox") {
			                if(input[i].checked){
								strKong = "{@}";
								column = ",[\"1\",\"[" + columnName + "]\",\"" + strKong + "\"]";
							} else {
								strKong="��";
								column = ",[\"1\",\"[" + columnName + "]\",\"" + strKong + "\"]";
							}
			            } else {
							column = ",[\"1\",\"[" + columnName + "]\",\"" + columnValue + "\"]";
						}
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
	<input type="hidden" id="scid" />
	<input type="hidden" class="scSave ipt" id = "userId"  name = "userId"  value=""/>
	<input type="hidden" class="scSave ipt" id ="scstatus" name="scstatus"  value=""/>
	<div align = "center" >
		<div id="rsn"><h3>����ԭ�����£�</h3></div>
   		<p>
   			<textarea rows="3" cols="70" class="scSave" id="back_reason" name="back_reason"></textarea>
   		</p>
	</div>
	<table align = "center" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class = "front" >�����ţ�</td>
			<td><input  class="scSave" type="text" id="repport_no" align = "left" name="repport_no" /></td>
		</tr>
		<tr>
			<td class = "front" >�������ڣ�</td>
			<td style="width:400px"><input class= "Wdate scSave" type="text" id="acceptance_date" name="acceptance_date" onclick="WdatePicker()"/></td>
			<td class = "front" >�����ţ�</td>
			<td><input class="scSave ipt"  type="text" id="acceptance_no"   name="acceptance_no" /></td>
		</tr>
	</table>
	<table border="0" align="center" border="0" cellspacing="0" cellpadding="0"> 
		<tr>
			<td  class = "title1"  colspan = "2" >��ѧƷ����Σ���Է��౨��</td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">��ѧƷ���ƣ�</td>
			<td height = "24px" align = "center"><input class="scSave ipt" type="text" id="chemist_name" name="chemist_name" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;��λ���ƣ�</td>
			<td height = "24px" align = "center"><input class="scSave ipt"  type="text" id="unit_name"  name="unit_name" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px" align = "center">&nbsp;&nbsp;&nbsp;&nbsp;��λ���ԣ�</td>
			<td height = "24px"  align ="center"><input class="scSave ipt" type="text" id="unit_property" name="unit_property" /></td>
		</tr>
		<tr>
			<td class = "front"  height ="24px" align = "center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����ˣ�</td>
			<td height = "24px"  align ="center"><input class="scSave ipt" type="text" id="executePeople" name="executePeople" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;��ϵ�绰��</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="phone" name="phone" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;�ƶ��绰��</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="mobilePhone" name="mobilePhone" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���棺
			</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="fax"  name="fax" /></td>
		</tr>		
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;�������䣺</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="email"  name="email" /></td>
		</tr>
		<tr>
			<td class = "front" height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;�������ڣ�</td>
			<td height = "24px" align = "center">
				<input  class= "Wdate scSave ipt"  type="text" id="compile_date" name="compile_date" onclick="WdatePicker()"/>
			</td>
		</tr>
		<tr>
			<td height = "100px"  class = "title2"  colspan = "2">���Ұ�ȫ�����ල�����ܾ�����</td>
		</tr>
	</table>
	<table class="tab" border="0" cellspacing="0" cellpadding="0"  align = "center">
		<tr>
			<td colspan = "6"><h2 align="center">��һ���� ��ѧƷ��Ϣ</h2></td>
		</tr>	
		<tr>
			<td colspan = "6"><h3>1.1 ��ѧƷ������Ϣ</h3></td>
		</tr>	
		<tr>
			<td>��������</td>
			<td colspan = "5"><input class="scSave ipt"  type="text" id="chnName"  name="chnName" /></td>
		</tr>	
		<tr>
			<td >Ӣ������</td>
			<td colspan = "5"><input class="scSave ipt"  type="text" id="chnEngName"   name="chnEngName" /></td>
		</tr>
		<tr>
			<td>���ı���</td>
			<td colspan = "5"><input class="scSave ipt"  type="text" id="chnAlies"   name="chnAlies" /></td>
		</tr>
		<tr>
			<td rowspan = "5">������Ϣ</td>
			<td style="width:32px;">���</td>
			<td style="width:200px;">�������</td>
			<td style="width:120px;">CAS��</td>
			<td>������%��</td>
			<td style="width:40px;">�Ƿ�<br/>����</td>
		</tr>
		<tr>
			<td>1</td>
			<td><input class="scSave ipt"  type="text"  id="component_name1"  name="component_name1" /></td>
			<td><input class="scSave ipt"  type="text"  id="component_cas1"  name="component_cas1" /></td>
			<td><input class="scSave ipt"  type="text"  id="component_percent1"  name="component_percent1" /></td>
			<td>
				<label>
					<input class="scSave"  type="checkbox"  id="component_secret1"  name="checkbox"  value="1" />��
				</label>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td><input class="scSave ipt"  type="text" id="component_name2"  name="component_name2" /></td>
			<td><input class="scSave ipt"  type="text" id="component_cas2"  name="component_cas2" /></td>
			<td><input class="scSave ipt"  type="text" id="component_percent2"  name="component_percent2" /></td>
			<td>
				<label>
					<input class="scSave"  type="checkbox" id="component_secret2"  name="checkbox"  value="1"  />��
				</label>
			</td>
		</tr>
		<tr>
			<td>3</td>
			<td><input class="scSave ipt"  type="text" id="component_name3"  name="component_name3" /></td>
			<td><input class="scSave ipt"  type="text" id="component_cas3"  name="component_cas3" /></td>
			<td><input class="scSave ipt"  type="text" id="component_percent3"  name="component_percent3" /></td>
			<td>
				<label>
					<input class="scSave"  type="checkbox" id="component_secret3"  name="checkbox"  value="1"  />��
				</label>
			</td>
		</tr>
		<tr>
			<td>4</td>
			<td><input class="scSave ipt"  type="text" id="component_name4"  name="component_name4" /></td>
			<td><input class="scSave ipt"  type="text" id="component_cas4"  name="component_cas4" /></td>
			<td><input class="scSave ipt"  type="text" id="component_percent4"  name="component_percent4" /></td>
			<td>
				<label>
					<input class="scSave"  type="checkbox" id="component_secret4"  name="checkbox"  value="1"  />��
				</label>
			</td>
		</tr>
		<tr>
			<td>״̬</td>
			<td colspan = "5">
				<label><input class="scSave" id="status_name" value = "����" type="checkbox"  name = "checkbox" />����</label>����̬����
				<input style="width:350px;" class="scSave ipt" type="text"  id="status_solid_desc"  name="status_solid_desc" /><br />
				<label><input class="scSave" id="status_name1" value = "Һ��"  type="checkbox"  name = "checkbox"  />Һ��</label>��
				<label><input class="scSave" id="status_name2" value = "����"  type="checkbox"   name = "checkbox" />����</label>��
				<label><input class="scSave" id="status_name3" value = "������̬ "  type="checkbox"  name = "checkbox"   />������̬</label>
				<input style="width:265px;" class="scSave ipt"   type="text" id ="other_status_name"  name="other_status_name" /><br />
				��ɫ��<input style="width:190px;" class="scSave ipt"  type="text"  id="status_color"   name="status_color" />&nbsp;
				��ζ��<input style="width:190px;" class="scSave ipt"  type="text"  id="status_smile"  name="status_smile" />
			</td>
		</tr>
		<tr>
			<td>��;</td>
			<td colspan = "5"><input class="scSave ipt"  type="text"  id="useness"  name="useness" /></td>
		</tr>	
		<tr>
			<td>������λ����</td>
			<td colspan = "5"><input class="scSave ipt"  type="text"  id ="product_unit_name"  name="product_unit_name" /></td>
		</tr>
	</table>
	<table class="tab" border="0" cellspacing="0" cellpadding="0"  align = "center">
		<tr>
			<td colspan = "6"><h3>1.2 ��ѧƷ�����Բ���</h3></td>
		</tr>
		<tr>
			<td>��Ŀ</td>
			<td>���</td>
			<td>����</td>
			<td>����</td>
			<td colspan = "2">���Ա���/���׸�����</td>
		</tr>
		<tr>
			<td>����ѹ(kPa)</td>
			<td><input  class="scSave ipt"  type="text" id="vapour_pressure_c"  name="vapour_pressure_c" /></td>
			<td><input  class="scSave"  type="checkbox" id="vapour_pressure_t"  name="checkbox"  value="1"  /></td>
			<td><input  class="scSave"  type="checkbox" id="vapour_pressure_d"  name="checkbox"  value="1"  /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text"  id="vapour_pressure_f"  name="vapour_pressure_f" /></td>
		</tr>
		<tr>
			<td>�۵�(��)</td>
			<td><input  class="scSave ipt"  type="text"  id="melting_point_c"  name="melting_point_c" /></td>
			<td><input  class="scSave"  type="checkbox" id="melting_point_t"  name="checkbox"  value="1"  /></td>
			<td><input  class="scSave"  type="checkbox" id="melting_point_d"  name="checkbox"  value="1"  /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text" id="melting_point_f"  name="melting_point_f" /></td>
		</tr>
		<tr>
			<td>�������е�(��)</td>
			<td><input  class="scSave ipt"  type="text" id="boiling_point_c"  name="boiling_point_c" /></td>
			<td><input  class="scSave"  type="checkbox" id="boiling_point_t"  name="checkbox"  value="1"  /></td>
			<td><input  class="scSave"  type="checkbox" id="boiling_point_d"  name="checkbox"  value="1"  /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text" id="boiling_point_f"  name="boiling_point_f" /></td>
		</tr>
		<tr>
			<td>��Һ����</td>
			<td><input class="scSave ipt" type="text" id="solid_liquid_identify_c" name="solid_liquid_identify_c" /></td>
			<td><input class="scSave" type="checkbox" id="solid_liquid_identify_t" name="checkbox" value="1" /></td>
			<td><input class="scSave" type="checkbox" id="solid_liquid_identify_d" name="checkbox" value="1" /></td>
			<td colspan = "2"><input class="scSave ipt" type="text" id="solid_liquid_identify_f" name="solid_liquid_identify_f" /></td>
		</tr>
		<tr>
			<td>��ȼ�¶�(��)</td>
			<td><input class="scSave ipt"  type="text"  id="fire_temperature_c"  name="fire_temperature_c" /></td>
			<td><input class="scSave"  type="checkbox" id="fire_temperature_t"  name="checkbox" value="1" /></td>
			<td><input class="scSave"  type="checkbox" id="fire_temperature_d"  name="checkbox" value="1" /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text" id="ire_temperature_f"  name="ire_temperature_f" /></td>
		</tr>
		<tr>
			<td style="width:140px;">������<input class="scSave" style="width:90px;" type="text" id="other_chemist_pram_name" name="other_chemist_pram_name" /></td>
			<td style="width:250px;"><input class="scSave ipt" type="text" id="other_chemist_pram_value" name="other_chemist_pram_value" /></td>
			<td style="width:40px;"><input class="scSave" type="checkbox" id="other_chemist_pram_t" name="checkbox" value="1" /></td>
			<td style="width:40px;"><input class="scSave" type="checkbox" id="other_chemist_pram_d" name="checkbox" value="1" /></td>
			<td colspan = "2"><input class="scSave ipt" type="text" id="other_chemist_pram_f" name="other_chemist_pram_f" /></td>
		</tr>
	</table>
	<table class="tab" border="0" cellspacing="0" cellpadding="0"  align = "center">
		<tr>
		 	<td colspan = "6"><h2 align = "center">�ڶ����� ��ѧƷ����Σ���Է�����Ϣ</h2></td>
		</tr>
		<tr>
		  	<td colspan = "6"><h3>2.1 ��ѧƷ����Σ���Է�����Ϣ</h3></td>
		</tr>
		<tr>
			<td colspan = "2" rowspan = "2">Σ������</td>
			<td rowspan = "2">������</td>
			<td colspan = "3">������Դ</td>
		</tr>
			<tr>
			<td>����</td>
			<td>����</td>
			<td>��������/���׸�����</td>
		</tr>
		<tr>
			<td rowspan = "3">1</td>
			<td style="width:80px" rowspan = "3">��ը��</td>
			<td><label><input class="scSave" type="checkbox" id="explode_classify" name="checkbox" />������</label></td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="explode_t"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="explode_d"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="text" id="explode_f"  name="explode_f" /></td>
		</tr>
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0" class="subTab">
					<tr>
						<td><label><input class="scSave" type="checkbox" id="explode_classify1" name="checkbox" />���ȶ���ը��</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify2" name="checkbox" />1.1��</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify3" name="checkbox" />1.2��</label></td>
					</tr>
					<tr>
						<td><label><input class="scSave" type="checkbox" id="explode_classify4" name="checkbox" />1.3��</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify5" name="checkbox" />1.4��</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify6" name="checkbox" />1.5��</label></td>
					</tr>
					<tr>
						<td colspan="3"><label><input class="scSave" type="checkbox" id="explode_classify7" name="checkbox" />1.6��</label></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="explode_classify8" name="checkbox" />���������</td>
		</tr>
		<tr>
			<td rowspan = "3">2</td>
			<td rowspan = "3">��ȼ����</td>
			<td><input class="scSave" type="checkbox" id="inflammable_gas_classify" name="checkbox" />������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_gas_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_gas_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="inflammable_gas_f" name="inflammable_gas_f" /></td>
		</tr>
		<tr>
			<td>
			<input class="scSave" type="checkbox" id="inflammable_gas_classify1" name="checkbox"/>���1
			<input class="scSave" type="checkbox" id="inflammable_gas_classify2" name="checkbox"/>���2<br/>
			<input class="scSave" type="checkbox" id="inflammable_gas_classify3" name="checkbox"/>���A
			<input class="scSave" type="checkbox" id="inflammable_gas_classify4" name="checkbox"/>���B
			</td>
		</tr> 
		<tr>
			<td><input class="scSave" type="checkbox" id="inflammable_gas_classify5" name="checkbox" />���������</td>
		</tr>
		<tr>
			<td rowspan = "3">3</td>
			<td rowspan = "3">���ܽ�</td>
			<td><input class="scSave" type="checkbox" id="aerosol_classify" name="checkbox" />������</td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="aerosol_t"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="aerosol_d"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="text" id="aerosol_f"  name="aerosol_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="aerosol_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="aerosol_classify2" name="checkbox"/>���2<br/>
				<input class="scSave" type="checkbox" id="aerosol_classify3" name="checkbox"/>���3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="aerosol_classify4" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">4</td>
			<td rowspan = "3">����������</td>
			<td><input class="scSave" type="checkbox" id="Oxidizing_gases_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Oxidizing_gases_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Oxidizing_gases_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Oxidizing_gases_f"  name="Oxidizing_gases_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_gases_classify1" name="checkbox"/>���1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_gases_classify2" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">5</td>
			<td rowspan = "3">��ѹ����</td>
			<td><input class="scSave" type="checkbox" id="gas_pressurized_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="gas_pressurized_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="gas_pressurized_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="gas_pressurized_f" name="gas_pressurized_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="gas_pressurized_classify1" name="checkbox"/>ѹ������
				<input class="scSave" type="checkbox" id="gas_pressurized_classify2" name="checkbox"/>Һ������<br/>
				<input class="scSave" type="checkbox" id="gas_pressurized_classify3" name="checkbox"/>�䶳Һ������
				<input class="scSave" type="checkbox" id="gas_pressurized_classify4" name="checkbox"/>�ܽ�����
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="gas_pressurized_classify5" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">6</td>
			<td rowspan = "3">��ȼҺ��</td>
			<td><input class="scSave" type="checkbox" id="flammable_liquid_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="flammable_liquid_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="flammable_liquid_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="flammable_liquid_f" name="flammable_liquid_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="flammable_liquid_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="flammable_liquid_classify2" name="checkbox"/>���2<br/>
				<input class="scSave" type="checkbox" id="flammable_liquid_classify3" name="checkbox"/>���3
				<input class="scSave" type="checkbox" id="flammable_liquid_classify4" name="checkbox"/>���4
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="flammable_liquid_classify5" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">7</td>
			<td rowspan = "3">��ȼ����</td>
			<td><input class="scSave" type="checkbox" id="inflammable_solid_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_solid_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_solid_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="inflammable_solid_f" name="inflammable_solid_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="inflammable_solid_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="inflammable_solid_classify2" name="checkbox"/>���2
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="inflammable_solid_classify3" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">8</td>
			<td rowspan = "3">�Է�Ӧ���ʺͻ����</td>
			<td><input class="scSave" type="checkbox" id="reactive_substances_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="reactive_substances_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="reactive_substances_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text"  id="reactive_substances_f"  name="reactive_substances_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="reactive_substances_classify1" name="checkbox"/>A��
				<input class="scSave" type="checkbox" id="reactive_substances_classify2" name="checkbox"/>B��
				<input class="scSave" type="checkbox" id="reactive_substances_classify3" name="checkbox"/>C��<br/>
				<input class="scSave" type="checkbox" id="reactive_substances_classify4" name="checkbox"/>D��
				<input class="scSave" type="checkbox" id="reactive_substances_classify5" name="checkbox"/>E��
				<input class="scSave" type="checkbox" id="reactive_substances_classify6" name="checkbox"/>F��<br/>
				<input class="scSave" type="checkbox" id="reactive_substances_classify7" name="checkbox"/>G��
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="reactive_substances_classify8" name="checkbox"/>���������</td>
		</tr> 
		<tr>
			<td rowspan = "3">9</td>
			<td rowspan = "3">��ȼҺ��</td>
			<td><input class="scSave" type="checkbox" id="Pyrophoric_liquids_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Pyrophoric_liquids_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Pyrophoric_liquids_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text"  id="Pyrophoric_liquids_f"  name="Pyrophoric_liquids_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Pyrophoric_liquids_classify1" name="checkbox"/>���1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Pyrophoric_liquids_classify2" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">10</td>
			<td rowspan = "3">��ȼ����</td>
			<td><input class="scSave" type="checkbox" id="fire_solid_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt"   type="checkbox"  id="fire_solid_t"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"   type="checkbox"  id="fire_solid_d"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"   type="text" id="fire_solid_f"  name="fire_solid_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="fire_solid_classify1" name="checkbox"/>���1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="fire_solid_classify2" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">11</td>
			<td rowspan = "3">�������ʺͻ����</td>
			<td><input class="scSave" type="checkbox" id="Self_heating_obj_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Self_heating_obj_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Self_heating_obj_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Self_heating_obj_f" name="Self_heating_obj_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="Self_heating_obj_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="Self_heating_obj_classify2" name="checkbox"/>���2
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Self_heating_obj_classify3" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">12</td>
			<td rowspan = "3">��ˮ�ų���ȼ��������ʺͻ����</td>
			<td><input class="scSave" type="checkbox" id="heat_gases_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="heat_gases_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="heat_gases_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="heat_gases_f" name="heat_gases_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="heat_gases_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="heat_gases_classify2" name="checkbox"/>���2<br/>
				<input class="scSave" type="checkbox" id="heat_gases_classify3" name="checkbox"/>���3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="heat_gases_classify4" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">13</td>
			<td rowspan = "3">������Һ��</td>
			<td><input class="scSave" type="checkbox" id="Oxidizing_liquids_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Oxidizing_liquids_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Oxidizing_liquids_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Oxidizing_liquids_f" name="Oxidizing_liquids_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="Oxidizing_liquids_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="Oxidizing_liquids_classify2" name="checkbox"/>���2<br/>
				<input class="scSave" type="checkbox" id="Oxidizing_liquids_classify3" name="checkbox"/>���3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_liquids_classify4" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">14</td>
			<td rowspan = "3">�����Թ���</td>
			<td><input class="scSave" type="checkbox" id="Oxidizing_solid_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Oxidizing_solid_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Oxidizing_solid_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Oxidizing_solid_f"  name="Oxidizing_solid_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="Oxidizing_solid_classify1" name="checkbox"/>���1
				<input class="scSave" type="checkbox" id="Oxidizing_solid_classify2" name="checkbox"/>���2<br/>
				<input class="scSave" type="checkbox" id="Oxidizing_solid_classify3" name="checkbox"/>���3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_solid_classify4" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">15</td>
			<td rowspan = "3">�л���������</td>
			<td><input class="scSave" type="checkbox" id="hydroperoxides_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="hydroperoxides_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="hydroperoxides_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="hydroperoxides_f"  name="hydroperoxides_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="hydroperoxides_classify1" name="checkbox"/>A��
				<input class="scSave" type="checkbox" id="hydroperoxides_classify2" name="checkbox"/>B��
				<input class="scSave" type="checkbox" id="hydroperoxides_classify3" name="checkbox"/>C��<br/>
				<input class="scSave" type="checkbox" id="hydroperoxides_classify4" name="checkbox"/>D��
				<input class="scSave" type="checkbox" id="hydroperoxides_classify5" name="checkbox"/>E��
				<input class="scSave" type="checkbox" id="hydroperoxides_classify6" name="checkbox"/>F��<br/>
				<input class="scSave" type="checkbox" id="hydroperoxides_classify7" name="checkbox"/>G��
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="hydroperoxides_classify8" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td rowspan = "3">16</td>
			<td rowspan = "3">������ʴ��</td>
			<td><input class="scSave" type="checkbox" id="Metal_corrosion_classify" name="checkbox"/>������</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Metal_corrosion_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Metal_corrosion_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Metal_corrosion_f"  name="Metal_corrosion_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Metal_corrosion_classify1" name="checkbox"/>���1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Metal_corrosion_classify2" name="checkbox"/>���������</td>
		</tr>
		<tr>
			<td colspan = "6"><h3>2.2 ��ѧƷ����Σ���Է�����</h3></td>
		</tr>
		<tr>
			<td  height = "22px" colspan = "6"></td>
		</tr>
		<tr>
			<td  colspan = "6">���฽���������౨�湲����
				<input style="width:50px"  class="scSave"  type="text"  id="file_count"  name="file_count" />�ݸ�����
			</td>
		</tr>
		<tr>
			<td colspan = "6">��ˣ�ǩ�֣���
				<input class="scSave"  type="text"  id="fill_people"  name="fill_people" /><br/><br/>
				��λ�����ˣ�ǩ�֣���
				<input class="scSave"  type="text"  id="RESPONSIBLE_PERSON"  name="RESPONSIBLE_PERSON" /><br/><br/>
				<div align = "right">
					�����൥λ���£�<br/><br/>�������ڣ�
					<input class= "Wdate scSave"  type="text"  id="seal_date"  name="seal_date"  onclick="WdatePicker()"/> 
				</div>
			</td>
		</tr>
	</table>
	
	<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
		CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
		codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  ��ӡ�ؼ�����ʧ�� 
	</OBJECT>
	
	<div align="center" style="margin:20px">
		<input class="scBtn" type="button" value="����" onClick="saveForm()" id="saveButton" />
		<input class="scBtn" type="button" value="����" onClick="backToList()" />
		<input class="scBtn" type="button" value="��ӡ" onClick="printClick()" />
		<input class="scBtn" type="button" value="����" onClick="downLoadClick()" /> 
	</div>  

	<!--  
		<div>
	    <h1 align="center">��  ��  ˵  ��</h1>
	    <h2>һ������Ҫ��</h2>
	    <p>��һ������ϵ�м���ʱ����ҵӦ��Ϊϵ�м�����ÿ�ֻ�ѧƷ��д�����౨�档</p>
	    <p>����������ѡ������ѡ�����ڡ�����ǰ��?����</p>
	    <p>������������桰�������ڡ����������š��ɹ��Ұ�ȫ�����ල�����ֻܾ�ѧƷ�Ǽ�������д��</p>
	    <h2>������λ����</h2>
	    <p>���桰��λ���ԡ����ݵ�λ������������ա��������������ڡ�����ʹ�á�������Ӫ���������ڣ����������桱�������䡱��
	    ����������˳��ѡ����д���������������λ���ڻ�ѧƷ������λ��ͬʱ�ֽ��ڻ�ѧƷ������ʹ�û�ѧƷ�������д����������</p>
	  	<h2>������ѧƷ������Ϣ</h2>
	    <p>��һ���������Ϣ��������дŨ�ȳ���1���������Ϣ�������Һ��Ϊ�����ٷֺ���������Ϊ����ٷֺ�������</p>
	    <p>��������״̬�����У�����ġ���̬����������д��ѧƷ�������̬���磺���ɷ�ĩ����״С������Ƭ״����ȡ�</p>
	    <h2>�ġ���ѧƷ����Σ���Է���</h2>
	    <p>��һ����������ָ���ݡ�Σ�ջ�ѧƷĿ¼���͡���ѧƷ����ͱ�ǩ�淶��ϵ�й��ұ�׼��GB 30000.2��30000.17��
		��������ݣ����������������ṩ��������Ϣ���������ۺ��Է�����ó��Ļ�ѧƷ����Σ���Է���Ľ����</p>
	    <p>�������á�����ָ�÷��಻�����ڶ�Ӧ�ġ�Σ�����ࡱ�������Һ����Ʒ����д����ȼ���塱���ķ�����ʱӦ��д�������á�����Ҫʱ��Ӧ�ڡ���������/���׸����š���ע�����ɡ�</p>
	    <p>����������ࡱ����ָ���ݡ�Σ�ջ�ѧƷĿ¼���͡���ѧƷ����ͱ�ǩ�淶��ϵ�й��ұ�׼��GB 30000.2��30000.17����
		�û�ѧƷ��Σ�ճ̶�δ�ﵽ��Σ������һ���ķ����׼���������Ӧ��Σ�������ࡣ</p>
	    <p>�����������ԡ���ָ���Ұ�ȫ�����ල�����ֹܾ���ļ����������ԵĽ�����߹���GLPʵ���Ҳ��Խ����������Դ�ڹ���GLPʵ���ҵģ���Ҫ�ṩʵ��������֤����</p>
	    <p>�����������ס���ָ��Դ�ڹ�����Ȩ������Դ�����ݣ�������ѧƷ��ȫ����˵�����дָ�ϡ���GB 17519����¼B</p>
	    <h2>�塢��ѧƷ����Σ���Է�����</h2>
	    <p>�����г�����2.1��ѧƷ����Σ���Է�����Ϣ���еķ����������磺����ȼҺ�壬���3��</p>
	    <p>������ʴ����1����</p>
	    <h2>�������฽����Ҫ��</h2>
	    <p>��һ������ֻ��ʹ�����ġ�����Դ�ڹ���GLPʵ���Ҳ��Խ�����������ף����ṩ������Ŀ�����鷽��������������黷����������Ϣ�ȷ�������ķ����Ҫ������ԭ�ġ�</p>
	    <p>������ÿ�ݸ�����ҳ�����ϽǾ�Ӧ��Ŀ�ر�ע������š������Ű����з�ʽ��д����������ţ��ø���ҳ�����������硰����3��8ҳ������</p>
	    <p>���������и�����ÿҳ��ҳ��׶˾���λ�ö�����ҳ�롣�������ӡ�ģ������涼Ӧ����ҳ�롣</p>
	    <p>���ģ����������฽����ÿ�ݸ�������ҳ�ͽ���ҳ��Ӧ�ӸǷ��൥λ�Ĺ��¡�</p> 
	    </div>
	 --> 
  </body> 
</html>