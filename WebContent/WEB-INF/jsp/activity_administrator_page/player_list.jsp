<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/eleDel.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	function delPlayer(number){
		var isDel=confirm("您确定要删除该选手吗？？");
		if(isDel==true){
			var url="${pageContext.request.contextPath}/delPlayer";
			var param={number:number};
			$.post(url,param,function(data){
				if(data.flag==1){
					location.reload();  //刷新页面
				}
			})
		}
		
	}
</script>
</head>
<body>
		<div class="weadmin-nav">
			
			<a class="layui-btn layui-btn-sm" style="margin-top:3px;float:right" href="javascript:location.replace(location.href);"
			 title="刷新">
				<i class="layui-icon layui-icon-refresh"></i>
				<!-- <i class="layui-icon" style="line-height:30px">&#x1002;</i> -->
			</a>
		</div>

		<div class="weadmin-body">
			<div class="weadmin-block">
				<button class="layui-btn" onclick="WeAdminShow('添加选手','${pageContext.request.contextPath}/addPlayer',900,550)">
					<i class="layui-icon layui-icon-add-circle-fine"></i>添加
				</button>
				<span class="fr" style="line-height:40px">共有数据：88 条</span>
			</div>
			<table class="layui-table" id="memberList">
				<thead>
					<tr>
						<th>选手编号</th>
						<th>选手照片</th>
						<th>姓名</th>
						<th>性别</th>
						<th>电话</th>
						<th>邮箱</th>
						<th>家庭地址</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${player}" var="item">
					<tr>
						<td>${item.number}</td>
						<td style="height: 60px;width: 60px"><img class="layui-upload-img" src="${pageContext.request.contextPath}/upload/${item.photos}" id="pic" style="height: 100%;width: 100%"></td>
						<td>${item.pname}</td>
						<td>
							<c:if test="${item.psex==0}">
								男
							</c:if>
							<c:if test="${item.psex==1}">
								女
							</c:if>
						</td>
						<td>${item.phone}</td>
						<td>${item.email}</td>
						<td>${item.address}</td>
						<td class="td-manage">
							<a title="查看" onclick="WeAdminEdit('查看选手','${pageContext.request.contextPath}/playerSee?number=${item.number}', 1, 900,550)" href="javascript:;">
								<i class="layui-icon layui-icon-edit"></i>
							</a>							
							<a title="删除" onclick="delPlayer(${item.number})" href="javascript:;">
								<i class="layui-icon layui-icon-delete"></i>
							</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
				
			</table>
		</div>
		<!--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>-->
		
	</body>
</html>