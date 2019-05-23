package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.service.impl.ViewService;
import org.springframework.stereotype.Controller;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@WebServlet("/ViewController")
public class ViewController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;

    ViewService service;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("ViewComment".equalsIgnoreCase(method)){
            viewComment(request, response);
        } else if("GetComment".equalsIgnoreCase(method)){
            getComment(request, response);
        }
    }

    private void getComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer ntid = Integer.valueOf(request.getParameter("ntid"));
        int classtype = Integer.parseInt(request.getParameter("classtype"));
        service = new ViewService();
        if(classtype == 0) {
            String result = service.getNorJSON(ntid);
            response.getWriter().write(result);
        } else if(classtype == 1) {
            String result = service.getLabJSON(ntid);
            response.getWriter().write(result);
        }
    }

    private void viewComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int finished = Integer.parseInt(request.getParameter("finished"));
        int classtype = Integer.parseInt(request.getParameter("classtype"));
        if(classtype == 0 && finished == 1) {
            response.getWriter().write("0");
        } else if(classtype == 1 && finished == 1) {
            response.getWriter().write("1");
        } else if(finished == 0) {
            response.getWriter().write("2");
        }
    }
}
