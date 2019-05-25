<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>教室列表</title>
	<link rel="stylesheet" type="text/css" href="easyui/themes/material-teal/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="easyui/css/demo.css">
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/js/validateExtends.js"></script>
	<script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		$(function() {

			//datagrid初始化
			$('#dataList').datagrid({
				title:'教室列表',
				border: true,
				collapsible:false,//是否可折叠的
				fit: true,//自动大小
				method: "post",
				url:"RoomController?method=RoomList&t="+new Date().getTime(),
				idField:'roomlocation',
				singleSelect:false,//是否单选
				pagination:true,//分页控件
				rownumbers:true,//行号
				sortName:'roomlocation',
				sortOrder:'asc',
				remoteSort: false,
				columns: [[
					{field:'blank',width:40},
					{field:'roomlocation',title:'位置',width:100, sortable: true},
					{field:'roomusage',title:'用途',width:150},
					{field:'roomtype',title:'类型',width:100}
				]],
				toolbar: "#toolbar"
			});

			//设置分页控件
			var p = $('#dataList').datagrid('getPager');
			$(p).pagination({
				pageSize: 10,//每页显示的记录条数，默认为10
				pageList: [10,30,50,100],//可以设置每页记录条数的列表
				beforePageText: '第',//页数文本框前显示的汉字
				afterPageText: '页    共 {pages} 页',
				displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
			});

			//设置工具类按钮
			$("#add").click(function(){
				$("#addDialog").dialog("open");
			});

			//修改
			$("#edit").click(function(){
				var selectRows = $("#dataList").datagrid("getSelections");
				if(selectRows.length != 1){
					$.messager.alert("", "请选择一条数据进行操作!", "warning");
				} else{
					$("#editDialog").dialog("open");
				}
			});

			//删除
			$("#delete").click(function(){
				var selectRows = $("#dataList").datagrid("getSelections");
				var selectLength = selectRows.length;
				if(selectLength == 0){
					$.messager.alert("", "请选择数据进行删除!", "warning");
				} else{
					var roomlocations = [];
					$(selectRows).each(function(i, row){
						roomlocations[i] = row.roomlocation;
					});
					$.messager.confirm("", "将删除教室，确认继续？", function(r){
						if(r){
							$.ajax({
								type: "post",
								url: "RoomController?method=DeleteRoom",
								data: {roomlocations: roomlocations},
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("","删除成功!","info");
										//刷新表格
										$("#dataList").datagrid("reload");
										$("#dataList").datagrid("uncheckAll");
									} else{
										$.messager.alert("","删除失败!","warning");
									}
								}
							});
						}
					});
				}
			});

			//设置添加窗口
			$("#addDialog").dialog({
				title: "添加教室",
				width: 380,
				height: 250,
				iconCls: "icon-add",
				modal: true,
				collapsible: false,
				minimizable: false,
				maximizable: false,
				draggable: true,
				closed: true,
				buttons: [
					{
						text:'添加教室',
						plain: true,
						iconCls:'icon-user_add',
						handler:function()
						{
							var validate = $("#addForm").form("validate");
							if(!validate)
							{
								$.messager.alert("","请检查你输入的数据!","warning");
							}
							else
							{
								$.ajax({
									type: "post",
									url: "RoomController?method=AddRoom",
									data: $("#addForm").serialize(),
									success: function(msg){
										if(msg == "success"){
											$.messager.alert("","添加成功!","info");
											//关闭窗口
											$("#addDialog").dialog("close");
											//清空原表格数据
											$("#add_roomlocation").textbox('setValue', "");
											$("#add_roomusage").textbox('setValue', "");
											$("#add_roomtype").textbox('setValue', "");
											//重新刷新页面数据
											$('#dataList').datagrid("reload");
											$("#dataList").datagrid("uncheckAll");

										} else{
											$.messager.alert("","添加失败!","warning");
										}
									}
								});
							}
						}
					},
					{
						text:'清空表单',
						plain: true,
						iconCls:'icon-reload',
						handler:function(){
							//清空表单
							$("#add_roomlocation").textbox('setValue', "");
							$("#add_roomusage").textbox('setValue', "");
							$("#add_roomtype").textbox('setValue', "");
						}
					}
				]
			});

			//设置编辑窗口
			$("#editDialog").dialog({
				title: "编辑教室信息",
				width: 380,
				height: 250,
				iconCls: "icon-edit",
				modal: true,
				collapsible: false,
				minimizable: false,
				maximizable: false,
				draggable: true,
				closed: true,
				buttons: [
					{
						text:'确认修改',
						plain: true,
						iconCls:'icon-user_add',
						handler:function(){
							var validate = $("#editForm").form("validate");
							if(!validate)
							{
								$.messager.alert("","请检查你输入的数据!","warning");
							}
							else
							{
								$.ajax({
									type: "post",
									url: "RoomController?method=EditRoom",
									data: $("#editForm").serialize(),
									success: function(msg)
									{
										if(msg == "success")
										{
											$.messager.alert("","更新成功!","info");
											//关闭窗口
											$("#editDialog").dialog("close");
											//刷新表格
											$("#dataList").datagrid("reload");
											$("#dataList").datagrid("uncheckAll");
										}
										else
										{
											$.messager.alert("","未知错误!","warning");
										}
									}
								});
							}
						}
					},
					{
						text:'清空表单',
						plain: true,
						iconCls:'icon-reload',
						handler:function(){
							//清空表单
							$("#edit_roomlocation").textbox('setValue', "");
							$("#edit_roomusage").textbox('setValue', "");
							$("#edit_roomtype").textbox('setValue', "");
						}
					}
				],
				onBeforeOpen: function(){
					var selectRow = $("#dataList").datagrid("getSelected");
					//设置值
					$("#edit_roomlocation").textbox('setValue', selectRow.roomlocation);
					$("#edit_roomusage").textbox('setValue', selectRow.roomusage);
					$("#edit_roomtype").textbox('setValue', selectRow.roomtype);
					$("#hidden_roomlocation").textbox('setValue', selectRow.roomlocation);
					$("#hidden_roomlocation").next().hide();
				}
			});

		});
	</script>
