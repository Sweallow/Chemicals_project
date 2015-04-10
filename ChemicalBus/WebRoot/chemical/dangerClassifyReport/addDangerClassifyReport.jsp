<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML >
<html>
  <head>
    <title>添加化学品物理危险性分类报告</title>
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
					//修改,加载页面数据
					loadPageData(scid);
					$("#scid").val(scid);
				} else {
					//新增
					$("#userId").val(sc.user.scid);
					//新增的默认为待审核
					$("#scstatus").val("0");
					//新增的不显示驳回原因
					$("#rsn").attr({style:"display:none"});
					$("#back_reason").attr({style:"display:none"});
				}
			});
			
			//修改
			var loadPageData = function(scid) {
				//得到并封装数据字段
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
				//读取表单数据，并为表单赋值
				ServiceBreak(scClassName, "loadFormData", [ JSON.stringify(tableObj) ],
						function(data) {
							if (data == null)
								return;
							for (var j = 0; j < data.columns.length; j++) {
								var column = data.columns[j];
								$("#" + column.columnName).val(column.columnValue);
								//获取多选按钮的值，设置多选按钮勾选状态
								var box = $("[type='checkbox']");
								for (var i = 0; i < box.length; i++) {
									if ( box[i].value=="0") {
										box[i].checked = true;
									}
								}
							}
							//判断审核状态，“1”为审核通过的
							if($("#scstatus").val() == "1"){
								//sc.alert("该记录已审核结束,不能再进行修改!");
								
								//设置一般input输入框及文本编辑框失去焦点
								$("input").attr({onfocus:"this.blur()"});
								$("textarea").attr({onfocus:"this.blur()"});
								//设置时间输入框的onclick事件为空
								$("#acceptance_date").attr({onclick:"''"});
								$("#compile_date").attr({onclick:"''"});
								$("#seal_date").attr({onclick:"''"});
								//隐藏保存按钮
								$("#saveButton").attr({style:"display:none"});
							}
							//“-1”为驳回的,非驳回的数据隐藏back_reason文本域
							if($("#scstatus").val() != "-1"){
								$("#rsn").attr({style:"display:none"});
								$("#back_reason").attr({style:"display:none"});
							}
						});
			};
			
			//保存
			var saveForm = function() {
				//设置进度条
				var d = dialog({
				    content: "保存中...",
				});
				//显示进度条
				d.showModal();
				var scid = $("#scid").val();
				//获取状态值
				var scstatus = $("#scstatus").val();
				//多选框1表示未选中，0表示选中。
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
				//取消进度条
				d.remove();
				//1、先保存数据
				ServiceBreakSyn(scClassName, "saveFormData",[JSON.stringify(tableObj)]);
				//2、再更改审核状态
				if(scstatus == "-1"){
					//alert("这是一条驳回数据");
					ServiceBreakSyn(scClassName, "updateScstatus", ["0",scid]);
				}
				window.location.href = sc.basePath 
					+ "chemical/dangerClassifyReport/dangerClassifyReportShowList.jsp";
			};
			
			//======返回列表界面==========
			function backToList() {
				window.location = sc.basePath
						+ "chemical/dangerClassifyReport/dangerClassifyReportShowList.jsp";
			}
			
			//===========打印===========
			var printClick = function() {
				var ctrl = document.getElementById('ctrl');
				if (!ctrl) {
			        sc.alert("下载失败，请重试！");
			    }
				//word文件的全路径，只支持.doc文件。不支持.docx文件
				var strWordPathFile = sc.basePath + "recourse/fj2.doc";
				//表单内容的JSON数组
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
						//判断input是否为复选框
			            if (input[i].type == "checkbox") {
			                if(input[i].checked){
								strKong = "{@}";
								column = ",[\"1\",\"[" + columnName + "]\",\"" + strKong + "\"]";
							} else {
								strKong="□";
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
			
			//===========下载===========
			function downLoadClick() {
				var ctrl = document.getElementById('ctrl');
				if (!ctrl) {
			        sc.alert("下载失败，请重试！");
			    }
				//word文件的全路径，只支持.doc文件。不支持.docx文件
				var strWordPathFile = sc.basePath + "recourse/fj2.doc";
				//表单内容的JSON数组
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
						//判断input是否为复选框
			            if (input[i].type == "checkbox") {
			                if(input[i].checked){
								strKong = "{@}";
								column = ",[\"1\",\"[" + columnName + "]\",\"" + strKong + "\"]";
							} else {
								strKong="□";
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
		<div id="rsn"><h3>驳回原因如下：</h3></div>
   		<p>
   			<textarea rows="3" cols="70" class="scSave" id="back_reason" name="back_reason"></textarea>
   		</p>
	</div>
	<table align = "center" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class = "front" >报告编号：</td>
			<td><input  class="scSave" type="text" id="repport_no" align = "left" name="repport_no" /></td>
		</tr>
		<tr>
			<td class = "front" >受理日期：</td>
			<td style="width:400px"><input class= "Wdate scSave" type="text" id="acceptance_date" name="acceptance_date" onclick="WdatePicker()"/></td>
			<td class = "front" >受理编号：</td>
			<td><input class="scSave ipt"  type="text" id="acceptance_no"   name="acceptance_no" /></td>
		</tr>
	</table>
	<table border="0" align="center" border="0" cellspacing="0" cellpadding="0"> 
		<tr>
			<td  class = "title1"  colspan = "2" >化学品物理危险性分类报告</td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">化学品名称：</td>
			<td height = "24px" align = "center"><input class="scSave ipt" type="text" id="chemist_name" name="chemist_name" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;单位名称：</td>
			<td height = "24px" align = "center"><input class="scSave ipt"  type="text" id="unit_name"  name="unit_name" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px" align = "center">&nbsp;&nbsp;&nbsp;&nbsp;单位属性：</td>
			<td height = "24px"  align ="center"><input class="scSave ipt" type="text" id="unit_property" name="unit_property" /></td>
		</tr>
		<tr>
			<td class = "front"  height ="24px" align = "center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;经办人：</td>
			<td height = "24px"  align ="center"><input class="scSave ipt" type="text" id="executePeople" name="executePeople" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;联系电话：</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="phone" name="phone" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;移动电话：</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="mobilePhone" name="mobilePhone" /></td>
		</tr>
		<tr>
			<td class = "front"  height = "24px"  align = "center">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;传真：
			</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="fax"  name="fax" /></td>
		</tr>		
		<tr>
			<td class = "front"  height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;电子邮箱：</td>
			<td height = "24px"  align = "center"><input class="scSave ipt"  type="text" id="email"  name="email" /></td>
		</tr>
		<tr>
			<td class = "front" height = "24px"  align = "center">&nbsp;&nbsp;&nbsp;&nbsp;编制日期：</td>
			<td height = "24px" align = "center">
				<input  class= "Wdate scSave ipt"  type="text" id="compile_date" name="compile_date" onclick="WdatePicker()"/>
			</td>
		</tr>
		<tr>
			<td height = "100px"  class = "title2"  colspan = "2">国家安全生产监督管理总局制样</td>
		</tr>
	</table>
	<table class="tab" border="0" cellspacing="0" cellpadding="0"  align = "center">
		<tr>
			<td colspan = "6"><h2 align="center">第一部分 化学品信息</h2></td>
		</tr>	
		<tr>
			<td colspan = "6"><h3>1.1 化学品基本信息</h3></td>
		</tr>	
		<tr>
			<td>中文名称</td>
			<td colspan = "5"><input class="scSave ipt"  type="text" id="chnName"  name="chnName" /></td>
		</tr>	
		<tr>
			<td >英文名称</td>
			<td colspan = "5"><input class="scSave ipt"  type="text" id="chnEngName"   name="chnEngName" /></td>
		</tr>
		<tr>
			<td>中文别名</td>
			<td colspan = "5"><input class="scSave ipt"  type="text" id="chnAlies"   name="chnAlies" /></td>
		</tr>
		<tr>
			<td rowspan = "5">分组信息</td>
			<td style="width:32px;">序号</td>
			<td style="width:200px;">组分名称</td>
			<td style="width:120px;">CAS号</td>
			<td>含量（%）</td>
			<td style="width:40px;">是否<br/>保密</td>
		</tr>
		<tr>
			<td>1</td>
			<td><input class="scSave ipt"  type="text"  id="component_name1"  name="component_name1" /></td>
			<td><input class="scSave ipt"  type="text"  id="component_cas1"  name="component_cas1" /></td>
			<td><input class="scSave ipt"  type="text"  id="component_percent1"  name="component_percent1" /></td>
			<td>
				<label>
					<input class="scSave"  type="checkbox"  id="component_secret1"  name="checkbox"  value="1" />是
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
					<input class="scSave"  type="checkbox" id="component_secret2"  name="checkbox"  value="1"  />是
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
					<input class="scSave"  type="checkbox" id="component_secret3"  name="checkbox"  value="1"  />是
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
					<input class="scSave"  type="checkbox" id="component_secret4"  name="checkbox"  value="1"  />是
				</label>
			</td>
		</tr>
		<tr>
			<td>状态</td>
			<td colspan = "5">
				<label><input class="scSave" id="status_name" value = "固体" type="checkbox"  name = "checkbox" />固体</label>，形态描述
				<input style="width:350px;" class="scSave ipt" type="text"  id="status_solid_desc"  name="status_solid_desc" /><br />
				<label><input class="scSave" id="status_name1" value = "液体"  type="checkbox"  name = "checkbox"  />液体</label>，
				<label><input class="scSave" id="status_name2" value = "气体"  type="checkbox"   name = "checkbox" />气体</label>，
				<label><input class="scSave" id="status_name3" value = "其他形态 "  type="checkbox"  name = "checkbox"   />其它形态</label>
				<input style="width:265px;" class="scSave ipt"   type="text" id ="other_status_name"  name="other_status_name" /><br />
				颜色：<input style="width:190px;" class="scSave ipt"  type="text"  id="status_color"   name="status_color" />&nbsp;
				气味：<input style="width:190px;" class="scSave ipt"  type="text"  id="status_smile"  name="status_smile" />
			</td>
		</tr>
		<tr>
			<td>用途</td>
			<td colspan = "5"><input class="scSave ipt"  type="text"  id="useness"  name="useness" /></td>
		</tr>	
		<tr>
			<td>生产单位名称</td>
			<td colspan = "5"><input class="scSave ipt"  type="text"  id ="product_unit_name"  name="product_unit_name" /></td>
		</tr>
	</table>
	<table class="tab" border="0" cellspacing="0" cellpadding="0"  align = "center">
		<tr>
			<td colspan = "6"><h3>1.2 化学品理化特性参数</h3></td>
		</tr>
		<tr>
			<td>项目</td>
			<td>结果</td>
			<td>测试</td>
			<td>文献</td>
			<td colspan = "2">测试报告/文献附件号</td>
		</tr>
		<tr>
			<td>蒸气压(kPa)</td>
			<td><input  class="scSave ipt"  type="text" id="vapour_pressure_c"  name="vapour_pressure_c" /></td>
			<td><input  class="scSave"  type="checkbox" id="vapour_pressure_t"  name="checkbox"  value="1"  /></td>
			<td><input  class="scSave"  type="checkbox" id="vapour_pressure_d"  name="checkbox"  value="1"  /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text"  id="vapour_pressure_f"  name="vapour_pressure_f" /></td>
		</tr>
		<tr>
			<td>熔点(℃)</td>
			<td><input  class="scSave ipt"  type="text"  id="melting_point_c"  name="melting_point_c" /></td>
			<td><input  class="scSave"  type="checkbox" id="melting_point_t"  name="checkbox"  value="1"  /></td>
			<td><input  class="scSave"  type="checkbox" id="melting_point_d"  name="checkbox"  value="1"  /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text" id="melting_point_f"  name="melting_point_f" /></td>
		</tr>
		<tr>
			<td>（初）沸点(℃)</td>
			<td><input  class="scSave ipt"  type="text" id="boiling_point_c"  name="boiling_point_c" /></td>
			<td><input  class="scSave"  type="checkbox" id="boiling_point_t"  name="checkbox"  value="1"  /></td>
			<td><input  class="scSave"  type="checkbox" id="boiling_point_d"  name="checkbox"  value="1"  /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text" id="boiling_point_f"  name="boiling_point_f" /></td>
		</tr>
		<tr>
			<td>固液鉴别</td>
			<td><input class="scSave ipt" type="text" id="solid_liquid_identify_c" name="solid_liquid_identify_c" /></td>
			<td><input class="scSave" type="checkbox" id="solid_liquid_identify_t" name="checkbox" value="1" /></td>
			<td><input class="scSave" type="checkbox" id="solid_liquid_identify_d" name="checkbox" value="1" /></td>
			<td colspan = "2"><input class="scSave ipt" type="text" id="solid_liquid_identify_f" name="solid_liquid_identify_f" /></td>
		</tr>
		<tr>
			<td>自燃温度(℃)</td>
			<td><input class="scSave ipt"  type="text"  id="fire_temperature_c"  name="fire_temperature_c" /></td>
			<td><input class="scSave"  type="checkbox" id="fire_temperature_t"  name="checkbox" value="1" /></td>
			<td><input class="scSave"  type="checkbox" id="fire_temperature_d"  name="checkbox" value="1" /></td>
			<td colspan = "2"><input  class="scSave ipt"  type="text" id="ire_temperature_f"  name="ire_temperature_f" /></td>
		</tr>
		<tr>
			<td style="width:140px;">其他：<input class="scSave" style="width:90px;" type="text" id="other_chemist_pram_name" name="other_chemist_pram_name" /></td>
			<td style="width:250px;"><input class="scSave ipt" type="text" id="other_chemist_pram_value" name="other_chemist_pram_value" /></td>
			<td style="width:40px;"><input class="scSave" type="checkbox" id="other_chemist_pram_t" name="checkbox" value="1" /></td>
			<td style="width:40px;"><input class="scSave" type="checkbox" id="other_chemist_pram_d" name="checkbox" value="1" /></td>
			<td colspan = "2"><input class="scSave ipt" type="text" id="other_chemist_pram_f" name="other_chemist_pram_f" /></td>
		</tr>
	</table>
	<table class="tab" border="0" cellspacing="0" cellpadding="0"  align = "center">
		<tr>
		 	<td colspan = "6"><h2 align = "center">第二部分 化学品物理危险性分类信息</h2></td>
		</tr>
		<tr>
		  	<td colspan = "6"><h3>2.1 化学品物理危险性分类信息</h3></td>
		</tr>
		<tr>
			<td colspan = "2" rowspan = "2">危险种类</td>
			<td rowspan = "2">分类结果</td>
			<td colspan = "3">数据来源</td>
		</tr>
			<tr>
			<td>测试</td>
			<td>文献</td>
			<td>鉴定报告/文献附件号</td>
		</tr>
		<tr>
			<td rowspan = "3">1</td>
			<td style="width:80px" rowspan = "3">爆炸物</td>
			<td><label><input class="scSave" type="checkbox" id="explode_classify" name="checkbox" />不适用</label></td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="explode_t"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="explode_d"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="text" id="explode_f"  name="explode_f" /></td>
		</tr>
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0" class="subTab">
					<tr>
						<td><label><input class="scSave" type="checkbox" id="explode_classify1" name="checkbox" />不稳定爆炸物</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify2" name="checkbox" />1.1项</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify3" name="checkbox" />1.2项</label></td>
					</tr>
					<tr>
						<td><label><input class="scSave" type="checkbox" id="explode_classify4" name="checkbox" />1.3项</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify5" name="checkbox" />1.4项</label></td>
						<td><label><input class="scSave" type="checkbox" id="explode_classify6" name="checkbox" />1.5项</label></td>
					</tr>
					<tr>
						<td colspan="3"><label><input class="scSave" type="checkbox" id="explode_classify7" name="checkbox" />1.6项</label></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="explode_classify8" name="checkbox" />不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">2</td>
			<td rowspan = "3">易燃气体</td>
			<td><input class="scSave" type="checkbox" id="inflammable_gas_classify" name="checkbox" />不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_gas_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_gas_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="inflammable_gas_f" name="inflammable_gas_f" /></td>
		</tr>
		<tr>
			<td>
			<input class="scSave" type="checkbox" id="inflammable_gas_classify1" name="checkbox"/>类别1
			<input class="scSave" type="checkbox" id="inflammable_gas_classify2" name="checkbox"/>类别2<br/>
			<input class="scSave" type="checkbox" id="inflammable_gas_classify3" name="checkbox"/>类别A
			<input class="scSave" type="checkbox" id="inflammable_gas_classify4" name="checkbox"/>类别B
			</td>
		</tr> 
		<tr>
			<td><input class="scSave" type="checkbox" id="inflammable_gas_classify5" name="checkbox" />不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">3</td>
			<td rowspan = "3">气溶胶</td>
			<td><input class="scSave" type="checkbox" id="aerosol_classify" name="checkbox" />不适用</td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="aerosol_t"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="checkbox" id ="aerosol_d"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"  type="text" id="aerosol_f"  name="aerosol_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="aerosol_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="aerosol_classify2" name="checkbox"/>类别2<br/>
				<input class="scSave" type="checkbox" id="aerosol_classify3" name="checkbox"/>类别3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="aerosol_classify4" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">4</td>
			<td rowspan = "3">氧化性气体</td>
			<td><input class="scSave" type="checkbox" id="Oxidizing_gases_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Oxidizing_gases_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Oxidizing_gases_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Oxidizing_gases_f"  name="Oxidizing_gases_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_gases_classify1" name="checkbox"/>类别1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_gases_classify2" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">5</td>
			<td rowspan = "3">加压气体</td>
			<td><input class="scSave" type="checkbox" id="gas_pressurized_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="gas_pressurized_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="gas_pressurized_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="gas_pressurized_f" name="gas_pressurized_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="gas_pressurized_classify1" name="checkbox"/>压缩气体
				<input class="scSave" type="checkbox" id="gas_pressurized_classify2" name="checkbox"/>液化气体<br/>
				<input class="scSave" type="checkbox" id="gas_pressurized_classify3" name="checkbox"/>冷冻液化气体
				<input class="scSave" type="checkbox" id="gas_pressurized_classify4" name="checkbox"/>溶解气体
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="gas_pressurized_classify5" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">6</td>
			<td rowspan = "3">易燃液体</td>
			<td><input class="scSave" type="checkbox" id="flammable_liquid_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="flammable_liquid_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="flammable_liquid_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="flammable_liquid_f" name="flammable_liquid_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="flammable_liquid_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="flammable_liquid_classify2" name="checkbox"/>类别2<br/>
				<input class="scSave" type="checkbox" id="flammable_liquid_classify3" name="checkbox"/>类别3
				<input class="scSave" type="checkbox" id="flammable_liquid_classify4" name="checkbox"/>类别4
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="flammable_liquid_classify5" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">7</td>
			<td rowspan = "3">易燃固体</td>
			<td><input class="scSave" type="checkbox" id="inflammable_solid_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_solid_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="inflammable_solid_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="inflammable_solid_f" name="inflammable_solid_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="inflammable_solid_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="inflammable_solid_classify2" name="checkbox"/>类别2
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="inflammable_solid_classify3" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">8</td>
			<td rowspan = "3">自反应物质和混合物</td>
			<td><input class="scSave" type="checkbox" id="reactive_substances_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="reactive_substances_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="reactive_substances_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text"  id="reactive_substances_f"  name="reactive_substances_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="reactive_substances_classify1" name="checkbox"/>A型
				<input class="scSave" type="checkbox" id="reactive_substances_classify2" name="checkbox"/>B型
				<input class="scSave" type="checkbox" id="reactive_substances_classify3" name="checkbox"/>C型<br/>
				<input class="scSave" type="checkbox" id="reactive_substances_classify4" name="checkbox"/>D型
				<input class="scSave" type="checkbox" id="reactive_substances_classify5" name="checkbox"/>E型
				<input class="scSave" type="checkbox" id="reactive_substances_classify6" name="checkbox"/>F型<br/>
				<input class="scSave" type="checkbox" id="reactive_substances_classify7" name="checkbox"/>G型
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="reactive_substances_classify8" name="checkbox"/>不分入此类</td>
		</tr> 
		<tr>
			<td rowspan = "3">9</td>
			<td rowspan = "3">自燃液体</td>
			<td><input class="scSave" type="checkbox" id="Pyrophoric_liquids_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Pyrophoric_liquids_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Pyrophoric_liquids_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text"  id="Pyrophoric_liquids_f"  name="Pyrophoric_liquids_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Pyrophoric_liquids_classify1" name="checkbox"/>类别1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Pyrophoric_liquids_classify2" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">10</td>
			<td rowspan = "3">自燃固体</td>
			<td><input class="scSave" type="checkbox" id="fire_solid_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt"   type="checkbox"  id="fire_solid_t"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"   type="checkbox"  id="fire_solid_d"  name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt"   type="text" id="fire_solid_f"  name="fire_solid_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="fire_solid_classify1" name="checkbox"/>类别1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="fire_solid_classify2" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">11</td>
			<td rowspan = "3">自热物质和混合物</td>
			<td><input class="scSave" type="checkbox" id="Self_heating_obj_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Self_heating_obj_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Self_heating_obj_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Self_heating_obj_f" name="Self_heating_obj_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="Self_heating_obj_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="Self_heating_obj_classify2" name="checkbox"/>类别2
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Self_heating_obj_classify3" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">12</td>
			<td rowspan = "3">遇水放出易燃气体的物质和混合物</td>
			<td><input class="scSave" type="checkbox" id="heat_gases_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="heat_gases_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="heat_gases_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="heat_gases_f" name="heat_gases_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="heat_gases_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="heat_gases_classify2" name="checkbox"/>类别2<br/>
				<input class="scSave" type="checkbox" id="heat_gases_classify3" name="checkbox"/>类别3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="heat_gases_classify4" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">13</td>
			<td rowspan = "3">氧化性液体</td>
			<td><input class="scSave" type="checkbox" id="Oxidizing_liquids_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Oxidizing_liquids_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id ="Oxidizing_liquids_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Oxidizing_liquids_f" name="Oxidizing_liquids_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="Oxidizing_liquids_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="Oxidizing_liquids_classify2" name="checkbox"/>类别2<br/>
				<input class="scSave" type="checkbox" id="Oxidizing_liquids_classify3" name="checkbox"/>类别3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_liquids_classify4" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">14</td>
			<td rowspan = "3">氧化性固体</td>
			<td><input class="scSave" type="checkbox" id="Oxidizing_solid_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Oxidizing_solid_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Oxidizing_solid_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Oxidizing_solid_f"  name="Oxidizing_solid_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="Oxidizing_solid_classify1" name="checkbox"/>类别1
				<input class="scSave" type="checkbox" id="Oxidizing_solid_classify2" name="checkbox"/>类别2<br/>
				<input class="scSave" type="checkbox" id="Oxidizing_solid_classify3" name="checkbox"/>类别3
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Oxidizing_solid_classify4" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">15</td>
			<td rowspan = "3">有机过氧化物</td>
			<td><input class="scSave" type="checkbox" id="hydroperoxides_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="hydroperoxides_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="hydroperoxides_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="hydroperoxides_f"  name="hydroperoxides_f" /></td>
		</tr>
		<tr>
			<td>
				<input class="scSave" type="checkbox" id="hydroperoxides_classify1" name="checkbox"/>A型
				<input class="scSave" type="checkbox" id="hydroperoxides_classify2" name="checkbox"/>B型
				<input class="scSave" type="checkbox" id="hydroperoxides_classify3" name="checkbox"/>C型<br/>
				<input class="scSave" type="checkbox" id="hydroperoxides_classify4" name="checkbox"/>D型
				<input class="scSave" type="checkbox" id="hydroperoxides_classify5" name="checkbox"/>E型
				<input class="scSave" type="checkbox" id="hydroperoxides_classify6" name="checkbox"/>F型<br/>
				<input class="scSave" type="checkbox" id="hydroperoxides_classify7" name="checkbox"/>G型
			</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="hydroperoxides_classify8" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td rowspan = "3">16</td>
			<td rowspan = "3">金属腐蚀物</td>
			<td><input class="scSave" type="checkbox" id="Metal_corrosion_classify" name="checkbox"/>不适用</td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Metal_corrosion_t" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="checkbox" id="Metal_corrosion_d" name="checkbox" /></td>
			<td rowspan = "3"><input class="scSave ipt" type="text" id="Metal_corrosion_f"  name="Metal_corrosion_f" /></td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Metal_corrosion_classify1" name="checkbox"/>类别1</td>
		</tr>
		<tr>
			<td><input class="scSave" type="checkbox" id="Metal_corrosion_classify2" name="checkbox"/>不分入此类</td>
		</tr>
		<tr>
			<td colspan = "6"><h3>2.2 化学品物理危险性分类结果</h3></td>
		</tr>
		<tr>
			<td  height = "22px" colspan = "6"></td>
		</tr>
		<tr>
			<td  colspan = "6">分类附件：本分类报告共包含
				<input style="width:50px"  class="scSave"  type="text"  id="file_count"  name="file_count" />份附件。
			</td>
		</tr>
		<tr>
			<td colspan = "6">填报人（签字）：
				<input class="scSave"  type="text"  id="fill_people"  name="fill_people" /><br/><br/>
				单位负责人（签字）：
				<input class="scSave"  type="text"  id="RESPONSIBLE_PERSON"  name="RESPONSIBLE_PERSON" /><br/><br/>
				<div align = "right">
					（分类单位公章）<br/><br/>盖章日期：
					<input class= "Wdate scSave"  type="text"  id="seal_date"  name="seal_date"  onclick="WdatePicker()"/> 
				</div>
			</td>
		</tr>
	</table>
	
	<OBJECT ID="ctrl" style="display: none;" WIDTH=635 HEIGHT=20 
		CLASSID="CLSID:45FCD23F-B1FE-4887-A22B-36E6F7282C23" 
		codebase='<%=basePath%>sc/res/HXPPrint.ocx#version=1.0.0.1' VIEWASTEXT>  打印控件加载失败 
	</OBJECT>
	
	<div align="center" style="margin:20px">
		<input class="scBtn" type="button" value="保存" onClick="saveForm()" id="saveButton" />
		<input class="scBtn" type="button" value="返回" onClick="backToList()" />
		<input class="scBtn" type="button" value="打印" onClick="printClick()" />
		<input class="scBtn" type="button" value="下载" onClick="downLoadClick()" /> 
	</div>  

	<!--  
		<div>
	    <h1 align="center">填  表  说  明</h1>
	    <h2>一、基本要求</h2>
	    <p>（一）属于系列鉴定时，企业应当为系列鉴定的每种化学品编写本分类报告。</p>
	    <p>（二）表中选择框如果选定则在“□”前打“?”。</p>
	    <p>（三）本表封面“受理日期”、“受理编号”由国家安全生产监督管理总局化学品登记中心填写。</p>
	    <h2>二、单位属性</h2>
	    <p>封面“单位属性”根据单位基本情况，按照“生产”、“进口”、“使用”、“经营（不含进口）”、“储存”、“运输”、
	    “其他”的顺序选择填写。例如申请鉴定单位属于化学品生产单位，同时又进口化学品，或者使用化学品，则仅填写“生产”。</p>
	  	<h2>三、化学品基本信息</h2>
	    <p>（一）“组分信息”栏，填写浓度超过1％的组分信息（固体和液体为质量百分含量，气体为体积百分含量）。</p>
	    <p>（二）“状态”栏中，固体的“形态描述”中填写化学品具体的形态，如：疏松粉末、球状小颗粒、片状晶体等。</p>
	    <h2>四、化学品物理危险性分类</h2>
	    <p>（一）分类结果是指根据《危险化学品目录》和《化学品分类和标签规范》系列国家标准（GB 30000.2～30000.17）
		和相关数据（包括鉴定报告中提供的数据信息），进行综合性分析后得出的化学品物理危险性分类的结果。</p>
	    <p>“不适用”，是指该分类不适用于对应的“危险种类”，例如对液体样品，填写“易燃固体”栏的分类结果时应填写“不适用”，必要时，应在“鉴定报告/文献附件号”栏注明理由。</p>
	    <p>“不分入此类”，是指根据《危险化学品目录》和《化学品分类和标签规范》系列国家标准（GB 30000.2～30000.17），
		该化学品的危险程度未达到该危险性任一类别的分类标准，不分入对应的危险性种类。</p>
	    <p>（二）“测试”是指国家安全生产监督管理总局公告的鉴定机构测试的结果或者国外GLP实验室测试结果。数据来源于国外GLP实验室的，需要提供实验室资质证明。</p>
	    <p>（三）“文献”是指来源于国内外权威数据源的数据，见《化学品安全技术说明书编写指南》（GB 17519）附录B</p>
	    <h2>五、化学品物理危险性分类结果</h2>
	    <p>依次列出本表“2.1化学品物理危险性分类信息”中的分类结果，例如：“易燃液体，类别3；</p>
	    <p>金属腐蚀物，类别1”。</p>
	    <h2>六、分类附件的要求</h2>
	    <p>（一）附件只能使用中文。对来源于国外GLP实验室测试结果或外文文献，需提供试验项目、试验方法、检测结果、试验环境、仪器信息等方面的中文翻译概要，并附原文。</p>
	    <p>（二）每份附件首页的右上角均应醒目地标注附件编号。附件号按下列方式编写：“附件序号（该附件页数）”，例如“附件3（8页）”。</p>
	    <p>（三）所有附件中每页的页面底端居中位置都编上页码。正反面打印的，正反面都应编上页码。</p>
	    <p>（四）对于文献类附件，每份附件的首页和结论页都应加盖分类单位的公章。</p> 
	    </div>
	 --> 
  </body> 
</html>