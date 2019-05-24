<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>实验课听课评价</title>

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
				title: "实验课听课评价",
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
						handler:function() {
							var validate = $("#commentForm").form("validate");
							if(!validate) {
								$.messager.alert("","请检查你输入的数据!","warning");
							} else {
								//提交任务
								$.ajax({
									type: "post",
									url: "LabClassCommentController?method=CommitComment",
									data: $("#commentForm").serialize(),
									success: function (msg) {
										if (msg == "success") {
											$.messager.alert("", "评价成功!", "info");
											//清空原表格数据
                                            $("#add_id").textbox('setValue', "");
                                            $("#add_taskexecuter").textbox('setValue', "");
                                            $("#add_teachername").textbox('setValue', "");
                                            $("#add_classname").textbox('setValue', "");
                                            $("#add_coursename").textbox('setValue', "");
                                            $("#add_time").textbox('setValue', "");
                                            $("#add_lessonno").textbox('setValue', "");
                                            $("#add_theme").textbox('setValue', "");
                                            $("#add_roomlocation").textbox('setValue', "");
                                            $("#add_generalcomment").textbox('setValue', "");
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
						handler:function() {
							//清空表单
                            $("#add_teachername").textbox('setValue', "");
                            $("#add_classname").textbox('setValue', "");
                            $("#add_coursename").textbox('setValue', "");
                            $("#add_time").textbox('setValue', "");
                            $("#add_lessonno").textbox('setValue', "");
                            $("#add_theme").textbox('setValue', "");
                            $("#add_roomlocation").textbox('setValue', "");
                            $("#add_generalcomment").textbox('setValue', "");
						}
					},
					{
						text:'返回任务列表',
						plain: true,
						iconCls:'icon-back',
						handler:function() {
							//清空表单
							$("#add_id").textbox('setValue', "");
							$("#add_taskexecuter").textbox('setValue', "");
							$("#add_teachername").textbox('setValue', "");
							$("#add_classname").textbox('setValue', "");
							$("#add_coursename").textbox('setValue', "");
							$("#add_time").textbox('setValue', "");
							$("#add_lessonno").textbox('setValue', "");
							$("#add_theme").textbox('setValue', "");
							$("#add_roomlocation").textbox('setValue', "");
							$("#add_generalcomment").textbox('setValue', "");
							//返回任务列表
							window.location.href = "SystemController?method=toTasksView";
						}
					}
				]
			});

			$("#t1").slider({
				min: 0,
				max: 15,
				tipFormatter: function(value){
					if(value <= 6){
						return '差';
					} else if(value >= 7 && value <= 9){
						return '中下';
					} else if(value >= 10 && value <= 11){
						return '一般';
					} else if(value >= 12 && value <= 13){
						return '较好';
					} else if(value >= 14){
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
					} else if(value >= 7 && value <= 9){
						return '中下';
					} else if(value >= 10 && value <= 11){
						return '一般';
					} else if(value >= 12 && value <= 13){
						return '较好';
					} else if(value >= 14){
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
					} else if(value == 5 || value == 6){
						return '中下';
					} else if(value == 7){
						return '一般';
					} else if(value == 8){
						return '较好';
					} else if(value >= 9){
						return '很好';
					}
				}
			});

			$("#t4").slider({
				min: 0,
				max: 10,
				tipFormatter: function(value){
					if(value <= 4){
						return '差';
					} else if(value == 5 || value == 6){
						return '中下';
					} else if(value == 7){
						return '一般';
					} else if(value == 8){
						return '较好';
					} else if(value >= 9){
						return '很好';
					}
				}
			});

			$("#t5").slider({
				min: 0,
				max: 10,
				tipFormatter: function(value){
					if(value <= 4){
						return '差';
					} else if(value == 5 || value == 6){
						return '中下';
					} else if(value == 7){
						return '一般';
					} else if(value == 8){
						return '较好';
					} else if(value >= 9){
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
					} else if(value == 5 || value == 6){
						return '中下';
					} else if(value == 7){
						return '一般';
					} else if(value == 8){
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
					} else if(value == 5 || value == 6){
						return '中下';
					} else if(value == 7){
						return '一般';
					} else if(value == 8){
						return '较好';
					} else if(value >= 9){
						return '很好';
					}
				}
			});

			$("#t8").slider({
				min: 0,
				max: 20,
				tipFormatter: function(value){
					if(value <= 8){
						return '差';
					} else if(value >= 9 && value <= 12){
						return '中下';
					} else if(value >= 13 && value <= 14){
						return '一般';
					} else if(value >= 15 && value <= 16){
						return '较好';
					} else if(value >= 17){
						return '很好';
					}
				}
			});

		});
	</script>
