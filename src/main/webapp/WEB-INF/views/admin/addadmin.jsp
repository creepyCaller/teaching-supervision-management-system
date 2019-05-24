<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>添加管理员</title>
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
        .table-striped tbody > tr:nth-child(odd) > td,.table-striped tbody > tr:nth-child(odd) > th{background-color:#fff}
    </style>
    <script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/js/validateExtends.js"></script>
    <script type="text/javascript">
        $(function() {

            //添加管理员窗口
            $("#addDialog").dialog({
                title: "添加管理员",
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
                        text:'确定添加',
                        plain: true,
                        iconCls:'icon-ok',
                        handler:function()
                        {
                            var validate = $("#addAdmin").form("validate");
                            if(!validate)
                            {
                                $.messager.alert("","请检查你输入的数据!","warning");
                            }
                            else
                            {
                                $.ajax({
                                    type: "post",
                                    url: "AddAdminController?method=AddAdmin&t="+new Date().getTime(),
                                    data: $("#addAdmin").serialize(),
                                    success: function(msg)
                                    {
                                        if(msg == "success")
                                        {
                                            $.messager.alert("","添加成功","info");
                                            //清空表单
                                            $("#username").textbox('setValue', "");
                                            $("#password").textbox('setValue', "");
                                            $("#re_password").textbox('setValue', "");
                                        }
                                        else
                                        {
                                            $.messager.alert("","添加失败","warning")
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
                            $("#username").textbox('setValue', "");
                            $("#password").textbox('setValue', "");
                            $("#re_password").textbox('setValue', "");
                        }
                    }
                ]
            });

        })
    </script>
</head>
<body>

<div id="addDialog" style="padding: 20px;">
    <div style="width: auto">
        <form id="addAdmin">
        <table id="systemTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8"  align="center">
            <tr>
                <td width="200">管理员ID:</td>
                <td>
                    <input id="username" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="username" data-options="required:true, missingMessage:'请填写管理员ID'"/>
                </td>
            </tr>
            <tr>
                <td width="200">密码:</td>
                <td>
                    <input id="password" style="width: 300px; height: 30px;" class="easyui-textbox" type="password" validType="password" name="password" data-options="required:true, missingMessage:'请输入密码'" />
                </td>
            </tr>
            <tr>
                <td width="200">确认密码:</td>
                <td><input id="re_password" name="re_password"style="width: 300px; height: 30px;" class="easyui-textbox" type="password" validType="equals['#password']"  data-options="required:true, missingMessage:'请再次输入密码'" /></td>
            </tr>
        </table>
        </form>
    </div>
</div>

</body>
</html>