package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Classes;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.service.impl.ClassService;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

@Controller
@WebServlet("/ClassController")
public class ClassController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;
    private ClassService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new ClassService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("ClassList".equalsIgnoreCase(method)){ //获取所有教师数据
            classList(request, response);
        } else if("AddClass".equalsIgnoreCase(method)){ //添加教师
            addClass(request, response);
        } else if("DeleteClass".equalsIgnoreCase(method)){ //删除教师
            deleteClass(request, response);
        } else if("EditClass".equalsIgnoreCase(method)){ //修改教师信息
            editClass(request, response);
        }
    }

    private void editClass(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Classes classes = new Classes();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(classes, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.editClass(classes, request.getParameter("eclassname"));
        response.getWriter().write("success");
    }

    private void deleteClass(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] classes = request.getParameterValues("classes[]");
        try {
            service.deleteClass(classes);
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
    }

    private void addClass(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Classes classes = new Classes();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(classes, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.addClass(classes);
        response.getWriter().write("success");
    }

    private void classList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.getClassList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }

}
