<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html >
  <head>
	<base href="<%=basePath%>">
    <%@ include file="/sc/common.jsp"%>
    <title>化学品物理危险性分类仲裁申请表统计分析</title>
	<script type="text/javascript" src="sc/res/jquery-1.8.3.js"></script>
  	<script type="text/javascript" src="sc/res/highcharts.js"></script> 
  	<script type="text/javascript">
	 	var scClassName = "chemical.service.ChemicalApplicationService";	
	    //查询并显示数据到折线图
	    function selTotal(){
	   		ServiceBreak(scClassName, "selTotal", [""], function(data){
				var totalArr = new Array(data.length);
				for(var i = 0; i<data.length; i++){
					var year = "" + data[i][0];
					var dataArr = new Array(12);
					for(var j = 0; j<12; j++){
						dataArr[j] = data[i][j+1];
					}
					var dataObj = {name:year, data:dataArr};
			 		totalArr[i] = dataObj;
				}
				total = totalArr;
				showTable(total);
	   		});
	   	}
   	
	   	//显示数据到折线图
		function showTable(total){
	   		$('#container').highcharts({
				chart: {
					type: 'line'
				},
				credits:{enabled:false},//右下角图标
				exporting:{enabled:false},//右上角打印下载图标
				title: {
				    text: '年度分类仲裁申请表统计'
				},
				xAxis: {
				    categories: ['一月', '二月', '三月', '四月', '五月', '六月','七月', '八月', '九月', '十月', '十一月', '十二月']
				},
				yAxis: {
				    title: {
				        text: '分类仲裁申请表'
				    },
				    min:0,//纵坐标最小值从0开始
				    allowDecimals:false
				},
				tooltip: {
					enabled: false,
					formatter: function() {
						return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'条';
					}
				},
				plotOptions: {
					line: {
						dataLabels: {
							enabled: true
						},
						enableMouseTracking: false
					}
				},
	 			series: total
			});
		}
	
	   	$(function () {
	   		selTotal();
		});	
	</script>
  </head>
  <body>
	<div id="container" style="min-width:700px;height:428px"></div>
  </body>
</html>