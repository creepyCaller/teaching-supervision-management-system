<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div title="欢迎" style="padding:20px; overflow:hidden; color:black; " >
	<p style="font-size: 50px; line-height: 10px; height: 00px;">${systemInfo.collegename}&nbsp;${systemInfo.schoolname}</p>
	<p style="font-size: 30px; line-height: 40px; height: 30px;">&nbsp;欢迎使用教学督导听课评价管理系统</p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;管理员&nbsp;${user.username}&nbsp;,您好!&nbsp;&nbsp;<input id="logoutBtn" type="button" value="登出"></p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;面向督导员的通知：${systemInfo.noticetsmember}</p>
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;面向教师的通知：${systemInfo.noticeteacher}</p>
</div>