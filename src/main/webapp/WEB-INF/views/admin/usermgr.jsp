<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
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
                title:'用户列表',
                border: true,
                collapsible:false,//是否可折叠的
                fit: true,//自动大小
                method: "post",
                url:"UserController?method=UserList&t="+new Date().getTime(),
                idField:'username',
                singleSelect:false,//是否单选
                pagination:true,//分页控件
                rownumbers:true,//行号
                sortName:'username',
                sortOrder:'desc',
                remoteSort: false,
                columns: [[
                    {field:'blank',width:40},
                    {field:'username',title:'用户名',width:150, sortable: true},
                    {field:'type',title:'用户类型',width:100,
                        formatter: function(value,row,index){
                            if(value == 1){
                                return "督导员"
                            } else if(value == 2) {
                                return "教师";
                            } else if(value == 3) {
                                return "管理员";
                            }
                        }
                    },
                    {field:'teachername',title:'教师姓名',width:100},
                    {field:'sgmname',title:'督导姓名',width:100},
                    {field:'etime',title:'注册日期',width:100, sortable: true}
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

            //删除
            $("#delete").click(function(){
                var selectRows = $("#dataList").datagrid("getSelections");
                var selectLength = selectRows.length;
                if(selectLength == 0){
                    $.messager.alert("", "请选择数据进行删除!", "warning");
                } else{
                    var unames = [];
                    $(selectRows).each(function(i, row){
                        unames[i] = row.username;
                    });
                    $.messager.confirm("", "将删除用户，确认继续?", function(r){
                        if(r){
                            $.ajax({
                                type: "post",
                                url: "UserController?method=DeleteUsers",
                                data: {unames: unames},
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

        });
    </script>
</head>
<body>
<!-- 数据列表 -->
<table id="dataList" cellspacing="0" cellpadding="0">

</table>
<!-- 工具栏 -->
<div id="toolbar">
    <div><a id="delete" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
</div>
</body>
</html>