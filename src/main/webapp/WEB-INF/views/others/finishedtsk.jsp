<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="UTF-8">
    <title>已完成任务</title>

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
        .table-striped tbody > tr:nth-child(odd) > td,.table-striped tbody > tr:nth-child(odd) > th{background-color:#f9f9f9}
    </style>
    <script type="text/javascript">
        $(function() {
            //datagrid初始化
            $('#dataList').datagrid({
                title:'已完成任务',
                border: true,
                collapsible: false,//是否可折叠的
                fit: true,//自动大小
                method: "post",
                url:"TaskController?method=FTaskList&t="+new Date().getTime(),
                idField:'id',
                singleSelect: false,//是否单选
                pagination: true,//分页控件
                rownumbers: true,//行号
                sortName:'id',
                sortOrder:'desc',
                remoteSort: false,
                columns: [[
                    {field:'chk',checkbox: true,width:50},
                    {field:'id',title:'ID',width:25, sortable: true},
                    {field:'taskexecuter',title:'任务执行人',width:75, sortable: true},
                    {field:'teachername',title:'教师名称',width:75, sortable: true},
                    {field:'coursename',title:'课程名称',width:150, sortable: true},
                    {field:'roomlocation',title:'上课地点',width:100, sortable: true},
                    {field:'etime',title:'上课日期',width:100, sortable: true},
                    {field:'lessontype',title:'课程类型',width:100, sortable: true},
                    {field:'lessonno',title:'上课节次',width:60, sortable: true},
                    {field:'classtype',title:'讲授类型',width:60, sortable: true,
                        formatter: function(value,row,index) {
                            if(value == 0){
                                return "理论课"
                            } else {
                                return "实验课";
                            }
                        }
                    },
                    {field:'comment',title:'备注',width:200},
                    {field:'finished',title:'完成情况',width:60, sortable: true,
                        formatter: function(value,row,index) {
                            if (value == 0){
                                return "未完成"
                            } else {
                                return "已完成";
                            }
                        }
                    },
                    {field:'generallevel',title:'总分',width:60, sortable: true}
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

            //设置理论课预览窗口
            $("#viewNorDialog").dialog({
                title: "查看理论课评价",
                width: 860,
                height: 660,
                iconCls: "icon-search",
                modal: true,
                resizable:true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                onBeforeOpen: function () {
                    var selectRows = $("#dataList").datagrid("getSelected");
                    $.ajax({
                        type: "post",
                        url: "ViewController?method=GetComment",
                        data: {ntid:selectRows.ntid, classtype:selectRows.classtype},
                        dataType: "json",
                        success: function(result){
                            $('#viewNorForm').form('load', result);
                        }
                    });
                }
            });

            //设置实验课预览窗口
            $("#viewLabDialog").dialog({
                title: "查看实验课评价",
                width: 860,
                height: 660,
                iconCls: "icon-search",
                modal: true,
                resizable:true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                onBeforeOpen: function () {
                    var selectRows = $("#dataList").datagrid("getSelected");
                    $.ajax({
                        type: "post",
                        url: "ViewController?method=GetComment",
                        data: {ntid:selectRows.ntid, classtype:selectRows.classtype},
                        dataType: "json",
                        success: function(result){
                            $('#viewLabForm').form('load', result);
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
    <c:if test="${user.type eq 3}">
        <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
        <div style="float: left;" class="datagrid-btn-separator"></div>
    </c:if>
    <div style="float: left;"><a id="reload" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div><a id="view" href="javascript:" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查看评价</a></div>
</div>

<!-- 理论课预览窗口 -->
<div id="viewNorDialog" style="padding: 10px">
    <form id="viewNorForm">
        <table id="viewTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" >
            <tr>
                <td width="300">授课教师姓名:</td>
                <td width="250">
                    <input id="view_nor_teachername" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teachername" data-options="editable:false"/>
                </td>
                <td width="300">课程名称:</td>
                <td width="250">
                    <input id="view_nor_coursename" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="coursename" data-options="editable:false"/>
                </td>
            </tr>
            <tr>
                <td width="300">授课班级:</td>
                <td width="250">
                    <input id="view_nor_classname" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="classname" data-options="editable:false"/>
                </td>
                <td width="300">授课时间:</td>
                <td width="250">
                    <input id="view_time" style="width: 100px; height: 30px;"  class="easyui-textbox" type="text" name="time" data-options="editable:false" />
                    <input id="view_nor_lessonno" class="easyui-textbox" style="width: 100px; height: 30px;" type="text" name="lessonno"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">授课主题:</td>
                <td width="250">
                    <input id="view_nor_theme"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="theme" data-options="editable:false"/>
                </td>
                <td width="300">授课地点:</td>
                <td width="250">
                    <input id="view_nor_roomlocation" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="roomlocation" data-options="editable:false"/>
                </td>
            </tr>
            <tr>
                <td width="300">授课评价类别</td>
                <td width="250">评价等级/得分/总分</td>
                <td width="300">授课评价类别</td>
                <td width="250">评价等级/得分/总分</td>
            </tr>
            <tr>
                <td width="300" height="70">1.教学内容和目标明确, 符合教学大纲要求(8分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t1"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t1"  data-options="editable:false" />
                </td>
                <td width="300" height="70">2.教学内容娴熟, 问题阐述收放自如(15分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t2" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t2"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300" height="70">3.讲述条理清晰, 概念准确, 重点突出(10分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t3" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t3"  data-options="editable:false" />
                </td>
                <td width="300" height="70">4.使用普通话, 语言表达清楚、简洁、准确、语速适中(8分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t4" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t4"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300" height="70">5.PPT制作精良, 板书规范, 能有效利用各种教学媒体(8分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t5" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t5"  data-options="editable:false" />
                </td>
                <td width="300" height="70">6.有先进的教学理念、实用的教学方法, 教学设计精心、课堂效果好(10分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t6"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t6"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300" height="70">7.能启发引导学生积极、主动思考(10分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t7"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t7"  data-options="editable:false" />
                </td>
                <td width="300" height="70">8.与学生交流互动好, 课堂氛围活跃(10分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t8" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t8"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300" height="70">9.学生注意力集中, 课堂纪律好(10分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t9"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t9"  data-options="editable:false" />
                </td>
                <td width="300" height="70">10.通过本节课的教学内容, 学生能掌握本节课的教学内容, 感觉受启发, 收获大(15分)</td>
                <td width="250" height="70">
                    <input id="view_nor_t10" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="t10"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">课堂氛围:</td>
                <td width="250">
                    <input id="view_nor_classatomspere"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="classatomspere"  data-options="editable:false" />
                </td>
                <td width="300">教师情况:</td>
                <td width="250">
                    <input id="view_nor_teachercondition"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teachercondition"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">学生情况:</td>
                <td width="250">
                    <input id="view_nor_studentscondition"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="studentscondition"  data-options="editable:false" />
                </td>
                <td width="300">玩手机情况:</td>
                <td width="250">
                    <input id="view_nor_playphone"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="playphone"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">教材情况:</td>
                <td width="250">
                    <input id="view_nor_bookcondition"  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="bookcondition"  data-options="editable:false" />
                </td>
                <td width="300">抬头率:</td>
                <td width="250">
                    <input id="view_nor_lookupcondition" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="lookupcondition"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">就座情况:</td>
                <td width="250">
                    <input id="view_nor_sitecondition" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="sitecondition"  data-options="editable:false" />
                </td>
                <td width="300">授课形式:</td>
                <td width="250">
                    <input id="view_nor_teachingshape" class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teachingshape"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">总体评价:</td>
                <td width="250">
                    <input id="add_nor_generalcomment"  class="easyui-textbox" style="width: 200px; height: 100px;" type="text" data-options="multiline: true,editable:false" name="generalcomment" />
                </td>
                <td width="300">存在问题/需要改进的地方及具体改进建议/启发:</td>
                <td width="250">
                    <input id="add_nor_other" class="easyui-textbox" style="width: 200px; height: 100px;" type="text" data-options="multiline: true,editable:false" name="other" />
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 实验课预览窗口 -->
<div id="viewLabDialog" style="padding: 10px">
    <form id="viewLabForm" method="post">
        <table class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" >
            <tr>
                <td width="300">授课教师姓名:</td>
                <td width="250">
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="teachername" data-options="editable:false"/>
                </td>
                <td width="300">授课班级:</td>
                <td width="250">
                    <input   class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="classname" data-options="editable:false"/>
                </td>
            </tr>
            <tr>
                <td width="300">课程名称:</td>
                <td width="250">
                    <input  class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="coursename" data-options="editable:false"/>
                </td>
                <td width="300">授课时间:</td>
                <td width="250">
                    <input style="width: 100px; height: 30px;" class="easyui-textbox" type="text" name="time" data-options="editable:false" />
                    <input class="easyui-textbox" style="width: 100px; height: 30px;" type="text" name="lessonno"  data-options="editable:false" />
                </td>
            </tr>
            <tr>
                <td width="300">实验课题:</td>
                <td width="250">
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="theme" data-options="editable:false"/>
                </td>
                <td width="300">授课地点:</td>
                <td width="250">
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" name="roomlocation" data-options="editable:false"/>
                </td>
            </tr>
            <tr>
                <td width="300">具体指标及评价内容</td>
                <td width="250">评价得分/总分</td>
                <td width="300">具体指标及评价内容</td>
                <td width="250">评价得分/总分</td>
            </tr>
            <tr>
                <td width="300" >1.备课充分, 有完整的实验教案或讲义, 熟悉实验内容, 实验目的明确, 内容充实, 符合教学大纲要求(15分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t1" />
                </td>
                <td width="300" >2.分组及人数符合实验要求, 指导教师讲授具有启发性, 熟悉仪器设备, 操作示范正确, 熟练(15分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t2" />
                </td>
            </tr>
            <tr>
                <td width="300" >3.普通话熟练, 口头语言表达清楚准确, 富有感染力和吸引力, 采用板书或其他教学手段（如多媒体、直观教学）演示和介绍实验内容效果良好(10分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t3" />
                </td>
                <td width="300" >4.实验各环节时间把握恰当, 注重引导学生思考和学生实际动手能力的培养, 注重探索与改进实验教学方法, 重视课堂内外师生双向交流(10分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t4" />
                </td>
            </tr>
            <tr>
                <td width="300" >5.遵守教学与课堂纪律, 上课通信工具关闭, 不迟到早退, 准时上下课(10分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t5" />
                </td>
                <td width="300" >6.为人师表, 注重教态仪表和言行身教, 教书的同时注重育人, 引导学生积极向上, 不对学生宣讲负面和具有消极影响的言论(10分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t6" />
                </td>
            </tr>
            <tr>
                <td width="300" >7.对学生要求严格, 善于管理学生上课出勤和课堂纪律, 对原始实验数据审查严格, 对实验报告批阅认真规范(10分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t7" />
                </td>
                <td width="300" >8.学生实验兴趣浓, 思维活跃, 注意力集中, 实验秩序纪律好, 通过本节实验课的教学, 学生能掌握本节课的教学内容, 感觉受启发, 收获大(20分)</td>
                <td width="250" >
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="t8" />
                </td>
            </tr>

            <tr>
                <td width="300">综合评语:</td>
                <td width="250">
                    <input class="easyui-textbox" style="width: 200px; height: 100px;" type="text" data-options="multiline: true,editable:false" name="generalcomment" />
                </td>
                <td width="300">实验室管理:按时开门, 环境整洁, 实验仪器设备维护完好, 台套数满足教学要求; 实验室管理规范, 室内醒目位置有文字式的管理制度与操作规范</td>
                <td width="250">
                    <input class="easyui-textbox" style="width: 200px; height: 30px;" type="text" data-options="editable:false" name="labmgrlevel" />
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>