package cn.edu.cuit.tsmgr.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.edu.cuit.tsmgr.service.SystemServiceInter;
import cn.edu.cuit.tsmgr.service.impl.SystemService;

import cn.edu.cuit.tsmgr.model.Systemimformation;
import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.util.EncryptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import javax.servlet.annotation.WebServlet;


/**
 * 系统类
 * @author fpc
 *
 */
@Controller
@WebServlet("/SystemController")
public class SystemController extends HttpServlet implements BaseControllerInter {
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
        if("LoginOut".equals(method)) { //退出系统
            loginOut(request, response);
        } //以下代码段是处理转发页面
        else if("toAdminView".equalsIgnoreCase(method)) { //到管理员页面
            request.getRequestDispatcher("/WEB-INF/views/admin/admin.jsp").forward(request, response);
        } else if("toTSMemberView".equalsIgnoreCase(method)) { //到督导组页面
            request.getRequestDispatcher("/WEB-INF/views/tsmember/tsmember.jsp").forward(request, response);
        } else if("toTeacherView".equalsIgnoreCase(method)) { //到教师页面
            request.getRequestDispatcher("/WEB-INF/views/teacher/teacher.jsp").forward(request, response);
        } else if("toAdminPersonalView".equalsIgnoreCase(method)) { //到系统管理员个人设置页面
            request.getRequestDispatcher("/WEB-INF/views/admin/adminPersonal.jsp").forward(request, response);
        } else if("toTeacherPersonalView".equalsIgnoreCase(method)) { //到教师个人设置页面
            request.getRequestDispatcher("/WEB-INF/views/teacher/teacherPersonal.jsp").forward(request, response);
        } else if("toTSMemberPersonalView".equalsIgnoreCase(method)) { //到教师个人设置页面
            request.getRequestDispatcher("/WEB-INF/views/tsmember/tsmemberPersonal.jsp").forward(request, response);
        } else if("toAdminSystemView".equalsIgnoreCase(method)) { //到系统设置
            request.getRequestDispatcher("/WEB-INF/views/admin/adminSystem.jsp").forward(request, response);
        } else if("toHelpView".equalsIgnoreCase(method)) { //到帮助页面
            request.getRequestDispatcher("/WEB-INF/views/others/help.jsp").forward(request, response);
        } else if("toAboutView".equalsIgnoreCase(method)) { //到关于页面
            request.getRequestDispatcher("/WEB-INF/views/others/about.jsp").forward(request, response);
        } else if("toTasksView".equalsIgnoreCase(method)) { //到任务信息页面
            request.getRequestDispatcher("/WEB-INF/views/others/tasks.jsp").forward(request, response);
        } else if("toPlanTaskView".equalsIgnoreCase(method)) { //到指定计划页面
            request.getRequestDispatcher("/WEB-INF/views/others/plantask.jsp").forward(request, response);
        } else if("toNormalCourseView".equalsIgnoreCase(method)) { //到普通课程评价页面
            request.getRequestDispatcher("/WEB-INF/views/others/normalcourse.jsp").forward(request, response);
        } else if("toLabCourseView".equalsIgnoreCase(method)) { //到实验课程评价页面
            request.getRequestDispatcher("/WEB-INF/views/others/labcourse.jsp").forward(request, response);
        } else if("toCourseMgrView".equalsIgnoreCase(method)) { //到课程信息管理页面
            request.getRequestDispatcher("/WEB-INF/views/others/coursemgr.jsp").forward(request, response);
        } else if("toClassMgrView".equalsIgnoreCase(method)) { //到班级信息管理页面
            request.getRequestDispatcher("/WEB-INF/views/others/classmgr.jsp").forward(request, response);
        } else if("toRoomMgrView".equalsIgnoreCase(method)) { //到教室管理页面
            request.getRequestDispatcher("/WEB-INF/views/others/roommgr.jsp").forward(request, response);
        } else if("toTeacherMgrView".equalsIgnoreCase(method)) { //到教师管理页面
            request.getRequestDispatcher("/WEB-INF/views/others/teachermgr.jsp").forward(request, response);
        } else if("toTSMemberMgrView".equalsIgnoreCase(method)) { //到督导员管理页面
            request.getRequestDispatcher("/WEB-INF/views/others/tsmembermgr.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("getTasksList".equalsIgnoreCase(method)){ //获取所有听课任务
            getTasksList(request, response);
        } else if("EditPassword".equalsIgnoreCase(method)){ //修改密码
            editPassword(request, response);
        } else if("editSystemimformation".equalsIgnoreCase(method)){ //修改系统信息
            editSystemimformation(request, response);
        }
    }

    private void editSystemimformation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String value = request.getParameter("value");
        Systemimformation sys = service.editSystemImformation(name, value);
        //放到域中
        request.getSession().getServletContext().setAttribute("systemInfo", sys);
        response.getWriter().write("success");
    }

    private void editPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Users user = new Users();
        user.setUsername(request.getParameter("username"));
        user.setPassword(EncryptionUtil.MD5(request.getParameter("password")));
        service.editPassword(user);
        response.getWriter().write("success");
    }

    /**
     * 退出系统
     * @param request
     * @param response
     * @throws IOException
     * @throws ServletException
     */
    private void loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //退出系统时清除系统登录的用户
            request.getSession().removeAttribute("user");
            String contextPath = request.getContextPath();
            //转发到登录页面
            response.sendRedirect(contextPath+"/index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void getTasksList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String result = service.getTasksList();
        //返回数据
        response.getWriter().write(result);
    }

}
