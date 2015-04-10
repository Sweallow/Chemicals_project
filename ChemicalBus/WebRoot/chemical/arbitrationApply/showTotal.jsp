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
	<script type="text/javascript" src="sc/res/highcharts.js"></script>
	<script type="text/javascript" src="sc/res/exporting.js"></script>
    <script type="text/javascript">
    	var scClassName = "com.sc.arbitrationApply.service.ArbirtationApplyService";
    	//��ʾ���ݵ�����ͼ
    	function showTable(total){
    		$('#container').highcharts({
		        chart: {
		            type: 'line',
		        },
		        credits:{enabled:false},//���½�ͼ��
		        exporting:{enabled:false},//���ϽǴ�ӡ����ͼ��
		        title: {
		            text: '������ȼ����ٲ���������ͳ��'
		        },
		        subtitle: {
		            text: ''
		        },
		        xAxis: {
		            categories: ['һ��', '����', '����', '����', '����', '����', '����', '����', '����', 'ʮ��', 'ʮһ��', 'ʮ����']
		        },
		        yAxis: {
		            title: {
		                text: 'ÿ�������� (��)'
		            },
		            min:0,
		            allowDecimals:false
		        },
		        plotOptions: {
		            line: {
		                dataLabels: {
		                    enabled: true
		                },
		                enableMouseTracking: false
		            }
		        },
		        series: total,
		    });
    	}
    	//��ѯ����ʾ���ݵ�����ͼ
    	function selTotal(){
    		ServiceBreak(scClassName, "selTotal", [""], function(data){
    				//var total = [{name: '2014',data: data}];
    				//alert(data[0][0]);
    				var totalArr = new Array(data.length);
    					for(var i=0; i<data.length; i++){
    						var year = ""+data[i][0];
    						var dataArr = new Array(12);
    						for(var j=0; j<12; j++){
    							dataArr[j] = data[i][j+1];
    						}
    						var dataObj = {name:year, data:dataArr};
    				 		totalArr[i] = dataObj;
    					}
    				total = totalArr;
    				showTable(total);
    		});
    	}
    	
    	$(function () {
    		selTotal();
		});				
	</script>
  </head>
  
  <body>
	<div id = "container" style="min-width:700px;height:428px"></div>
  </body>
</html>
