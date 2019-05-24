<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>理论课听课评价</title>

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
				title: "理论课听课评价",
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
						text:'提交评价',
						plain: true,
						iconCls:'icon-ok',
						handler:function()
						{
							var validate = $("#commentForm").form("validate");
                            if(!validate)
							{
								$.messager.alert("","请检查你输入的数据!","warning");
							} else {
                                //提交任务
                                $.ajax({
                                    type: "post",
                                    url: "NormalClassCommentController?method=CommitComment",
                                    data: $("#commentForm").serialize(),
                                    success: function (msg) {
                                        if (msg == "success") {
                                            $.messager.alert("", "评价成功!", "info");
                                            //清空原表格数据
                                            $("#add_id").textbox('setValue', "");
                                            $("#add_taskexecuter").textbox('setValue', "");
                                            $("#add_teachername").textbox('setValue', "");
                                            $("#add_coursename").textbox('setValue', "");
                                            $("#add_classname").textbox('setValue', "");
                                            $("#add_time").textbox('setValue', "");
                                            $("#add_lessonno").textbox('setValue', "");
                                            $("#add_theme").textbox('setValue', "");
                                            $("#add_roomlocation").textbox('setValue', "");
                                            $("#add_generalcomment").textbox('setValue', "");
                                            $("#add_other").textbox('setValue', "");
                                            //返回任务列表
                                            window.location.href = "SystemController?method=toTasksView";
                                        } else {
                                            $.messager.alert("", "评价失败!", "warning");
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
						handler:function()
                        {
                            //清空原表格数据
                            $("#add_teachername").textbox('setValue', "");
                            $("#add_coursename").textbox('setValue', "");
                            $("#add_classname").textbox('setValue', "");
                            $("#add_time").textbox('setValue', "");
                            $("#add_lessonno").textbox('setValue', "");
                            $("#add_theme").textbox('setValue', "");
                            $("#add_roomlocation").textbox('setValue', "");
                            $("#add_generalcomment").textbox('setValue', "");
                            $("#add_other").textbox('setValue', "");
						}
					},
                    {
                        text:'返回任务列表',
                        plain: true,
                        iconCls:'icon-back',
                        handler:function(){
                            //清空原表格数据
                            $("#add_id").textbox('setValue', "");
                            $("#add_taskexecuter").textbox('setValue', "");
                            $("#add_teachername").textbox('setValue', "");
                            $("#add_coursename").textbox('setValue', "");
                            $("#add_classname").textbox('setValue', "");
                            $("#add_time").textbox('setValue', "");
                            $("#add_lessonno").textbox('setValue', "");
                            $("#add_theme").textbox('setValue', "");
                            $("#add_roomlocation").textbox('setValue', "");
                            $("#add_generalcomment").textbox('setValue', "");
                            $("#add_other").textbox('setValue', "");
                            //返回任务列表
                            window.location.href = "SystemController?method=toTasksView";
                        }
                    }
				]
			});

			$("#t1").slider({
                min: 0,
                max: 8,
                tipFormatter: function(value){
                    if(value <= 3){
                        return '差';
                    } else if(value == 4){
                        return '中下';
                    } else if(value == 5){
                        return '一般';
                    } else if(value == 6){
                        return '较好';
                    } else if(value >= 7){
                        return '很好';
                    }
                }
            });

            $("#t2").slider({
                min: 0,
                max: 15,
                tipFormatter: function(value){
                    if(value <= 6){
                        return '差';
                    } else if(value == 7 || value == 8){
                        return '中下';
                    } else if(value == 9 || value == 10){
                        return '一般';
                    } else if(value == 11 || value == 12){
                        return '较好';
                    } else if(value >= 13){
                        return '很好';
                    }
                }
            });

            $("#t3").slider({
                min: 0,
                max: 10,
                tipFormatter: function(value){
                    if(value <= 4){
                        return '差';
                    } else if(value == 5){
                        return '中下';
                    } else if(value == 6){
                        return '一般';
                    } else if(value == 7 || value == 8){
                        return '较好';
                    } else if(value >= 9){
                        return '很好';
                    }
                }
            });

            $("#t4").slider({
                min: 0,
                max: 8,
                tipFormatter: function(value){
                    if(value <= 3){
                        return '差';
                    } else if(value == 4){
                        return '中下';
                    } else if(value == 5){
                        return '一般';
                    } else if(value == 6){
                        return '较好';
                    } else if(value >= 7){
                        return '很好';
                    }
                }
            });

            $("#t5").slider({
                min: 0,
                max: 8,
                tipFormatter: function(value){
                    if(value <= 3){
                        return '差';
                    } else if(value == 4){
                        return '中下';
                    } else if(value == 5){
                        return '一般';
                    } else if(value == 6){
                        return '较好';
                    } else if(value >= 7){
                        return '很好';
                    }
                }
            });

            $("#t6").slider({
                min: 0,
                max: 10,
                tipFormatter: function(value){
                    if(value <= 4){
                        return '差';
                    } else if(value == 5){
                        return '中下';
                    } else if(value == 6){
                        return '一般';
                    } else if(value == 7 || value == 8){
                        return '较好';
                    } else if(value >= 9){
                        return '很好';
                    }
                }
            });

            $("#t7").slider({
                min: 0,
                max: 10,
                tipFormatter: function(value){
                    if(value <= 4){
                        return '差';
                    } else if(value == 5){
                        return '中下';
                    } else if(value == 6){
                        return '一般';
                    } else if(value == 7 || value == 8){
                        return '较好';
                    } else if(value >= 9){
                        return '很好';
                    }
                }
            });

            $("#t8").slider({
                min: 0,
                max: 8,
                tipFormatter: function(value){
                    if(value <= 3){
                        return '差';
                    } else if(value == 4){
                        return '中下';
                    } else if(value == 5){
                        return '一般';
                    } else if(value == 6){
                        return '较好';
                    } else if(value >= 7){
                        return '很好';
                    }
                }
            });

            $("#t9").slider({
                min: 0,
                max: 8,
                tipFormatter: function(value){
                    if(value <= 3){
                        return '差';
                    } else if(value == 4){
                        return '中下';
                    } else if(value == 5){
                        return '一般';
                    } else if(value == 6){
                        return '较好';
                    } else if(value >= 7){
                        return '很好';
                    }
                }
            });

            $("#t10").slider({
                min: 0,
                max: 15,
                tipFormatter: function(value){
                    if(value <= 6){
                        return '差';
                    } else if(value == 7 || value == 8){
                        return '中下';
                    } else if(value == 9 || value == 10){
                        return '一般';
                    } else if(value == 11 || value == 12){
                        return '较好';
                    } else if(value >= 13){
                        return '很好';
                    }
                }
            });
		});
	</script>
