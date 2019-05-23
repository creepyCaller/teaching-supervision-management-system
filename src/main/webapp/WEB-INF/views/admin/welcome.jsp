<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div title="欢迎" style="padding:20px; overflow:hidden; color:black; " >
	<p style="font-size: 50px; line-height: 10px; height: 00px;">${systemInfo.collegename}&nbsp;${systemInfo.schoolname}</p>
	<p style="font-size: 30px; line-height: 40px; height: 30px;">&nbsp;教学督导听课评价管理系统</p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;当前用户：${user.username}&nbsp;|&nbsp;&nbsp;<input id="logoutBtn" type="button" value="登出"></p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;督导员通知：${systemInfo.noticetsmember}</p>
	<hr />
	<p style="font-size: 20px; line-height: 20px; height: 20px;">&nbsp;教师通知：${systemInfo.noticeteacher}</p>
</div>