<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>督导员|教学督导听课评价管理系统</title>
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
    <script type="text/javascript" src="h-ui/js/H-ui.js"></script>
    <script type="text/javascript" src="h-ui/lib/icheck/jquery.icheck.min.js"></script>
    <script type="text/javascript" src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function(){
        //登出
        $("#logoutBtn").click(function(){
                window.location.href = "SystemController?method=LoginOut";
         });
        });
	 var _menus = {"menus":[
						{"menuid":"1","menuname":"任务管理",
							"menus":[
									{"menuid":"11","menuname":"听课任务","url":"SystemController?method=toTasksView"},
                                    {"menuid":"12","menuname":"安排听课","url":"SystemController?method=toPlanTaskView"},
                                    {"menuid":"13","menuname":"已完成任务","url":"DispatcherController?method=toFinishedTskView"}
								]
						},
                         {"menuid":"2","menuname":"评价信息",
                             "menus":[
                                 {"menuid":"21","menuname":"理论课评价","url":"SystemController?method=toNormalCourseView"},
                                 {"menuid":"22","menuname":"实验课评价","url":"SystemController?method=toLabCourseView"}
                             ]
                         },
                         {"menuid":"3","menuname":"信息查看",
                             "menus":[
                                 {"menuid":"31","menuname":"查看课程","url":"SystemController?method=toCourseMgrView"},
                                 {"menuid":"32","menuname":"查看班级","url":"SystemController?method=toClassMgrView"},
                                 {"menuid":"33","menuname":"查看教室","url":"SystemController?method=toRoomMgrView"},
                                 {"menuid":"34","menuname":"查看教师","url":"SystemController?method=toTeacherMgrView"},
                                 {"menuid":"35","menuname":"查看督导员","url":"SystemController?method=toTSMemberMgrView"}
                             ]
                         },
						{"menuid":"4","menuname":"个人管理",
							"menus":[
                                    {"menuid":"41","menuname":"个人信息","url":"SystemController?method=toTSMemberPersonalView"}
								]
						},
                         {"menuid":"5","menuname":"帮助",
                             "menus":[
                                 {"menuid":"51","menuname":"帮助","url":"SystemController?method=toHelpView"},
                                 {"menuid":"52","menuname":"关于","url":"SystemController?method=toAboutView"}
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
    <h3 style="color: whitesmoke; width: 400px; height: 60px; line-height: 60px; margin: 0 0 0 30px; font-size: 24px; font-weight:normal">督导员|教学督导听课评价管理系统</h3>
</div>

<div region="west" split="false" border="false" title="" style="overflow: hidden; width:120px;" id="west">
    <div id="nav" class="easyui-accordion" fit=false border="false" data-options="multiple:false">
        <!--  导航内容 -->
    </div>

</div>
<div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
    <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
        <jsp:include page="/WEB-INF/views/tsmember/welcome.jsp" />
    </div>
</div>
</body>
</html>