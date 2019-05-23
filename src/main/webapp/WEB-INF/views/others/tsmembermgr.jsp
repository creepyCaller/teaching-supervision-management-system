<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="UTF-8">
    <title>督导员列表</title>
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
                title:'督导员列表',
                border: true,
                collapsible:false,//是否可折叠的
                fit: true,//自动大小
                method: "post",
                url:"TSMemberController?method=TSMemberList&t="+new Date().getTime(),
                idField:'id',
                singleSelect:false,//是否单选
                pagination:true,//分页控件
                rownumbers:true,//行号
                sortName:'id',
                sortOrder:'DESC',
                remoteSort: false,
                columns: [[
                    {field:'chk',checkbox: true,width:50},
                    {field:'id',title:'工号',width:100, sortable: true},
                    {field:'sgmname',title:'姓名',width:100}
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
                    var ids = [];
                    $(selectRows).each(function(i, row){
                        ids[i] = row.id;
                    });
                    $.messager.confirm("", "将删除督导员，确认继续?", function(r){
                        if(r){
                            $.ajax({
                                type: "post",
                                url: "TSMemberController?method=DeleteTSMember",
                                data: {ids: ids},
                                success: function(msg){
                                    if(msg == "success"){
                                        $.messager.alert("","删除成功!","info");
                                        //刷新表格
                                        $("#dataList").datagrid("reload");
                                        $("#dataList").datagrid("uncheckAll");
                                    } else{
                                        $.messager.alert("","删除失败!","warning");
                                        return;
                                    }
                                }
                            });
                        }
                    });
                }
            });

            //设置添加窗口
            $("#addDialog").dialog({
                title: "添加督导员",
                width: 380,
                height: 200,
                iconCls: "icon-add",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text:'添加督导员',
                        plain: true,
                        iconCls:'icon-user_add',
                        handler:function()
                        {
                            var validate = $("#addForm").form("validate");
                            if(!validate)
                            {
                                $.messager.alert("","请检查你输入的数据!","warning");
                                return;
                            }
                            else
                            {
                                $.ajax({
                                    type: "post",
                                    url: "TSMemberController?method=AddTSMember",
                                    data: $("#addForm").serialize(),
                                    success: function(msg){
                                        if(msg == "success"){
                                            $.messager.alert("","添加成功!","info");
                                            //关闭窗口
                                            $("#addDialog").dialog("close");
                                            //清空原表格数据
                                            $("#add_id").textbox('setValue', "");
                                            $("#add_sgmname").textbox('setValue', "");

                                            //重新刷新页面数据
                                            $('#dataList').datagrid("reload");
                                            $("#dataList").datagrid("uncheckAll");

                                        } else{
                                            $.messager.alert("","添加失败!","warning");
                                            return;
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
                            $("#add_id").textbox('setValue', "");
                            $("#add_sgmname").textbox('setValue', "");
                        }
                    },
                ]
            });

            //设置编辑窗口
            $("#editDialog").dialog({
                title: "编辑督导员信息",
                width: 380,
                height: 200,
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
                                return;
                            }
                            else
                            {
                                $.ajax({
                                    type: "post",
                                    url: "TSMemberController?method=EditTSMember",
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
                                            $.messager.alert("","id超过取值范围!","warning");
                                            return;
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
                            $("#edit_sgmname").textbox('setValue', "");
                            $("#edit_id").textbox('setValue', "");
                        }
                    }
                ],
                onBeforeOpen: function(){
                    var selectRow = $("#dataList").datagrid("getSelected");
                    //设置值
                    $("#edit_id").textbox('setValue', selectRow.id);
                    $("#hidden_id").textbox('setValue', selectRow.id);
                    $("#hidden_id").next().hide();
                    $("#edit_sgmname").textbox('setValue', selectRow.sgmname);
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
                <td>工号:</td>
                <td>
                    <input id="add_id"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="id" data-options="required:true, missingMessage:'请输入工号'" />
                </td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input id="add_sgmname" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="sgmname" data-options="required:true, missingMessage:'请填写姓名'" /></td>
            </tr>
        </table>
    </form>
</div>

<!-- 修改窗口 -->
<div id="editDialog" style="padding: 10px">
    <form id="editForm" method="post">
        <table cellpadding="8" >
            <tr>
                <td>工号:</td>
                <td>
                    <input id="edit_id" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="id" data-options="required:true, missingMessage:'请输入工号'" />
                </td>
            </tr>
            <tr>
                <td>姓名:</td>
                <td><input id="edit_sgmname" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="sgmname" data-options="required:true, missingMessage:'请填写姓名'" /></td>
            </tr>
        </table>
        <input id="hidden_id" class="easyui-textbox" type="hidden" name="eid">
    </form>
</div>

</body>
</html>