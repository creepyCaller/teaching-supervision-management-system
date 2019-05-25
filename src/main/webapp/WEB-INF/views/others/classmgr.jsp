<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>班级列表</title>
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
                title:'班级列表',
                border: true,
                collapsible:false,//是否可折叠的
                fit: true,//自动大小
                method: "post",
                url:"ClassController?method=ClassList&t="+new Date().getTime(),
                idField:'classname',
                singleSelect:false,//是否单选
                pagination:true,//分页控件
                rownumbers:true,//行号
                sortName:'classname',
                sortOrder:'DESC',
                remoteSort: false,
                columns: [[
                    {field:'blank',width:40},
                    {field:'classname',title:'班别',width:200, sortable: true},
                    {field:'major',title:'主修专业',width:200},
                    {field:'school',title:'所属院系',width:200}
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
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
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
                    var classes = [];
                    $(selectRows).each(function(i, row){
                        classes[i] = row.classname;
                    });
                    $.messager.confirm("", "将删除班级，确认继续?", function(r){
                        if(r){
                            $.ajax({
                                type: "post",
                                url: "ClassController?method=DeleteClass",
                                data: {classes: classes},
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
                title: "添加班级",
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
                        text:'添加班级',
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
                                    url: "ClassController?method=AddClass",
                                    data: $("#addForm").serialize(),
                                    success: function(msg){
                                        if(msg == "success"){
                                            $.messager.alert("","添加成功!","info");
                                            //关闭窗口
                                            $("#addDialog").dialog("close");
                                            //清空原表格数据
                                            $("#add_id").textbox('setValue', "");
                                            $("#add_teachername").textbox('setValue', "");

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
                            $("#add_classname").textbox('setValue', "");
                            $("#add_major").textbox('setValue', "");
                            $("#add_school").textbox('setValue', "大气科学学院");
                        }
                    }
                ]
            });

            //设置编辑窗口
            $("#editDialog").dialog({
                title: "编辑班级信息",
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
                        iconCls:'icon-ok',
                        handler:function(){
                            var validate = $("#editForm").form("validate");
                            if(!validate)
                            {
                                $.messager.alert("","请检查你输入的数据!","warning");
                                return;
                            }
                            else
                            {
                                $.ajax({
                                    type: "post",
                                    url: "ClassController?method=EditClass",
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
                            $("#edit_classname").textbox('setValue', "");
                            $("#edit_major").textbox('setValue', "");
                            $("#edit_school").textbox('setValue', "大气科学学院");
                        }
                    }
                ],
                onBeforeOpen: function(){
                    var selectRow = $("#dataList").datagrid("getSelected");
                    //设置值
                    $("#edit_classname").textbox('setValue', selectRow.classname);
                    $("#hidden_classname").textbox('setValue', selectRow.classname);
                    $("#hidden_classname").next().hide();
                    $("#edit_major").textbox('setValue', selectRow.major);
                    $("#edit_school").textbox('setValue', selectRow.school);
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
                <td>班级名称:</td>
                <td>
                    <input id="add_classname"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="classname" data-options="required:true, missingMessage:'请输入班级名称'" />
                </td>
            </tr>
            <tr>
                <td>主修专业:</td>
                <td><input id="add_major" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="major" data-options="required:true, missingMessage:'请填写主修专业'" /></td>
            </tr>
            <tr>
                <td>所属院系:</td>
                <td>
                    <select id="add_school" class="easyui-combobox" name="school" style="width:200px; height: 30px;" data-options="editable:false">
                        <option value="大气科学学院">大气科学学院</option>
                        <option>资源环境学院</option>
                        <option>电子工程学院</option>
                        <option>通信工程学院</option>
                        <option>计算机学院</option>
                        <option>软件工程学院</option>
                        <option>网络空间安全学院</option>
                        <option>光电技术学院</option>
                        <option>应用数学学院</option>
                        <option>管理学院</option>
                        <option>商学院</option>
                        <option>统计学院</option>
                        <option>物流学院</option>
                        <option>文化艺术学院</option>
                        <option>外国语学院</option>
                        <option>控制工程学院</option>
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
                <td>班级名称:</td>
                <td>
                    <input id="edit_classname"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="classname" data-options="required:true, missingMessage:'请输入班级名称'" />
                </td>
            </tr>
            <tr>
                <td>主修专业:</td>
                <td><input id="edit_major" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="major" data-options="required:true, missingMessage:'请填写主修专业'" /></td>
            </tr>
            <tr>
                <td>所属院系:</td>
                <td>
                    <select id="edit_school" class="easyui-combobox" name="school" style="width:200px; height: 30px;" data-options="editable:false">
                        <option value="大气科学学院">大气科学学院</option>
                        <option>资源环境学院</option>
                        <option>电子工程学院</option>
                        <option>通信工程学院</option>
                        <option>计算机学院</option>
                        <option>软件工程学院</option>
                        <option>网络空间安全学院</option>
                        <option>光电技术学院</option>
                        <option>应用数学学院</option>
                        <option>管理学院</option>
                        <option>商学院</option>
                        <option>统计学院</option>
                        <option>物流学院</option>
                        <option>文化艺术学院</option>
                        <option>外国语学院</option>
                        <option>控制工程学院</option>
                    </select>
                </td>
            </tr>
        </table>
        <input id="hidden_classname" class="easyui-textbox" type="hidden" name="eclassname">
    </form>
</div>

</body>
</html>