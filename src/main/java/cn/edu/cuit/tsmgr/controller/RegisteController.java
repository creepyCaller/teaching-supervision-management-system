package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.service.SystemServiceInter;
import cn.edu.cuit.tsmgr.service.impl.SystemService;
import cn.edu.cuit.tsmgr.util.EncryptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * 注册控制器
 * @author fpc
 *
 */
@Controller
@WebServlet("/RegisteController")
public class RegisteController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;
    @Autowired
    private SystemServiceInter service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new SystemService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("Registe".equalsIgnoreCase(method)) { //注册
            registe(request, response);
        }

    }
    private void registe(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String vcode = request.getParameter("vcode");
        int type = Integer.parseInt(request.getParameter("type"));
        //返回信息
        String msg = "";
        //获取session中的验证码
        String sVcode = (String) request.getSession().getAttribute("vcode");
        if(username.isEmpty()) {
            msg = "emptyUserName";
        } else if(password.isEmpty()) {
            msg = "emptyPWD";
        } else if(!sVcode.equalsIgnoreCase(vcode))
        {//判断验证码是否正确
            msg = "vcodeError";
        }
        else
        {
            //判断用户名是否已经存在
            //将账户和密码封装
            Users registeUser = new Users();
            registeUser.setUsername(username);
            //将密码进行MD5加密
            registeUser.setPassword(EncryptionUtil.MD5(password));
            registeUser.setType(type);
            registeUser.setRegistedate(new java.sql.Date(new Date().getTime()));
            //创建系统数据层对象
            //查询用户是否存在
            Users user = service.checkUser(registeUser);
            if(user == null) {//如果用户名没有被占用
                if(service.registe(registeUser) == 1) {
                    msg = "success";
                } else {
                    msg = "error";
                }
            } else {//如果被占用
                msg="exist";
            }
        }
        //返回登录信息
        response.getWriter().write(msg);
    }
}