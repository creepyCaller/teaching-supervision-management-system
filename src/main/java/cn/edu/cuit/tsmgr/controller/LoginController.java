package cn.edu.cuit.tsmgr.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.service.SystemServiceInter;
import cn.edu.cuit.tsmgr.service.impl.SystemService;
import cn.edu.cuit.tsmgr.util.EncryptionUtil;
import cn.edu.cuit.tsmgr.util.VCodeGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
@WebServlet("/LoginController")
public class LoginController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;
    @Autowired
    private SystemServiceInter service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new SystemService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("GetVCode".equalsIgnoreCase(method)){
            getVCode(request, response);
        } else if("toRegisterView".equalsIgnoreCase(method)) { //到注册界面
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } else if("toLogin".equalsIgnoreCase(method)) {  //到登录界面
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("Login".equalsIgnoreCase(method)){ //验证登录
            login(request, response);
        }
    }


    /**
     * 验证用户登录
     * @param request
     * @param response
     * @throws IOException
     */
    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取用户输入的账户
        String username = request.getParameter("username");
        //获取用户输入的密码
        String password = request.getParameter("password");
        //获取用户输入的验证码
        String vcode = request.getParameter("vcode");
        //获取登录类型
        int type = Integer.parseInt(request.getParameter("type"));

        //返回信息
        String msg = "";

        //获取session中的验证码
        String sVcode = (String) request.getSession().getAttribute("vcode");
        if(username.isEmpty())
        {
            msg = "emptyUserName";
        }
        else if(password.isEmpty())
        {
            msg = "emptyPWD";
    }
        else if(!sVcode.equalsIgnoreCase(vcode))
        {//判断验证码是否正确
            msg = "vcodeError";
        }
        else
        {	//判断用户名和密码是否正确
            //将账户和密码封装
            Users loginUser = new Users();
            loginUser.setUsername(username);
            //将获取的密码进行MD5加密
            loginUser.setPassword(EncryptionUtil.MD5(password));
            loginUser.setType(type);
            //创建系统数据层对象
            //查询用户是否存在
            Users user = service.checkUser(loginUser);
            if(user == null)
            {//如果用户名错误
                msg = "loginError";
            }
            else if(!loginUser.getPassword().equals(user.getPassword()))
            {//密码错误
                msg = "pwdError";
            }
            else
            {
                if(Users.USER_ADMIN == type){
                    msg = "admin";
                } else if(Users.USER_TSMEMBER == type){
                    msg = "tsmember";
                } else if(Users.USER_TEACHER == type){
                    msg = "teacher";
                }
                //将该用户名保存到session中
                request.getSession().setAttribute("user", user);
            }
        }
        //返回登录信息
        response.getWriter().write(msg);
    }

    /**
     * 获取验证码
     * @param request
     * @param response
     * @throws IOException
     */
    private void getVCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //创建验证码生成器对象
        VCodeGenerator vcGenerator = new VCodeGenerator();
        //生成验证码
        String vcode = vcGenerator.generatorVCode();
        //将验证码保存在session域中,以便判断验证码是否正确
        request.getSession().setAttribute("vcode", vcode);
        //生成验证码图片
        BufferedImage vImg = vcGenerator.generatorRotateVCodeImage(vcode, true);
        //输出图像
        ImageIO.write(vImg, "gif", response.getOutputStream());
    }

}
