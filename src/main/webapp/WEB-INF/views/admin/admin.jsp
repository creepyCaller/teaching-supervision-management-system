<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>管理|教学督导听课评价管理系统</title>
    <!--
    <link rel="shortcut icon" href="favicon.ico"/>
	<link rel="bookmark" href="favicon.ico"/>
     -->
    <link rel="stylesheet" type="text/css" href="easyui/css/default.css" />
    <link rel="stylesheet" type="text/css" href="easyui/themes/material-teal/easyui.css" />
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src='easyui/js/outlook2.js'> </script>
    <script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function(){
            //登出
            $("#logoutBtn").click(function(){
                window.location.href = "SystemController?method=LoginOut";
            });
        });
	 var _menus = {"menus":[
						{"menuid":"1","icon":"","menuname":"任务管理",
							"menus":[
									{"menuid":"11","menuname":"听课任务","icon":"icon-number","url":"SystemController?method=toTasksView"},
                                    {"menuid":"12","menuname":"安排听课","icon":"icon-pencil-add","url":"SystemController?method=toPlanTaskView"},
                                    {"menuid":"13","menuname":"已完成任务","icon":"icon-chart_bar","url":"DispatcherController?method=toFinishedTskView"}
								]
						},
                         {"menuid":"2","icon":"","menuname":"评价信息",
                             "menus":[
                                 {"menuid":"21","menuname":"理论课评价","icon":"icon-note","url":"SystemController?method=toNormalCourseView"},
                                 {"menuid":"22","menuname":"实验课评价","icon":"icon-sum","url":"SystemController?method=toLabCourseView"}
                             ]
                         },
                         {"menuid":"3","icon":"","menuname":"信息管理",
                             "menus":[
                                 {"menuid":"31","menuname":"课程管理","icon":"icon-exam","url":"SystemController?method=toCourseMgrView"},
                                 {"menuid":"32","menuname":"班级管理","icon":"icon-book-open","url":"SystemController?method=toClassMgrView"},
                                 {"menuid":"33","menuname":"教室管理","icon":"icon-house","url":"SystemController?method=toRoomMgrView"},
                                 {"menuid":"34","menuname":"教师管理","icon":"icon-user-student","url":"SystemController?method=toTeacherMgrView"},
                                 {"menuid":"35","menuname":"督导员管理","icon":"icon-user-teacher","url":"SystemController?method=toTSMemberMgrView"}
                             ]
                         },
						{"menuid":"4","icon":"","menuname":"系统管理",
							"menus":[
                                    {"menuid":"41","menuname":"个人信息","icon":"icon-man","url":"SystemController?method=toAdminPersonalView"},
							        {"menuid":"42","menuname":"系统设置","icon":"icon-set","url":"SystemController?method=toAdminSystemView"},
                                    {"menuid":"43","menuname":"用户管理","icon":"icon-vcard-edit","url":"DispatcherController?method=toUserMgrView"},
                                    {"menuid":"44","menuname":"添加管理员","icon":"icon-user_add","url":"DispatcherController?method=toAddAdminView"}
								]
						},
                         {"menuid":"5","icon":"","menuname":"帮助",
                             "menus":[
                                 {"menuid":"51","menuname":"帮助","icon":"icon-help","url":"SystemController?method=toHelpView"},
                                 {"menuid":"52","menuname":"关于","icon":"icon-tip","url":"SystemController?method=toAboutView"}
                             ]
                         }
				]};
    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
<noscript>
    <div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
        <img src="/images/noscript.gif" alt='抱歉，请开启脚本支持！' />
    </div>
</noscript>

<div region="north" split="false" border="false" style="overflow: hidden; height: 60px; background: #222; padding: 0; line-height: 20px; color: whitesmoke;">
    <h3 style="color: whitesmoke; width: 400px; height: 60px; line-height: 60px; margin: 0 0 0 30px; font-size: 24px; font-weight:normal">管理|教学督导听课评价管理系统</h3>
</div>
<div region="west" split="false" title="系统菜单" style="overflow: hidden; width:120px;" id="west">
    <div id="nav" class="easyui-accordion" fit=false border="false" data-options="multiple:false">
        <!--  导航内容 -->
    </div>

</div>
<div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
    <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
        <jsp:include page="/WEB-INF/views/admin/welcome.jsp" />
    </div>
</div>
</body>
</html>