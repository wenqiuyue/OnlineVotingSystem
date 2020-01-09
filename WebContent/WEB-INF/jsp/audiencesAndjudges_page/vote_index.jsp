<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--声明文档兼容模式，表示使用IE浏览器的最新模式-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--设置视口的宽度(值为设备的理想宽度)，页面初始缩放值<理想宽度/可见宽度>-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投票</title>
<!-- 引入Bootstrap核心样式文件 -->
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<style type="text/css">
.bac {
	position: relative;
}

.bac img {
	width: 100%;
	height: 100%;
}

.pic {
	height: 13%;
	position: absolute;
	top: 60%;
	text-align: center;
	line-height: 27px;
	left: 8%;
}

.pic img {
	width: 95%;
	border-radius: 50%;
}

.pic span {
	font-size: 18px;
	font-weight: bold;
	margin-left: 40%;
}

.pic button {
	background-color: #31B0D5;
	color: white;
	border: none;
	margin-left: 40%;
}

.pic1 {
	top: 80%;
}

.pic3 {
	position: absolute;
	top: 52%;
	text-align: center;
	font-size: 19px;
	font-weight: bold;
}

.pic4 {
	position: absolute;
	top: 52%;
	font-size: 16px;
	text-align: right;
}

.pic4 button {
	background-color: #31B0D5;
	border: none;
	color: white;
}
.pic5{
	left: 82%;
	height: 30%;
	padding-top: 12%;
}
.pic5 span{
	color: #F14213;
}
.pic6{
	top:65%;
}
</style>
<script type="text/javascript">
	$(function() {
		votes()
		//身份判断，并获取可投多少票
		function votes() {
			var url = "${pageContext.request.contextPath}/votesNum";
			var usercategory = 2;
			var p = /评委/;
			var g = /观众/;
			if (p.test($("#category").html())) {
				usercategory = 2;
			} else if (g.test($("#category").html())) {
				usercategory = 3;
			}
			var param = {
				usercategory : usercategory
			};
			$.post(url, param, function(data) {
				$("#votesnum").html(data.content);
			})
		}
		beginMatch();
		//获取已启动的比赛场次
		function beginMatch(){
			var url="${pageContext.request.contextPath}/getBegin";
			var param="";
			$.post(url,param,function(data){
				if(data.flag==1){
					$("#matchnumber").html(data.content);
					$(".pic6").hide();
					$(".nomatch").show();
				}else{
					$(".nomatch").hide();
					$(".pic6").show();
					
				}
			})
		}
		
		//该用户可以点击投票按钮的次数		
		$(".btn").click(function() {
			votesnum++;
			//alert($(this).parent().children().eq(4).html())
			//添加被投票的选手编号到数据库
			var url="${pageContext.request.contextPath}/addVotesPlayer";
			var param={
					matchnumber:$("#matchnumber").html(),
					num:$(this).parent().children().eq(4).html()
			};
			var votesnumber=$("#votesnum").html();
			$.post(url,param,function(data){
				if(data.flag==1){
					
					$("#votesnum").html(votesnumber-1);
				}
			})
			if (votesnumber==1) {
				$(".btn").css('background-color','gray').prop("disabled", true);
				
			}
		})
		
		//刷新
		$("#new").click(function(){
			var url="${pageContext.request.contextPath}/getPlayer";
			var param=""
			$.post(url,param,function(){ 
			})
			location.reload()
		})
		
		

	})
</script>
</head>
<body>

	<div class="container-fluid">
		<div class="row">
			<div class="col-xs bac">
				<img src="img/16pic_6076945_b.jpg" />
				<div class="row">
					<div class="col-xs-12 pic3">
						<span>欢迎<label id="category"><c:if
									test="${user.category==2}">评委</c:if>
								<c:if test="${user.category==3}">观众</c:if></label>：${user.uname},您可投<lable
								id="votesnum">X</lable>票
						</span>
					</div>
					<div class="col-xs-12 pic4">
						<button id="new" >刷新</button>
					</div>
					<div class="col-xs-12 pic3 pic6">
						暂无比赛
					</div>
				</div>
				<div class="row nomatch">
					<div class="col-xs-4 pic">
						<img src="${pageContext.request.contextPath}/upload/${matcha.player.photos}" />
					</div>
					<div class="col-xs-10 pic">
						<span>${matcha.player.pname}</span><br />
						<span>《${matcha.player_a_program}》</span><br />
						<span>${matcha.player_a_num}</span>
						<button class="btn">为TA投票</button>
					</div>
					<div class="col-xs-1 pic pic5">
						<span>第<lable id="matchnumber"></lable>场PK赛</span>
					</div>
				</div>
				<div class="row nomatch">
					<div class="col-xs-4 pic pic1">
						<img src="${pageContext.request.contextPath}/upload/${matchb.player.photos}" />
					</div>
					<div class="col-xs-10 pic pic1">
						<span>${matchb.player.pname}</span><br /> 
						<span>《${matchb.player_b_program}》</span><br />
						<span>${matcha.player_b_num}</span>
						<button class="btn">为TA投票</button>
					</div>
				</div>
			</div>

		</div>

	</div>
</body>
</html>