</head>
<body>
<!-- 数据列表 -->
<table id="dataList" cellspacing="0" cellpadding="0">

</table>
<c:if test="${user.type eq 3}">
<!-- 工具栏 -->
<div id="toolbar">
	<div style="float: left;"><a id="add" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a></div>
	<div style="float: left;" class="datagrid-btn-separator"></div>
	<div style="float: left;"><a id="edit" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></div>
	<div style="float: left;" class="datagrid-btn-separator"></div>
	<div><a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
</div>
</c:if>
<!-- 添加窗口 -->
<div id="addDialog" style="padding: 10px">
	<form id="addForm" method="post">
		<table cellpadding="8" >
			<tr>
				<td>位置:</td>
				<td>
					<input id="add_roomlocation" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入教室位置, 示例: H1208'" />
				</td>
			</tr>
			<tr>
				<td>用途:</td>
				<td><input id="add_roomusage" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="roomusage"/></td>
			</tr>
			<tr>
				<td>类型:</td>
				<td>
				<select id="add_roomtype" class="easyui-combobox" name="roomtype" style="width:200px; height: 30px;">
					<option value="教室">教室</option>
					<option>实验室</option>
				</select>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- 修改窗口 -->
<div id="editDialog" style="padding: 10px">
	<form id="editForm" method="post">
		<table cellpadding="8" >
			<tr>
				<td>位置:</td>
				<td>
					<input id="edit_roomlocation" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入教室位置, 示例: H1208'" />
				</td>
			</tr>
			<tr>
				<td>用途:</td>
				<td><input id="edit_roomusage" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="roomusage"/></td>
			</tr>
			<tr>
				<td>类型:</td>
				<td>
				<select id="edit_roomtype" class="easyui-combobox" name="roomtype" style="width:200px; height: 30px;">
					<option>教室</option>
					<option>实验室</option>
				</select>
				</td>
			</tr>
		</table>
		<input id="hidden_roomlocation" class="easyui-textbox" type="hidden" name="eroomlocation">
	</form>
</div>

</body>
</html>