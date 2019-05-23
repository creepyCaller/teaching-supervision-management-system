<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta charset="UTF-8">
	<title>系统信息</title>
	<link rel="stylesheet" type="text/css" href="easyui/themes/material-teal/easyui.css">
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
					text:'清空表单',
					plain: true,
					iconCls:'icon-clear',
					handler:function(){
						//清空表单
						$("#college_name").textbox('setValue', "");
						$("#school_name").textbox('setValue', "");
						$("#forbid_teacher").removeAttr("checked");
						$("#forbid_tsmember").removeAttr("checked");
						$("#notice_teacher").textbox('setValue', "");
						$("#notice_tsmember").textbox('setValue', "");
					}
				}
			]
	    });

		//修改
		$("#systemTable a").each(function(){
			$(this).click(function(){
				var input = $(this).parents("tr").find("input");
				var inputName = $(input).attr("name");
				var name = "";
				var value = "";
				if(inputName == "forbidTeacher" || inputName == "forbidTeacherRegiste") //禁止教师登录或登录和注册
				{
					name = inputName;
					if(inputName == "forbidTeacher" && $(input).attr("checked") && $("input[name=forbidTeacherRegiste]").attr('checked')) //不允许登录和注册  3
                    {
                        value = 3;
                    }
					else if(inputName == "forbidTeacherRegiste" && $(input).attr("checked") && $("input[name=forbidTeacher]").attr('checked')) //不允许登录和注册  3
                    {
                        value = 3;
                    }
					else if(inputName == "forbidTeacher" && $(input).attr("checked")) //不允许登录 1
					{
						value = 1;
					}
					else if(inputName == "forbidTeacherRegiste" && $(input).attr("checked")) //不允许注册 2
                    {
                        value = 2;
                    }
					else if(inputName == "forbidTeacher" && !$(input).attr("checked") && $("input[name=forbidTeacherRegiste]").attr('checked')) //用于取消勾勾时候的确认
					{
						value = 2;
					}
					else if(inputName == "forbidTeacherRegiste" && !$(input).attr("checked") && $("input[name=forbidTeacher]").attr('checked')) //用于取消勾勾时候的确认
					{
						value = 1;
					}
					else //都允许 0
                    {
						value = 0;
					}
				}
				else if(inputName == "forbidTSMember" || inputName == "forbidTSMemberRegiste") //禁止督导员登录或登录和注册
                {
                    name = inputName;
                    if(inputName == "forbidTSMember" && $(input).attr("checked") && $("input[name=forbidTSMemberRegiste]").attr('checked')) {
                        value = 3;
                    }
                    else if(inputName == "forbidTSMemberRegiste" && $(input).attr("checked") && $("input[name=forbidTSMember]").attr('checked')) {
                        value = 3;
                    }
                    else if(inputName == "forbidTSMember" && $(input).attr("checked")) {
                        value = 1;
                    }
                    else if(inputName == "forbidTSMemberRegiste" && $(input).attr("checked")) {
                        value = 2;
                    }
                    else if(inputName == "forbidTSMember" && !$(input).attr("checked")  && $("input[name=forbidTSMemberRegiste]").attr('checked')) //用于取消勾勾时候的确认
					{
						value = 2;
					}
					else if(inputName == "forbidTSMemberRegiste" && !$(input).attr("checked")  && $("input[name=forbidTSMember]").attr('checked')) //用于取消勾勾时候的确认
					{
						value = 1;
					}
                    else {
                        value = 0;
                    }
                }
				else
				{
					var name = $(input).attr("textboxname");
					var value = $(input).textbox("getValue");
				}
				
				//保存
				var data = {'name': name, 'value': value};
				$.ajax({
					type: "post",
					url: "SystemController?method=editSystemimformation&t="+new Date().getTime(),
					data: data,
					success: function(msg){
						if(msg == "success"){
							$.messager.alert("","保存成功","info");
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
    	<table id="systemTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" >
			<tr>
				<td width="200">学校名称:</td>
				<td width="350">
					<input id="college_name" value="${systemInfo.collegename}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="collegeName" />
				</td>
				<td width="100"><a class="easyui-linkbutton">保存</a></td>
			</tr>
    		<tr>
    			<td width="200">所属院系:</td>
    			<td width="350">
    				<input id="school_name" value="${systemInfo.schoolname}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="schoolName" />
    			</td>
    			<td width="100"><a class="easyui-linkbutton">保存</a></td>
    		</tr>
    		<tr>
            <td>禁止教师<br/>登录系统 </td>
            <td><input id="forbid_teacher" ${systemInfo.forbidteacher == 1 || systemInfo.forbidteacher == 3 ? 'checked' : ''} type="checkbox" name="forbidTeacher" /></td>
            <td><a class="easyui-linkbutton">保存</a></td>
        </tr>
            <tr>
                <td>禁止督导组<br/>登录系统 </td>
                <td><input id="forbid_tsmember" ${systemInfo.forbidtsmember == 1 || systemInfo.forbidtsmember == 3 ? 'checked' : ''} type="checkbox" name="forbidTSMember" /></td>
                <td><a class="easyui-linkbutton">保存</a></td>
            </tr>
            <tr>
                <td>禁止教师<br/>注册系统 </td>
                <td><input id="forbid_teacher_registe" ${systemInfo.forbidteacher == 2 || systemInfo.forbidteacher == 3 ? 'checked' : ''} type="checkbox" name="forbidTeacherRegiste" /></td>
                <td><a class="easyui-linkbutton">保存</a></td>
            </tr>
            <tr>
                <td>禁止督导组<br/>注册系统 </td>
                <td><input id="forbid_tsmember_registe" ${systemInfo.forbidtsmember == 2 || systemInfo.forbidtsmember == 3 ? 'checked' : ''} type="checkbox" name="forbidTSMemberRegiste" /></td>
                <td><a class="easyui-linkbutton">保存</a></td>
            </tr>
    		<tr>
    			<td>教师通知:</td>
    			<td><input id="notice_teacher"  value="${systemInfo.noticeteacher}" style="width: 300px; height: 70px;" data-options="multiline: true" class="easyui-textbox" type="text" name="noticeTeacher" /></td>
    			<td><a class="easyui-linkbutton">保存</a></td>
    		</tr>
    		<tr>
    			<td>督导组通知:</td>
    			<td><input id="notice_tsmember"  value="${systemInfo.noticetsmember}" style="width: 300px; height: 70px;" data-options="multiline: true" class="easyui-textbox" type="text" name="noticeTSMember" /></td>
    			<td><a class="easyui-linkbutton">保存</a></td>
    		</tr>
    	</table>
    	</div>
	</div>
	
</body>
</html>