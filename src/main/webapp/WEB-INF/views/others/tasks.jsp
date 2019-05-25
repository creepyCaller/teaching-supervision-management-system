<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>听课任务</title>

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
        .table td{text-align:center}
        .table-border{border-top:1px solid #ddd}
        .table-border th,.table-border td{border-bottom:1px solid #ddd}
        .table-bordered{border:1px solid #ddd;border-collapse:separate;*border-collapse:collapse;border-left:0}
        .table-bordered th,.table-bordered td{border-left:1px solid #ddd}
        .table-border.table-bordered{border-bottom:0}
        .table-striped tbody > tr:nth-child(odd) > td,.table-striped tbody > tr:nth-child(odd) > th{background-color:#fff}
    </style>
	<script type="text/javascript">
		$(function() {
			//datagrid初始化
			$('#dataList').datagrid({
				title:'听课任务',
				border: true,
				collapsible: false,//是否可折叠的
				fit: true,//自动大小
				method: "post",
				url:"TaskController?method=RTaskList&t="+new Date().getTime(),
				idField:'etime',
				singleSelect: false,//是否单选
				pagination: true,//分页控件
				rownumbers: true,//行号
				sortName:'etime',
				sortOrder:'desc',
				remoteSort: false,
				columns: [[
                    {field:'blank',width:40},
					{field:'id',title:'ID',width:50, sortable: true},
					{field:'taskexecuter',title:'任务执行人',width:75, sortable: true},
					{field:'teachername',title:'教师名称',width:75, sortable: true},
                    {field:'coursename',title:'课程名称',width:150, sortable: true},
                    {field:'roomlocation',title:'上课地点',width:100, sortable: true},
                    {field:'etime',title:'上课日期',width:100, sortable: true},
                    {field:'lessontype',title:'课程类型',width:100, sortable: true},
                    {field:'lessonno',title:'上课节次',width:100, sortable: true},
					{field:'classtype',title:'讲授类型',width:100, sortable: true,
						formatter: function(value,row,index) {
							if(value == 0){
								return "理论课"
							} else {
								return "实验课";
							}
						}
					},
                    {field:'comment',title:'备注',width:200},
					{field:'finished',title:'完成情况',width:100, sortable: true,
						formatter: function(value,row,index) {
							if (value == 0){
                                return "未完成"
                            } else {
                                return "已完成";
                            }
						}
					}
				]],
				toolbar: "#toolbar"
			});
			//设置分页控件
			var p = $('#dataList').datagrid('getPager');
			$(p).pagination({
				pageSize: 10,//每页显示的记录条数, 默认为10
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

            //查看
            $("#view").click(function () {
                var selectRows = $("#dataList").datagrid("getSelected");
                var selecttions = $("#dataList").datagrid("getSelections");
                if(selecttions.length != 1) {
                    $.messager.alert("", "请选择一项任务!", "warning");
                } else {
                    $.ajax({
                        type: "post",
                        url: "ViewController?method=ViewComment",
                        data: {finished:selectRows.finished, ntid:selectRows.ntid, classtype:selectRows.classtype},
                        dataType: "text",
                        success: function(result){
                            if(result == "0") {
                                $("#viewNorDialog").dialog("open");
                            } else if(result == "1") {
                                $("#viewLabDialog").dialog("open");
                            } else {
                                $.messager.alert("", "请选择一项已完成的任务!", "warning");
                            }
                        }
                    });
                }
            });

            //删除
            $("#delete").click(function(){
                var selectRows = $("#dataList").datagrid("getSelections");
                var selectLength = selectRows.length;
                if(selectLength == 0){
                    $.messager.alert("", "请选择数据进行删除!", "warning");
                } else{
                    var ids = [];
                    $(selectRows).each(function(i, row){
                        ids[i] = row.id;
                    });
                    $.messager.confirm("", "将删除任务,确认继续?", function(r){
                        if(r){
                            $.ajax({
                                type: "post",
                                url: "TaskController?method=DeleteTask",
                                data: {ids: ids},
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

            $("#reload").click(function (){
                //刷新表格
                $("#dataList").datagrid("reload");
                $("#dataList").datagrid("uncheckAll");
            });

            //去评价
            $("#toComment").click(function()
            {
                var selectRows = $("#dataList").datagrid("getSelected");
                var selecttions = $("#dataList").datagrid("getSelections");
                if(selecttions.length != 1) {
                    $.messager.alert("", "请选择一项任务!", "warning");
                } else {
                    var data = {id: selectRows.id, taskexecuter: selectRows.taskexecuter, teachername:selectRows.teachername,coursename:selectRows.coursename, roomlocation: selectRows.roomlocation, lessontype: selectRows.lessontype, etime: selectRows.etime, lessonno: selectRows.lessonno, classtype: selectRows.classtype, finished: selectRows.finished, ntid: selectRows.ntid};
                    //携带数据跳转至评价界面
                    $.ajax({
                        type: "post",
                        url: "TaskController?method=toCommentPage",
                        data: data,
                        dataType: "text",
                        success: function(result){
                            if(result == "0") {
                                window.location.href = "/tsmgr/normalcoursewithvalue.jsp";
                            } else if(result == "1") {
                                window.location.href = "/tsmgr/labcoursewithvalue.jsp";
                            } else {
                                $.messager.alert("", "请选择一项未完成的任务!", "warning");
                            }
                        }
                    });
                }
            });

            //设置添加窗口
            $("#addDialog").dialog({
                title: "新增任务",
                width: 380,
                height: 580,
                iconCls: "icon-add",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text:'添加任务',
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
                                $.ajax({
                                    type: "post",
                                    url: "TaskController?method=AddTask",
                                    data: $("#addForm").serialize(),
                                    success: function(msg){
                                        if(msg == "success"){
                                            $.messager.alert("","添加成功!","info");
                                            //关闭窗口
                                            $("#addDialog").dialog("close");
                                            //清空原表格数据
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
                                            $("#add_ntid").textbox('setValue', "0");
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
                            $("#add_ntid").textbox('setValue', "0");
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

            //设置编辑窗口
            $("#editDialog").dialog({
                title: "编辑任务信息",
                width: 380,
                height: 580,
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
                        iconCls:'icon-ok',
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
                                    url: "TaskController?method=EditTask",
                                    data: $("#editForm").serialize(),
                                    success: function(msg)
                                    {
                                        if(msg == "success")
                                        {
                                            $.messager.alert("","更新成功!","info");
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
                            $("#edit_taskexecuter").textbox('setValue', "");
                            $("#edit_teachername").textbox('setValue', "");
                            $("#edit_coursename").textbox('setValue', "");
                            $("#edit_roomlocation").textbox('setValue', "");
                            $("#edit_time").textbox('setValue', "");
                            $("#edit_lessontype").textbox('setValue', "基础课");
                            $("#edit_lessonno").textbox('setValue', "");
                            $("#edit_classtype").textbox('setValue', "理论课");
                            $("#edit_comment").textbox('setValue', "");
                            $("#edit_finished").textbox('setValue', "0");
                            $("#edit_ntid").textbox('setValue', "0");
                        }
                    }
                ],
                onBeforeOpen: function(){
                    var selectRow = $("#dataList").datagrid("getSelected");
                    //设置值
                    $("#hidden_id").textbox('setValue', selectRow.id);
                    $("#hidden_id").next().hide();
                    $("#edit_taskexecuter").textbox('setValue', selectRow.taskexecuter);
                    $("#edit_teachername").textbox('setValue', selectRow.teachername);
                    $("#edit_coursename").textbox('setValue', selectRow.coursename);
                    $("#edit_roomlocation").textbox('setValue', selectRow.roomlocation);
                    $("#edit_time").textbox('setValue', selectRow.etime);
                    $("#edit_lessontype").textbox('setValue', selectRow.lessontype);
                    $("#edit_lessonno").textbox('setValue', selectRow.lessonno);
                    if(selectRow.classtype) {
                        $("#edit_classtype").textbox('setValue', "实验课");
                    } else {
                        $("#edit_classtype").textbox('setValue', "理论课");
                    }$("#edit_comment").textbox('setValue', selectRow.comment);
                    if(selectRow.finished) {
                        $("#edit_finished").textbox('setValue',"已完成");
                    } else {
                        $("#edit_finished").textbox('setValue',"未完成");
                    }
                    if(selectRow.ntid) {
                        $("#edit_ntid").textbox('setValue', selectRow.ntid);
                    } else {
                        $("#edit_ntid").textbox('setValue', "0");
                    }
                }
            });
		});
	</script>
</head>
<body>
<!-- 数据列表 -->
<table id="dataList" cellspacing="0" cellpadding="0">

</table>
<!-- 工具栏 -->
<div id="toolbar">
    <div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="reload" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div><a id="toComment" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">去评价页</a></div>
</div>

<!-- 添加窗口 -->
<div id="addDialog" style="padding: 10px">
	<form id="addForm" method="post">
        <table id="addTable" cellpadding="8" >
            <c:if test="${user.type eq 3}" var="result">
            <tr>
                <td>任务执行人:</td>
                <td><input id="add_taskexecuter"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="taskexecuter" data-options="required:true, missingMessage:'请输入任务执行人'" /></td>
            </tr>
            </c:if>
            <c:if test="${!result}">
                <tr>
                    <td>任务执行人:</td>
                    <td><input value="${user.name}" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="taskexecuter" data-options="editable:false" /></td>
                </tr>
            </c:if>
            <tr>
                <td>教师名称:</td>
                <td><input id="add_teachername"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teachername" data-options="required:true, missingMessage:'请输入教师名称'" /></td>
            </tr>
            <tr>
                <td>课程名称:</td>
                <td><input id="add_coursename"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="coursename" data-options="required:true, missingMessage:'请输入课程名称'" /></td>
            </tr>
            <tr>
                <td>上课地点:</td>
                <td><input id="add_roomlocation"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入上课地点,示例：H1208'" /></td>
            </tr>
            <tr>
                <td>上课日期:</td>
                <td><input id="add_time" style="width: 200px; height: 30px;" class="easyui-datebox" type="text" name="etime" data-options="required:true, missingMessage:'请选择上课日期', editable:false" /></td>
            </tr>
            <tr>
                <td>课程类型:</td>
                <td>
                    <select id="add_lessontype" class="easyui-combobox" name="lessontype" style="width:200px; height: 30px;" data-options="editable:false">
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
                <td>上课节次:</td>
                <td><input id="add_lessonno"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="lessonno" data-options="required:true, missingMessage:'请输入上课节次,示例：1-2'" /></td>
            </tr>
            <tr>
                <td>讲授类型:</td>
                <td>
                    <select id="add_classtype" class="easyui-combobox" name="classtype" style="width:200px; height: 30px;" data-options="editable:false">
                        <option value="0">理论课</option>
                        <option value="1">实验课</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>备注:</td>
                <td><input id="add_comment" style="width: 200px; height: 70px;" class="easyui-textbox" data-options="multiline: true" name="comment" /></td>
            </tr>
            <input id="hidden_finished" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="finished" />
            <input id="hidden_ntid" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="ntid" />
        </table>
	</form>
</div>

<!-- 修改窗口 -->
<div id="editDialog" style="padding: 10px">
    <form id="editForm" method="post">
        <table cellpadding="8" >
            <c:if test="${user.type eq 2}" var="result1">
            <tr>
                <td>任务执行人:</td>
                <td><input class="easyui-textbox" value="${user.name}" style="width: 200px; height: 30px;" type="text" name="taskexecuter" data-options="editable:false" /></td>
            </tr>
            </c:if>
            <c:if test="${!result1}">
            <tr>
                <td>任务执行人:</td>
                <td><input id="edit_taskexecuter" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="taskexecuter" data-options="required:true, missingMessage:'请输入任务执行人'" /></td>
            </tr>
            </c:if>
            <tr>
                <td>教师名称:</td>
                <td><input id="edit_teachername"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teachername" data-options="required:true, missingMessage:'请输入教师名称'" /></td>
            </tr>
            <tr>
                <td>课程名称:</td>
                <td><input id="edit_coursename"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="coursename" data-options="required:true, missingMessage:'请输入课程名称'" /></td>
            </tr>
            <tr>
                <td>上课地点:</td>
                <td><input id="edit_roomlocation"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入上课地点,示例：H1208'" /></td>
            </tr>
            <tr>
                <td>上课日期:</td>
                <td><input id="edit_time" style="width: 200px; height: 30px;" class="easyui-datebox" type="text" name="etime" data-options="required:true, missingMessage:'请选择上课日期', editable:false" /></td>
            </tr>
            <tr>
                <td>课程类型:</td>
                <td>
                    <select id="edit_lessontype" class="easyui-combobox" name="lessontype" style="width:200px; height: 30px;" data-options="editable:false">
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
                <td>上课节次:</td>
                <td><input id="edit_lessonno"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="lessonno" data-options="required:true, missingMessage:'请输入上课节次,示例：1-2'" /></td>
            </tr>
            <tr>
                <td>讲授类型:</td>
                <td>
                    <select id="edit_classtype" class="easyui-combobox" name="classtype" style="width:200px; height: 30px;" data-options="editable:false">
                        <option value="0">理论课</option>
                        <option value="1">实验课</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>备注:</td>
                <td><input id="edit_comment" style="width: 200px; height: 70px;" class="easyui-textbox" data-options="multiline: true," name="comment" /></td>
            </tr>
            <tr>
            <input id="hidden_id" class="easyui-textbox" type="hidden" name="id">
        </table>
    </form>
</div>

</body>
</html>