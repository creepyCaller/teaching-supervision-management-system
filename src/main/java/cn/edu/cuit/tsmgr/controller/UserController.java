package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.service.impl.UserService;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@WebServlet("/UserController")
public class UserController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;

    private UserService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new UserService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("UserList".equalsIgnoreCase(method)) {
            userList(request, response);
        } else if("TeacherUserList".equalsIgnoreCase(method)) {
            teacherUserList(request, response);
        } else if("DeleteUsers".equalsIgnoreCase(method)) {
            deleteUsers(request, response);
        }
    }

    private void teacherUserList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.teacherUserList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }

    private void deleteUsers(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] unames = request.getParameterValues("unames[]");
        try {
            service.deleteUsers(unames);
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
    }

    private void userList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.getUserList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }
}
