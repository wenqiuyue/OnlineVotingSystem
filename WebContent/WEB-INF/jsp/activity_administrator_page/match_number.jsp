<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>比赛场次设置</title>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weadmin.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/eleDel.js" type="text/javascript" charset="utf-8"></script>
<style type="text/css">
	input,select{
		width:100%;
		border:none;
		background: none;
		text-align: center;
	}
</style>
<script type="text/javascript">	
	$(function(){
		//var i=0
		//添加比赛场次
		$("#addMatch").click(function(){
			/* var k=i
			i++;
			$("#t"+k).before('<tr id="t'+i+'"><form><td><input type="text" name="c'+i+'" class="matchtext" value="'+i+'"></td><td><input type="text" name="p_a_number'+i+'" cliss="matchtext" value=""></td><td><input type="text" name="p_a_name'+i+'" cliss="matchtext" value=""></td><td><input type="text" name="p_a_program'+i+'" cliss="matchtext" value=""></td><td><input type="text" name="p_b_number'+i+'" cliss="matchtext" value=""></td><td><input type="text" name="p_b_name'+i+'" cliss="matchtext" value=""></td><td><input type="text" name="p_b_program'+i+'" cliss="matchtext" value=""></td><td><input type="text" name="time'+i+'" cliss="matchtext" value=""></td><td class="td-status"><span class="layui-btn layui-btn-normal layui-btn-xs" id="enable'+i+'" onclick=\'enable("enable'+i+'","t'+i+'")\'>修改中</span></td></tr>') */
			/* var url="${pageContext.request.contextPath}/addMatch?matchnumber=i"
			var param="";
			$.get(url,param,function(){
				
			}) */
			$("#addmatchtable").toggle()
		})
		
		//提交
		$("#add_btn").click(function(){
			var url="${pageContext.request.contextPath}/addMatch";
			var param=$("#form").serialize();
			$.post(url,param,function(data){
				//alert(data.content);
			})
		})
		
		//选择第一位选手编号，关联选手姓名
		$("#select").change(function(){
			var url="${pageContext.request.contextPath}/selectPlayer";
			var param={num:$("select[name=interest]").val()};
			$.post(url,param,function(data){
				//alert(data.content)
				$("#p_a_name").val(data.content);
				
			})
		})
		//选择第二位选手编号，关联选手姓名
		$("#selectb").change(function(){
			var url="${pageContext.request.contextPath}/selectPlayer";
			var param={num:$("select[name=interestb]").val()};
			$.post(url,param,function(data){
				//alert(data.content)
				$("#p_b_name").val(data.content);
				
			})
		})
		
		//是否启动
		$(".begin").click(function(){
			var isbegin=0;			
			if($(this).html()=="请启动"){
				$(this).html("已启动")
				$(this).css('background-color','#48B0FC');
				isbegin=1;
			}else{
				$(this).html("请启动")
				$(this).css('background-color','gray');
				isbegin=0
				
				//删除该场比赛数据
				var url="${pageContext.request.contextPath}/delMatchVotes";
				var param={
						matchnum:$(this).parent().parent().children().eq(0).html()
				};
				$.post(url,param,function(){
					
				})
				
			}			
			var url="${pageContext.request.contextPath}/isBegin";
			var param={
				number:	$(this).parent().parent().children().eq(0).html(),
				isbegin:isbegin
			};
			$.post(url,param,function(){
				
			})
		})
		
		
		
	})	
	
	function delU(num){
		var url="${pageContext.request.contextPath}/delMatch"
		var param={num:num}
		$.post(url,param,function(data){
			if(data.flag==1){
				location.reload();
			}else{
				alert(data.content);
			}
		})
	}
</script>
</head>
<body>
	<div class="weadmin-nav">
	<a class="layui-btn layui-btn-sm"
			style="margin-top: 3px; float: right"
			href="javascript:location.replace(location.href);" title="刷新"> <i
			class="layui-icon layui-icon-refresh"></i> <!-- <i class="layui-icon" style="line-height:30px">&#x1002;</i> -->
		</a>
	</div>

	<div class="weadmin-body">
		<div class="weadmin-block">
			<button class="layui-btn" id="addMatch">
				<i class="layui-icon layui-icon-add-circle-fine"></i>添加
			</button>
		</div>
		<!-- 添加表格 -->
		<table class="layui-table" id="addmatchtable">
			<thead>
				<tr>
					<th style="text-align: center;">比赛场次</th>
					<th style="text-align: center;">第一位选手编号</th>
					<th style="text-align: center;">姓名</th>
					<th style="text-align: center;">表演节目</th>
					<th style="text-align: center;">第二位选手编号</th>
					<th style="text-align: center;">姓名</th>
					<th style="text-align: center;">表演节目</th>
					<th style="text-align: center;">操作</th>
				</tr>
			</thead>
				<tbody>
				<form id="form">
					<tr>
						<td><input type="text" name="matchnumber" class="matchtext" required="" onkeyup="value=value.replace(/[^\d]/g,'')"></td>
						<td>
						    <select name="interest" lay-filter="aihao" id="select">
						        <option value="" selected=""></option>
						        <c:forEach items="${player}" var="item">
						        	<option value="${item.number}">${item.number}</option>
						        </c:forEach>
						        
						      </select>
						  </td>
						<td><input type="text" id="p_a_name" name="p_a_name" value="" class="matchtext" readonly="readonly"></td>
						<td><input type="text" name="p_a_program" class="matchtext" required=""></td>
						<td>
						<select name="interestb" lay-filter="aihao" id="selectb">
						        <option value="" selected=""></option>
						        <c:forEach items="${player}" var="item">
						        	<option value="${item.number}">${item.number}</option>
						        </c:forEach>
						        
						 </select>
						</td>
						<td><input type="text" id="p_b_name" name="p_b_name" class="matchtext" required=""></td>
						<td><input type="text" name="p_b_program" class="matchtext" required=""></td>
						<td class="td-status">
						<button class="layui-btn" id="add_btn">
							<i class="layui-icon layui-icon-add-circle-fine"></i>提交
						</button>
						</td>
					</tr>
				</form>
				</tbody>
		</table>
		</br>
		
		<!-- 展示表格 -->
		<table class="layui-table" id="memberList">
			<thead>
				<tr>
					<th style="text-align: center;">比赛场次</th>
					<th style="text-align: center;">第一位选手编号</th>
					<!-- <th style="text-align: center;">姓名</th> -->
					<th style="text-align: center;">表演节目</th>
					<th style="text-align: center;">第二位选手编号</th>
					<!-- <th style="text-align: center;">姓名</th> -->
					<th style="text-align: center;">表演节目</th>
					<th style="text-align: center;">状态</th>
				</tr>
			</thead>
				<tbody>
					<c:forEach items="${match}" var="item">
						<tr>
							<td>${item.number}</td>
							<td>${item.player_a_num}</td>
							<!-- <td></td> -->
							<td>${item.player_a_program}</td>
							<td>${item.player_b_num}</td>
							<!-- <td></td> -->
							<td>${item.player_b_program}</td>
							<td class="td-status"><c:if test="${item.isbegin!=1}"><span class="layui-btn layui-btn-normal layui-btn-xs begin" style="background-color: gray">请启动</span></c:if><c:if test="${item.isbegin==1}"><span class="layui-btn layui-btn-normal layui-btn-xs begin" style="background-color: #48B0FC">已启动</span></c:if>&nbsp;
							<a title="删除" onclick="delU('${item.number}')" href="#"><i class="layui-icon layui-icon-delete"></i></a></td>
						</tr>
					</c:forEach>
				</tbody>
		</table>
	</div>
</body>
</html>