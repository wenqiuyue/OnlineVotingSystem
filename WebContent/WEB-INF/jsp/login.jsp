<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
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
<style type="text/css">
#form  label.error{
color:red;
}
</style>
</head>
<body class="login-bg">

	<div class="login">
		<div class="message">在线投票系统登录</div>
		<div id="darkbannerwrap"></div>

		<form method="post" class="layui-form" id="form" action="${pageContext.request.contextPath}/login_sub">
			<input name="username" placeholder="用户名" type="text"
				lay-verify="required" class="layui-input">
			<hr class="hr15">
			<input name="password" lay-verify="required" placeholder="密码"
				type="password" class="layui-input">
			<hr class="hr15">
			<input class="loginin" value="登录" lay-submit lay-filter="login"
				style="width: 100%;" type="submit">
		</form>
		<br>
		<a href="${pageContext.request.contextPath}/register">没有账号？请注册</a>
		<script type="text/javascript">
			$(function(){
				$("#form").validate({
					rules:{
						username:"required",
						password:"required"
					},
					messages:{
						username:"姓名不能为空",
						password:"密码不能为空"
					}
				})
			})
		</script>
	</div>
</body>
</html>