</head>
<body>
<div id="planDialog" style="padding: 20px;width: auto;">
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
				<td width="200">授课班级:</td>
				<td width="350">
					<input id="add_classname"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="classname" data-options="required:true, missingMessage:'请输入授课班级'"/>
				</td>
			</tr>
			<tr>
				<td width="200">课程名称:</td>
				<td width="350">
					<input id="add_coursename" value="${task.coursename}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="coursename" data-options="required:true, missingMessage:'请输入课程名称'"/>
				</td>
				<td width="200">授课时间:</td>
				<td width="350">
					<input id="add_time" value="${task.etime}" style="width: 150px; height: 30px;" class="easyui-datebox" type="text" name="etime" data-options="required:true, missingMessage:'请选择授课日期', editable:false" />
					<input id="add_lessonno" value="${task.lessonno}" class="easyui-textbox" style="width: 150px; height: 30px;" type="text" name="lessonno"  data-options="required:true, missingMessage:'请输入授课节次,示例：1-2'" />
					节
				</td>
			</tr>
			<tr>
				<td width="200">实验课题:</td>
				<td width="350">
					<input id="add_theme"  class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="theme" data-options="required:true, missingMessage:'请输入实验课题'"/>
				</td>
				<td width="200">授课地点:</td>
				<td width="350">
					<input id="add_roomlocation" value="${task.roomlocation}" class="easyui-textbox" style="width: 300px; height: 30px;" type="text" name="roomlocation" data-options="required:true, missingMessage:'请输入授课地点,示例：H1208'"/>
				</td>
			</tr>
			<tr>
				<td width="200">具体指标及评价内容</td>
				<td width="350">评价得分/总分</td>
				<td width="200">具体指标及评价内容</td>
				<td width="350">评价得分/总分</td>
			</tr>
			<tr>
				<td width="200" height="70">1.备课充分，有完整的实验教案或讲义，熟悉实验内容，实验目的明确，内容充实，符合教学大纲要求</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t1" name="t1" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',3,'|',6,'|',9,'|',12,'|',15]">
				</td>
				<td width="200" height="70">2.分组及人数符合实验要求，指导教师讲授具有启发性，熟悉仪器设备，操作示范正确，熟练</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t2" name="t2" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',3,'|',6,'|',9,'|',12,'|',15]">
				</td>
			</tr>
			<tr>
				<td width="200" height="70">3.普通话熟练，口头语言表达清楚准确，富有感染力和吸引力，采用板书或其他教学手段（如多媒体、直观教学）演示和介绍实验内容效果良好</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t3" name="t3" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
				</td>
				<td width="200" height="70">4.实验各环节时间把握恰当，注重引导学生思考和学生实际动手能力的培养，注重探索与改进实验教学方法，重视课堂内外师生双向交流</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t4" name="t4" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
				</td>
			</tr>
			<tr>
				<td width="200" height="70">5.遵守教学与课堂纪律，上课通信工具关闭，不迟到早退，准时上下课</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t5" name="t5" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
				</td>
				<td width="200" height="70">6.为人师表，注重教态仪表和言行身教，教书的同时注重育人，引导学生积极向上，不对学生宣讲负面和具有消极影响的言论</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t6" name="t6" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
				</td>
			</tr>
			<tr>
				<td width="200" height="70">7.对学生要求严格，善于管理学生上课出勤和课堂纪律，对原始实验数据审查严格，对实验报告批阅认真规范</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t7" name="t7" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',2,'|',4,'|',6,'|',8,'|',10]">
				</td>
				<td width="200" height="70">8.学生实验兴趣浓，思维活跃，注意力集中，实验秩序纪律好，通过本节实验课的教学，学生能掌握本节课的教学内容，感觉受启发，收获大</td>
				<td width="350" height="70">
					<input class="easyui-slider" id="t8" name="t8" value="0" style="width:300px;" data-options="showTip:true,rule:[0,'|',5,'|',10,'|',15,'|',20]">
				</td>
			</tr>

			<tr>
				<td width="200">综合评语:</td>
				<td width="350">
					<input id="add_generalcomment"  class="easyui-textbox" style="width: 300px; height: 100px;" type="text" data-options="multiline: true" name="generalcomment" />
				</td>
				<td width="200">实验室管理:按时开门，环境整洁，实验仪器设备维护完好，台套数满足教学要求；实验室管理规范，室内醒目位置有文字式的管理制度与操作规范</td>
				<td width="350">
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="labmgrlevel" value="4">优</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="labmgrlevel" value="3">良</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="labmgrlevel" value="2">一般</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="labmgrlevel" value="1">中下</label>
                    </div>
                    <div style="margin-bottom:10px">
                        <label><input type="radio" name="labmgrlevel" value="0">差</label>
                    </div>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>