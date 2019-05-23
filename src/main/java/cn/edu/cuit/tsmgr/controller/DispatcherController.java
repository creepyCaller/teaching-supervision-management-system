package cn.edu.cuit.tsmgr.controller;

import org.springframework.stereotype.Controller;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@WebServlet("/DispatcherController")
public class DispatcherController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("toUserMgrView".equalsIgnoreCase(method)) { //到用户管理
            request.getRequestDispatcher("/WEB-INF/views/admin/usermgr.jsp").forward(request, response);
        } else if("toAddAdminView".equalsIgnoreCase(method)) { //到添加管理员
            request.getRequestDispatcher("/WEB-INF/views/admin/addadmin.jsp").forward(request, response);
        } else if("toFinishedTskView".equalsIgnoreCase(method)) {
            request.getRequestDispatcher("/WEB-INF/views/others/finishedtsk.jsp").forward(request, response);
        }
    }

}
