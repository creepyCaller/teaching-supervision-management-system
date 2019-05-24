<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="bookmark" href="favicon.ico"/>
     -->
<link href="h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="h-ui/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="h-ui/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="easyui/themes/material-teal/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">

<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="h-ui/lib/icheck/jquery.icheck.min.js"></script>

<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>

<script type="text/javascript">
	$(function(){
		//点击图片切换验证码
		$("#vcodeImg").click(function(){
			this.src="LoginController?method=GetVcode&t="+new Date().getTime();
		});
		//提交
		$("#submitBtn").click(function(){

            if(($("#radio-1").prop("checked") && "${systemInfo.forbidtsmember}" == 2) || ($("#radio-1").prop("checked") && "${systemInfo.forbidtsmember}" == 3)) {
                $.messager.alert("", "督导员暂不能注册！", "warning");
                return;
            } else if (($("#radio-2").prop("checked") && "${systemInfo.forbidteacher}" == 2) || ($("#radio-2").prop("checked") && "${systemInfo.forbidteacher}" == 3)) {
                $.messager.alert("", "教师暂不能注册！", "warning");
                return;
            } else {
                var data = $("#form").serialize();
                $.ajax({
                    type: "post",
                    url: "RegisteController?method=Registe",
                    data: data,
                    dataType: "text", //返回数据类型
                    success: function(msg)
                    {
                        if("emptyUserName" == msg){
                            $.messager.alert(" ", "请输入用户名!", "warning");
                            $("#vcodeImg").click();//切换验证码
                            $("input[name='vcode']").val("");//清空验证码输入框
                        }else if("exist" == msg){
                            $.messager.alert(" ", "用户已存在!", "warning");
                            $("#vcodeImg").click();//切换验证码
                            $("input[name='vcode']").val("");//清空验证码输入框
                        } else if("emptyPWD" == msg){
                            $.messager.alert(" ", "请输入密码!", "warning");
                            $("#vcodeImg").click();//切换验证码
                            $("input[name='vcode']").val("");//清空验证码输入框
                        }else if("vcodeError" == msg){
                            $.messager.alert(" ", "验证码错误!", "warning");
                            $("#vcodeImg").click();//切换验证码
                            $("input[name='vcode']").val("");//清空验证码输入框
                        }else if("success" == msg){
                            $.messager.alert("","注册成功，将跳转至登录页","warning")
                            setTimeout(function(){
                                top.location.href = "LoginController?method=toLogin";
                            }, 1000);
                        }else if("error" == msg){
                            $.messager.alert(" ", "未知错误!", "warning");
                            $("#vcodeImg").click();//切换验证码
                            $("input[name='vcode']").val("");//清空验证码输入框
                        }
                    }
                });
            }
		});
		//设置复选框
		$(".skin-minimal input").iCheck({
			radioClass: 'iradio-green',
			increaseArea: '75%'
		});
	})
</script>
<title>注册|教学督导听课评价管理系统</title>
<meta name="keywords" content="教学督导听课评价管理系统">
</head>
<body>

<div class="header" style="background: #222; padding: 0;">
    <h3 style="color: whitesmoke; width: 400px; height: 60px; line-height: 60px; margin: 0 0 0 30px; padding: 0;">注册|教学督导听课评价管理系统</h3>
</div>
<div class="loginWraper">
  <div id="loginform" class="loginBox" style="background: whitesmoke">
    <form id="form" class="form form-horizontal" method="post">
      <div class="row cl">
        <label class="form-label col-3"><i class="Hui-iconfont">&#xe60a;</i></label>
        <div class="formControls col-8">
          <input id="" name="username" type="text" placeholder="用户名" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-3"><i class="Hui-iconfont">&#xe63f;</i></label>
        <div class="formControls col-8">
          <input id="" name="password" type="password" placeholder="密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-8 col-offset-3">
          <input class="input-text size-L" name="vcode" type="text" placeholder="请输入验证码" style="width: 200px;">
          <img title="点击图片切换验证码" id="vcodeImg" src="LoginController?method=GetVCode"></div>
      </div>
      <div class="mt-20 skin-minimal" style="text-align: center;">
          <div class="radio-box">
              <input type="radio" id="radio-1" name="type" value="1" checked />
              <label for="radio-1">督导组</label>
          </div>
          <div class="radio-box">
              <input type="radio" id="radio-2" name="type" value="2" />
              <label for="radio-2">老师</label>
          </div>
      </div>
      <div class="row">
        <div class="formControls col-7 col-offset-5">
          <input id="submitBtn" type="button" class="btn btn-success radius size-L" value="提交">
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>