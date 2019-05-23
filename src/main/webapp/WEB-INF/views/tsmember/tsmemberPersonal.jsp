<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta charset="UTF-8">
	<title>个人信息</title>
	<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="easyui/css/demo.css">
	
	<style type="text/css">
		.table th{font-weight:bold}
		.table th,.table td{padding:8px;line-height:20px}
		.table td{text-align:left}
		.table-border{border-top:1px solid #ddd}
		.table-border th,.table-border td{border-bottom:1px solid #ddd}
		.table-bordered{border:1px solid #ddd;border-collapse:separate;*border-collapse:collapse;border-left:0}
		.table-bordered th,.table-bordered td{border-left:1px solid #ddd}
		.table-border.table-bordered{border-bottom:0}
		.table-striped tbody > tr:nth-child(odd) > td,.table-striped tbody > tr:nth-child(odd) > th{background-color:#f9f9f9}
	</style>
	<script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/js/validateExtends.js"></script>
	<script type="text/javascript">
	$(function() {
		//修改密码窗口
	    $("#passwordDialog").dialog({
	    	title: "修改密码",
	    	width: 770,
	    	height: 200,
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	  	    		{
	  					text:'确定修改',
	  					handler:function(){
	  						var validate = $("#editPassword").form("validate");
	  						if(!validate){
	  							$.messager.alert("","请检查你输入的数据!","warning");
	  							return;
	  						} else{
	  							$.ajax({
	  								type: "post",
	  								url: "SystemController?method=EditPassword&t="+new Date().getTime(),
	  								data: $("#editPassword").serialize(),
	  								success: function(msg){
	  									if(msg == "success"){
	  										$.messager.alert("","修改成功, 将重新登录","warning")
	  										setTimeout(function(){
	  											top.location.href = "SystemController?method=LoginOut";
	  										}, 1000);
	  									} else {
											$.messager.alert("","修改失败","warning")
										}
	  								}
	  							});
	  						}
	  					}
	  				}
	  			]
	    });

		//编辑信息窗口
	    $("#editDialog").dialog({
	    	title: "编辑信息",
	    	width: 500,
	    	height: 400,
	    	fit: true,
	    	modal: false,
	    	noheader: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: false,
	    	toolbar: [
				{
					text:'修改密码',
					plain: true,
					iconCls:'icon-vcard-edit',
					handler:function(){
						$("#passwordDialog").dialog("open");
					}
				}
			]

	    });

		$("#systemTable a").each(function(){
			$(this).click(function(){
                var username = $("input[name=username]").val();
                var name = $("input[name=name]").val();
                var data = {'name': name, 'username': username}
				//保存
				$.ajax({
					type: "post",
					url: "SaveNameController?method=saveTSMemberName&t="+new Date().getTime(),
                    data: data,
					success: function(msg){
						if(msg == "success"){
							$.messager.alert("","保存成功, 重新登录后生效","info");
						}
					}
				});
			});
		});
	})
	</script>
</head>
<body>
	
	<div id="editDialog" style="padding: 20px;">
		<div style="width: auto">

				<c:if test="${empty user.sgmname }" var="result">
					<table id="systemTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" >
						<tr>
							<td width="200">用户名:</td>
							<td width="350">
								<input id="user_name" value="${user.username}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled" name="username" />
							</td>
							<td></td>
						</tr>
						<tr>
							<td width="200">姓名:</td>
							<td width="350">
								<input name="name" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" />
							</td>
							<td><a class="easyui-linkbutton">保存</a></td>
						</tr>
						<tr>
							<td width="200">注册时间:</td>
							<td width="350">
								<input id="registe_date" value="${user.etime}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled" name="registeDate" />
							</td>
							<td></td>
						</tr>
						<tr>
							<td width="200">用户类型:</td>
							<td width="350">
								<input id="user_type" value="${user.type}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled" name="userType" />
							</td>
							<td></td>
						</tr>
					</table>
				</c:if>
				<c:if test="${!result }">
				<table id="systemTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" >
					<tr>
						<td width="200">用户名:</td>
						<td width="350">
							<input value="${user.username}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td width="200">姓名:</td>
						<td width="350">
							<input value="${user.sgmname}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td width="200">注册时间:</td>
						<td width="350">
							<input value="${user.etime}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td width="200">用户类型:</td>
						<td width="350">
							<input value="${user.type}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" disabled="disabled"/>
						</td>
					</tr>
				</table>
				</c:if>
    	</div>
	</div>

	<!-- 修改密码窗口 -->
	<div id="passwordDialog" style="padding: 20px">
    	<form id="editPassword">
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>新密码:</td>
	    			<td>
	    				<input type="hidden" name="username" value="${user.username }" />
	    				<input id="new_password" style="width: 600px; height: 30px;" class="easyui-textbox" type="password" validType="password" name="password" data-options="required:true, missingMessage:'请输入新密码'" />
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>确认码:</td>
	    			<td><input id="re_password" style="width: 600px; height: 30px;" class="easyui-textbox" type="password" validType="equals['#new_password']"  data-options="required:true, missingMessage:'请再次输入密码'" /></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
</body>
</html>