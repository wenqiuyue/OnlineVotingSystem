<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑选手</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<script>
	$(function(){
		//$("#demo1").attr("src","${pageContext.request.contextPath}/upload/${player.photos}");
		$("input[name=sex][value=${player.psex}]").attr("checked",true);
	})	
</script> 
</head>
<body>
		<div class="weadmin-body">
			<form class="layui-form" id="form">
				<div class="layui-upload" style="margin-left: 6%">
				   <div class="layui-upload-list" style="border: 1px solid balck;height: 200px;width: 200px;margin-left: 8%">
				  	<!--预览图片-->
				    <img class="layui-upload-img" src="${pageContext.request.contextPath}/upload/${player.photos}" id="demo1" style="height: 100%;width: 100%">
				  </div>
				</div>    
					 
				<div class="layui-form-item">
					<label for="username" class="layui-form-label">
                  <span class="we-red">*</span>姓名
              </label>
					<div class="layui-input-inline">
						<input type="text" id="username" name="username" value="${player.pname}" autocomplete="off" class="layui-input" readonly="readonly" >
					</div>
				</div>
				<div class="layui-form-item">
					<label for="number" class="layui-form-label">
                  <span class="we-red">*</span>编号
              </label>
					<div class="layui-input-inline">
						<input type="text" id="number" value="${player.number}" name="number" autocomplete="off" class="layui-input" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
				    <label for="L-sex" class="layui-form-label">
                  <span class="we-red">*</span>性别
				    <div style="position: absolute;width:90px;left: 100px;top:9px">
				      <input type="radio" name="sex" value="0" checked="" readonly="readonly">男&nbsp;&nbsp;&nbsp;&nbsp;
				      <input type="radio" name="sex" value="1" readonly="readonly">女
				    </div>
				</div>
				<div class="layui-form-item">
					<label for="phone" class="layui-form-label">
                  <span class="we-red">*</span>电话
              </label>
					<div class="layui-input-inline">
						<input type="text" id="phone" value="${player.phone}" name="phone" lay-verify="phone" autocomplete="off" class="layui-input" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="em" class="layui-form-label">
                  <span class="we-red">*</span>邮箱
              </label>
					<div class="layui-input-inline">
						<input type="text" id="em" value="${player.email}" name="em" lay-verify="em" autocomplete="off" class="layui-input" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="address" class="layui-form-label"><span class="we-red">*</span>家庭地址</label>
					<div class="layui-input-inline">
						<input type="text" id="address" name="address" value="${player.address}" lay-verify="address" autocomplete="off" class="layui-input" readonly="readonly">
					</div>
					<div class="layui-form-mid layui-word-aux">
					</div>
				</div>
		</form>
		</div>
	</body>
		
</html>