</head>
<body>
<div id="planDialog" style="padding: 20px;width: auto;text-align:center;">
	<form id="commentForm" method="post">
		<table id="addTable" class="table table-border table-bordered table-striped" style="width: auto" cellpadding="8" align="center">
            <tr>
                <td width="200">任务ID:</td>
                <td width="350">
                    <input id="add_id" value="${task.id}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="id" data-options="editable:false"/>
                </td>
                <td width="200">任务执行人:</td>
                <td width="350">
                    <input id="add_taskexecuter" value="${task.taskexecuter}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="taskexecuter" data-options="editable:false"/>
                </td>
            </tr>
			<tr>
                <td width="200">授课教师姓名:</td>
                <td width="350">
                    <input id="add_teachername" value="${task.teachername}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="teachername" data-options="required:true, missingMessage:'请输入教师名称'"/>
                </td>
                <td width="200">课程名称:</td>
                <td width="350">
                    <input id="add_coursename" value="${task.coursename}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="coursename" data-options="required:true, missingMessage:'请输入课程名称'"/>
                </td>
			</tr>
			<tr>
                <td width="200">授课班级:</td>
                <td width="350">
                    <input id="add_classname" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="classname" data-options="required:true, missingMessage:'请输入授课班级'"/>
                </td>
				<td width="200">授课时间:</td>
				<td width="350">
					<input id="add_time" style="width: 150px; height: 30px;" value="${task.etime}" class="easyui-datebox" type="text" name="etime" data-options="required:true, missingMessage:'请选择授课日期', editable:false" />
                    <input id="add_lessonno"  class="easyui-textbox" value="${task.lessonno}" style="width: 150px; height: 30px;" type="text" name="lessonno"  data-options="required:true, missingMessage:'请输入授课节次,示例：1-2'" />
                    节
                </td>
			</tr>
            <tr>
                <td width="200">授课主题:</td>
                <td width="350">
                    <input id="add_theme"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="theme" data-options="required:true, missingMessage:'请输入授课主题'"/>
                </td>
                <td width="200">授课地点:</td>
                <td width="350">
                    <input id="add_roomlocation" value="${task.roomlocation}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入授课地点,示例：H1208'"/>
                </td>
            </tr>
            <tr>
                <td width="200">授课评价类别</td>
                <td width="350">评价等级/得分/总分</td>
                <td width="200">授课评价类别</td>
                <td width="350">评价等级/得分/总分</td>
            </tr>
			<tr>
				<td width="200" height="70">1.教学内容和目标明确，符合教学大纲要求</td>
				<td width="350" height="70">
                    <input class="easyui-slider" id="t1" name="t1" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8]">
				</td>
                <td width="200" height="70">2.教学内容娴熟，问题阐述收放自如</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t2" name="t2" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',3,'|',6,'|',9,'|',12,'|',15]">
                </td>
			</tr>
            <tr>
                <td width="200" height="70">3.讲述条理清晰，概念准确，重点突出</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t3" name="t3" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
                </td>
                <td width="200" height="70">4.使用普通话，语言表达清楚、简洁、准确、语速适中</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t4" name="t4" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8]">
                </td>
            </tr>
            <tr>
                <td width="200" height="70">5.PPT制作精良，板书规范，能有效利用各种教学媒体</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t5" name="t5" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8]">
                </td>
                <td width="200" height="70">6.有先进的教学理念、实用的教学方法，教学设计精心、课堂效果好</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t6" name="t6" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
                </td>
            </tr>
            <tr>
                <td width="200">听课评价类别</td>
                <td width="350">评价等级/得分/总分</td>
                <td width="200">听课评价类别</td>
                <td width="350">评价等级/得分/总分</td>
            </tr>
            <tr>
                <td width="200" height="70">7.能启发引导学生积极、主动思考</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t7" name="t7" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
                </td>
                <td width="200" height="70">8.与学生交流互动好，课堂氛围活跃</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t8" name="t8" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8]">
                </td>
            </tr>
            <tr>
                <td width="200" height="70">9.学生注意力集中，课堂纪律好</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t9" name="t9" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8]">
                </td>
                <td width="200" height="70">10.通过本节课的教学内容，学生能掌握本节课的教学内容，感觉受启发，收获大</td>
                <td width="350" height="70">
                    <input class="easyui-slider" id="t10" name="t10" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',3,'|',6,'|',9,'|',12,'|',15]">
                </td>
            </tr>
            <tr>
                <td width="200">课堂氛围:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="classatomspere" value="3">活跃</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="classatomspere" value="2">沉闷</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="classatomspere" value="1">轻松</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="classatomspere" value="0">安静</label>
                    </div>
                </td>
                <td width="200">教师情况:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="teachercondition" value="2">提前5分钟以上进教室准备</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="teachercondition" value="1">早退</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="teachercondition" value="0">迟到</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td width="200">学生情况:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="studentscondition" value="2">大多数认真听讲</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="studentscondition" value="1">一半认真听讲</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="studentscondition" value="0">只有少数人听</label>
                    </div>
                </td>
                <td width="200">学生玩手机情况:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="playphone" value="2">少数玩手机</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="playphone" value="1">部分玩手机</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="playphone" value="0">较多玩手机</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td width="200">教材情况:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="bookcondition" value="3">学生手上无资料教材</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="bookcondition" value="2">学生手上有分发资料</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="bookcondition" value="1">学生手上有自编讲义</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="bookcondition" value="0">学生手上有正式教材</label>
                    </div>
                </td>
                <td width="200">抬头率:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="lookupcondition" value="2">只有少学生抬头看老师</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="lookupcondition" value="1">半数左右学生抬头看老师</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="lookupcondition" value="0">大多数学生抬头看老师</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td width="200">就座情况:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="sitecondition" value="2">学生主要选择教室中后部分就座</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="sitecondition" value="1">前三排座位空余较多</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="sitecondition" value="0">前3排基本坐满</label>
                    </div>
                </td>
                <td width="200">授课形式:</td>
                <td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="teachingshape" value="2">完全单向教师讲、学生听</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="teachingshape" value="1">有讨论、提问交流等互动</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="teachingshape" value="0">有探究法或其他新教学模式应用</label>
                    </div>
                </td>
            </tr>
			<tr>
				<td width="200">总体评价:</td>
				<td width="350">
					<input id="add_generalcomment" class="easyui-textbox" style="width: 300px; height: 100px;" type="text" data-options="multiline: true" name="generalcomment" />
				</td>
                <td width="200">存在问题/需要改进的地方及具体改进建议/对你的启发(不少于100字,一栏至少描述其中一项):</td>
                <td width="350">
                    <input id="add_other"  class="easyui-textbox" style="width: 300px; height: 100px;" type="text" data-options="multiline: true" name="other" />
                </td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>