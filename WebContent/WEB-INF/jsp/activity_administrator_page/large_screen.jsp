<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投屏</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<script src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css">
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js" ></script>
<style type="text/css">
#fresh{
	position: absolute;
	left:95%;
}
#title{
	text-align: center;
	margin-top: 20px;
	color: #189F92;
	font-weight: bolder;
	font-size: 32px;
}
.info{
	width: 50%;
	height: 160px;
	/* border:1px solid red; */
	margin-left: 25%;
	margin-top: 25%;
}
.player{
	height: 100%;
	width: 49%;
	/* border: 1px solid black; */
	float: left;
	display: flex;
	align-items: center;
	
}
.playerimg{
	height: 60%;
	width: 36%;
	/* border: 1px solid green; */
}
.playerimg img{
	width: 100%;
	height: 100%;
	border-radius: 50%;
}
.playerinfo{
	width: 67%;
	height: 100%;
	/* border: 1px solid black; */
	display: flex;
	flex-wrap: wrap;
	
}
.playerinfo span{
	/* border: 1px solid red; */
	width: 100%;
	height: 33%;
	font-size: 23px;
	display: flex;
	justify-content: center;
	align-items: center;
}
#main{
	position:absolute;
	left: 345px;
}
</style>
<script type="text/javascript">
	$(function(){
		//刷新
		$("#fresh").click(function(){
			location.reload();
		})
		
		
	})
</script>
</head>
<body class="login-bg">
	<button id="fresh">刷新</button>
	<h1 id="title">星光大道</h1>
	<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    	 <div id="main" style="width:600px;height:380px;"></div>
    	<div class="info">
    		<div class="player">
    			<div class="playerimg">
    				<img src="${pageContext.request.contextPath}/upload/${matcha.player.photos}">
    			</div>
    			<div class="playerinfo">
    				<span>《${matcha.player_a_program}》</span>
    				<span>${matcha.player_a_num}</span>
    				<span>${matcha.player.pname}</span>
    				<span id="conta" style="display: none;">${conta}</span>
    			</div>
    		</div>
    		
    		<div class="player">
    			<div class="playerimg">
    				<img src="${pageContext.request.contextPath}/upload/${matchb.player.photos}">
    			</div>
    			<div class="playerinfo">
    				<span>《${matchb.player_b_program}》</span>
    				<span>${matcha.player_b_num}</span>
    				<span>${matchb.player.pname}</span> 
    				<span id="contb" style="display: none;">${contb}</span>  				
    			</div>
    		</div>
    	</div>
    	
    	<script type="text/javascript">
    	// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
       option = {
		    xAxis: {
		        type: 'category',
		        data: [' ', ' ',' ']
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [{
		        data: [$("#conta").html(),0, $("#contb").html()],
		        type: 'bar'
		    }]
		};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</body>
</html>