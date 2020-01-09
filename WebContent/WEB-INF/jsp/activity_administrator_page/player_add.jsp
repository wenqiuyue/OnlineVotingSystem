<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加选手</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js" ></script>
<style type="text/css">
#form  label.error{
color:red;
}
</style>
</head>
<body>
		<div class="weadmin-body">
			<form class="layui-form" action="${pageContext.request.contextPath}/upload_submit" method="post" enctype="multipart/form-data">  
				<div class="layui-upload" style="margin-left: 6%">
				  <button type="button" class="layui-btn" id="test1">上传图片</button>
				  <input type="file" name="file" id="picfile" style="display: none">
				</div>
				<input type="submit" id="sub" value="上传图片" style="display: none">    
			</form>
			<form class="layui-form" id="form">
				<div class="layui-upload" style="margin-left: 6%">
				  <div class="layui-upload-list" style="border: 1px solid balck;height: 200px;width: 200px;margin-left: 8%">
				  	<!--预览图片-->
				    <img class="layui-upload-img" src="${pageContext.request.contextPath}/upload/${filename}" id="demo1" style="height: 100%;width: 100%">
				  </div>
				  <input type="text" value="${filename}" name="picsrc" style="display: none;">
				</div>    
					 
				<div class="layui-form-item">
					<label for="username" class="layui-form-label">
                  <span class="we-red">*</span>姓名
              </label>
					<div class="layui-input-inline">
						<input type="text" id="username" name="username" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="number" class="layui-form-label">
                  <span class="we-red">*</span>编号
              </label>
					<div class="layui-input-inline">
						<input type="text" id="number" name="number" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
				    <label for="L-sex" class="layui-form-label">
                  <span class="we-red">*</span>性别
				    <div style="position: absolute;width:90px;left: 100px;top:9px">
				      <input type="radio" name="sex" value="0" checked="">男&nbsp;&nbsp;&nbsp;&nbsp;
				      <input type="radio" name="sex" value="1">女
				    </div>
				</div>
				<div class="layui-form-item">
					<label for="phone" class="layui-form-label">
                  <span class="we-red">*</span>电话
              </label>
					<div class="layui-input-inline">
						<input type="text" id="phone" name="phone" lay-verify="phone" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="em" class="layui-form-label">
                  <span class="we-red">*</span>邮箱
              </label>
					<div class="layui-input-inline">
						<input type="text" id="em" name="em" lay-verify="em" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="address" class="layui-form-label"><span class="we-red">*</span>家庭地址</label>
					<div class="layui-input-inline">
						<input type="text" id="address" name="address"  lay-verify="address" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid layui-word-aux">
					</div>
				</div>
		<div class="layui-form-item">
			<label for="L_repass" class="layui-form-label">
              </label>
			<button class="layui-btn" lay-filter="add" lay-submit="" click="add()">增加</button>
		</div>
		</form>
		</div>
	</body>
		<script>
			 $(function(){
				 	//图片上传
				 	$("#test1").click(function(){
				 		$("#picfile").click();
				 	})
				 	$("#picfile").change(function(){
				 		$("#sub").click();
				 	})
				 	
					$("#form").validate({
						rules:{
							number:{
								required:true,
								digits:true
							},
							phone:{
								required:true,
								digits:true
							},
							em:{
								required:true,
								email:true
							},
							username:"required",
							address:"required"
						},
						messages:{
							number:{
								required:"请输入选手编号",
								digits:"请输入正确的编号"
							},
							phone:{
								required:"请输入选手电话",
								digits:"请输入正确的选手电话"
							},
							em:{
								required:"请输入选手邮箱",
								email:"请输入正确的选手邮箱"
							},
							username:"请输入选手姓名",
							address:"请输入选手家庭住址"
						},
						submitHandler:function(form){
							var src=$('#demo1').attr('src');
							var url="${pageContext.request.contextPath}/addPlayer_sub";
							var param=$("#form").serialize();
							$.post(url,param,function(data){
								if(data.flag==1){
									window.location.href="${pageContext.request.contextPath}/activityAdministratorList"
									// 获得frame索引
					                var index = parent.layer.getFrameIndex(window.name);
					                //关闭当前frame
					                parent.layer.close(index);
					                location.reload(); 
					                   	           
								}else if(data.flag==2){
									alert(data.content)
								}else{
									alert(data.content)
								}
							})
						},
						invalidHandler: function(form, validator) {return false;}
					})
				})		
			
			
		</script>
</html>