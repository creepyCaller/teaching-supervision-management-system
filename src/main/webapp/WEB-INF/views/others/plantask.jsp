<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>安排听课</title>

    <link rel="stylesheet" type="text/css" href="easyui/themes/material-teal/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="easyui/css/demo.css">
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="easyui/js/validateExtends.js"></script>
	<style type="text/css">
		.table th{font-weight:bold}
		.table th,.table td{padding:8px;line-height:20px}
		.table td{text-align:left}
		.table-border{border-top:1px solid #ddd}
		.table-border th,.table-border td{border-bottom:1px solid #ddd}
		.table-bordered{border:1px solid #ddd;border-collapse:separate;*border-collapse:collapse;border-left:0}
		.table-bordered th,.table-bordered td{border-left:1px solid #ddd}
		.table-border.table-bordered{border-bottom:0}
		.table-striped tbody > tr:nth-child(odd) > td,.table-striped tbody > tr:nth-child(odd) > th{background-color:#fff}
	</style>
	<script type="text/javascript">
		$(function() {
			$("#planDialog").dialog({
				title: "安排听课",
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
							text:'提交任务',
							plain: true,
							iconCls:'icon-ok',
							handler:function()
							{
								var validate = $("#addForm").form("validate");
								if(!validate)
								{
									$.messager.alert("","请检查你输入的数据!","warning");
								}
								else
								{
									//提交任务
									$.ajax({
										type: "post",
										url: "TaskController?method=AddTask",
										data: $("#addForm").serialize(),
										success: function (msg) {
											if (msg == "success") {
												$.messager.alert("", "添加成功!", "info");
												//清空原表格数据
												$("#add_taskexecuter").textbox('setValue', "");
												$("#add_teachername").textbox('setValue', "");
												$("#add_coursename").textbox('setValue', "");
												$("#add_roomlocation").textbox('setValue', "");
												$("#add_time").textbox('setValue', "");
												$("#add_lessontype").textbox('setValue', "基础课");
												$("#add_lessonno").textbox('setValue', "");
												$("#add_classtype").textbox('setValue', "理论课");
												$("#add_comment").textbox('setValue', "");
												$("#add_finished").textbox('setValue', "0");
												$("#add_ntid").textbox('setValue', "");
											} else {
												$.messager.alert("", "添加失败!", "warning");
											}
										}
									});
								}
							}
						},
						{
						text:'清空表单',
						plain: true,
						iconCls:'icon-clear',
						handler:function(){
							//清空表单
							$("#add_taskexecuter").textbox('setValue', "");
							$("#add_teachername").textbox('setValue', "");
							$("#add_coursename").textbox('setValue', "");
							$("#add_roomlocation").textbox('setValue', "");
							$("#add_time").textbox('setValue', "");
							$("#add_lessontype").textbox('setValue', "公共课");
							$("#add_lessonno").textbox('setValue', "");
							$("#add_classtype").textbox('setValue', "理论课");
							$("#add_comment").textbox('setValue', "");
							$("#add_finished").textbox('setValue', "0");
							$("#add_ntid").textbox('setValue', "");
						}
					}
				],
                onBeforeOpen: function(){
                    //设置值
                    $("#hidden_finished").textbox('setValue', "0");
                    $("#hidden_ntid").textbox('setValue', "0");
                    $("#hidden_finished").next().hide();
                    $("#hidden_ntid").next().hide();
                }
			});
		});
	</script>
</head>
<body>

<div id="planDialog" style="padding: 20px;width: auto;">
	<form id="addForm" method="post">
		<table id="addTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" align="center">
			<c:if test="${user.type eq 3}" var="result">
			<tr>
				<td width="200">任务执行人:</td>
				<td width="350">
					<input id="add_taskexecuter" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="taskexecuter" data-options="required:true, missingMessage:'请输入任务执行人'"/>
				</td>
			</tr>
			</c:if>
			<c:if test="${!result }">
				<tr>
					<td width="200">任务执行人:</td>
					<td width="350">
						<input value="${user.name}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="taskexecuter" data-options="editable:false"/>
					</td>
				</tr>
			</c:if>
			<tr>
				<td width="200">教师名称:</td>
				<td width="350">
					<input id="add_teachername"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="teachername" data-options="required:true, missingMessage:'请输入教师名称'"/>
				</td>
			</tr>
			<tr>
				<td width="200">课程名称:</td>
				<td width="350">
					<input id="add_coursename"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="coursename" data-options="required:true, missingMessage:'请输入课程名称'"/>
				</td>
			</tr>
			<tr>
				<td width="200">上课地点:</td>
				<td width="350">
					<input id="add_roomlocation"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入上课地点,示例：H1208'"/>
				</td>
			</tr>
			<tr>
				<td width="200">上课日期:</td>
				<td width="350">
                    <input id="add_time" style="width: 300px; height: 30px;" class="easyui-datebox" type="text" name="etime" data-options="required:true, missingMessage:'请选择上课日期', editable:false" />
				</td>
			</tr>
			<tr>
				<td width="200">课程类型:</td>
				<td width="350">
					<select id="add_lessontype" class="easyui-combobox" name="lessontype" style="width:300px; height: 30px;" data-options="editable:false">
						<option value="公共课">公共课</option>
						<option>基础课</option>
						<option>专业课</option>
						<option>必修课</option>
						<option>选修课</option>
						<option>公共基础课</option>
						<option>专业基础课</option>
						<option>专业基础选修课</option>
						<option>专业选修课</option>
						<option>专业方向选修课</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="200">上课节次:</td>
				<td width="350">
					<input id="add_lessonno"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="lessonno"  data-options="required:true, missingMessage:'请输入上课节次,示例：1-2'" />
				</td>
			</tr>
			<tr>
				<td width="200">讲授类型:</td>
				<td width="350">
					<select id="add_classtype" class="easyui-combobox" name="classtype" style="width:300px; height: 30px;" data-options="editable:false">
						<option value="理论课">理论课</option>
						<option>实验课</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="200">备注:</td>
				<td width="350">
					<input id="add_comment"  class="easyui-textbox" style="width: 300px; height: 100px;" type="text" data-options="multiline: true" name="comment" />
				</td>
			</tr>
		</table>
        <input id="hidden_finished" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="finished" />
        <input id="hidden_ntid" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="ntid" />
	</form>
	</div>
</div>
	
</body>
</html>