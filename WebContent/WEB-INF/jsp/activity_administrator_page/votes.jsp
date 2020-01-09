<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投票控制</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css" />
<style type="text/css">
	input{
		width:100%;
		border:none;
		background: none;
		text-align: center;
	}
	tr td{
	width: 33%;
	text-align: center;
	}
</style>
<script type="text/javascript">
	$(function(){
		//是否启动
		$(".begin").click(function(){
			if($(this).html()=="修改"){
				$(this).html("确定")	
				$(this).parent().parent().children().eq(1).children().removeAttr("readonly");
			}else{
				$(this).html("修改")
				$(this).parent().parent().children().eq(1).children().attr("readonly","readonly");
				//更改有效票数
				var url="${pageContext.request.contextPath}/updateVotes";
				var usercategory=2;	
				var p=/评委/;
				var g=/观众/;
				if(p.test($(this).parent().parent().children().eq(0).html())){
					usercategory=2;
				}else if(g.test($(this).parent().parent().children().eq(0).html())){
					usercategory=3;
				}
				var votesnum=$(this).parent().parent().children().eq(1).children().val();
				var param={
						usercategory:usercategory,
						votesnum:votesnum
				}
				$.post(url,param,function(data){
					
				})
			}
		})
	})
</script>
</head>
<body>
    <div class="weadmin-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">管理员管理</a>
        <a>
          <cite>权限分类</cite></a>
      </span>
      <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">刷新</i></a>
    </div>
    <div class="weadmin-body">
      <table class="layui-table">
        <thead>
          <tr>
            <th style="text-align: center;">用户类型</th>
            <th style="text-align: center;">有效票数</th>
            <th style="text-align: center;">操作</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${votes}" var="item">
	          <tr>
	            <td>
	            <c:if test="${item.usercategory==2}">
	            	评委
	            </c:if>
	            <c:if test="${item.usercategory==3}">
	            	观众
	            </c:if>
	            </td>
	            <td><input type="number" value="${item.votesnum}" readonly="readonly"></td>
	            <td class="td-status"><span class="layui-btn layui-btn-normal layui-btn-xs begin">修改</span>&nbsp;
	          </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </body>
</html>