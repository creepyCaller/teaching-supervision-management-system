<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div title="欢迎" style="padding:20px; overflow:hidden; color:black; " >
	<p style="font-size: 50px; line-height: 10px; height: 00px;">${systemInfo.collegename}&nbsp;${systemInfo.schoolname}</p>
	<p style="font-size: 30px; line-height: 40px; height: 30px;">&nbsp;教学督导听课评价管理系统</p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">
		<c:if test="${empty user.teachername }" var="result">
			&nbsp;${user.username}，您好！&nbsp;|&nbsp;&nbsp;您还未设置姓名，请前往个人管理->个人信息进行设置！&nbsp;|&nbsp;&nbsp;
		</c:if>
		<c:if test="${!result }">
			&nbsp;${user.name}，您好！&nbsp;|&nbsp;&nbsp;
		</c:if>
		<input id="logoutBtn" type="button" value="登出">
	</p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;通知：${systemInfo.noticeteacher}</p>
</div>