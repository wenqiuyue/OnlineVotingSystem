<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加活动管理员</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js" ></script>
<style type="text/css">
#form  label.error{
color:red;
}
</style>
</head>
<body>
    <div class="weadmin-body">
        <form class="layui-form" id="form" me>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="we-red">*</span>用户名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="username" name="username" required="" lay-verify="required"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="L_pass" class="layui-form-label">
                  <span class="we-red">*</span>密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="pass" required="" lay-verify="pass"
                  autocomplete="off" class="layui-input">
              </div>
              <div class="layui-form-mid layui-word-aux">
                  6到16个字符
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label">
                  <span class="we-red">*</span>确认密码
              </label>
              <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="repass" required="" lay-verify="repass"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label"></label>
              <input type="submit"  class="layui-btn" click="add()" lay-filter="add" lay-submit=""></input>
          </div>
          <input type="text" name="role" value="${role}" hidden>
      </form>
    </div>		
    <script type="text/javascript">
    $(function(){
		$("#form").validate({
			rules:{
				username:"required",
				pass:"required",
				repass:"required"
			},
			messages:{
				username:"用户名不能为空",
				pass:"密码不能为空",
				repass:"请确认密码"
			},
			submitHandler:function(form){
				var url="${pageContext.request.contextPath}/addUser_sub";
				var param=$("#form").serialize();   //将表单序列化 把数据传到后台
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
					}
				})
			},
			invalidHandler: function(form, validator) {return false;}
		})
	})		
    </script>
  </body>
</html>