package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.service.SaveNameServiceInter;
import cn.edu.cuit.tsmgr.service.SystemServiceInter;
import cn.edu.cuit.tsmgr.service.impl.SaveNameService;
import cn.edu.cuit.tsmgr.service.impl.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@WebServlet("/SaveNameController")
public class SaveNameController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;
    @Autowired
    private SaveNameServiceInter service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new SaveNameService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        try {
            if ("saveTeacherName".equalsIgnoreCase(method)) {
                saveTeacherName(request, response);
            } else if ("saveTSMemberName".equalsIgnoreCase(method)) {
                saveTSMemberName(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void saveTeacherName(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        service.saveTeacherName(username, name);
        response.getWriter().write("success");
    }

    private void saveTSMemberName(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        service.saveTSMemberName(username, name);
        response.getWriter().write("success");
    }


}
