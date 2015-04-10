<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
<head>
  <script type="text/javascript" src="js/jquery-1.8.3.js"></script>
  <script type="text/javascript" src="js/highcharts.js"></script> 
  <script>
   $(function () {
    /*   $('#container').highcharts({ */
    char1=new Highcharts.Chart({
        chart: {
        	renderTo:'container',
            type: 'column',
            backgroundColor: 'rgba(0,0,0,0)'
        },
        title: {
            text: '分类仲裁申请表统计',
            // x:  -10 //center
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['一月', '二月', '三月', '四月', '五月', '六月','七月', '八月', '九月', '十月', '十一月', '十二月']
        },
        yAxis: {
            min: 0,
            title: {
                text: '申请表数量 (份)'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        }, 
        legend:[{
        	 enabled: false
        }],
        series: [{
            name: '分类仲裁申请表',
            data: [6, 3, 7,23, 56, 51, 34, 35, 56, 13, 34, 56],
            //color:'#000000'

       }]
    });
});				
  </script>
</head>
<body>
  <div id="container" style="min-width:700px;height:428px"></div>
</body>
</html>