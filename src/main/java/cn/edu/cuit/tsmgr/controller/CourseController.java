package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Courses;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.service.impl.CourseService;
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
@WebServlet("/CourseController")
public class CourseController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;
    private CourseService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new CourseService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("CourseList".equalsIgnoreCase(method)){ //获取所有教师数据
            classList(request, response);
        } else if("AddCourse".equalsIgnoreCase(method)){ //添加教师
            addCourse(request, response);
        } else if("DeleteCourse".equalsIgnoreCase(method)){ //删除教师
            deleteCourse(request, response);
        } else if("EditCourse".equalsIgnoreCase(method)){ //修改教师信息
            editCourse(request, response);
        }
    }

    private void editCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Courses courses = new Courses();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(courses, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.editClass(courses, Integer.valueOf(request.getParameter("id")));
        response.getWriter().write("success");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] ids = request.getParameterValues("ids[]");
        try {
            service.deleteCourse(ids);
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
        response.getWriter().write("success");
    }

    private void addCourse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Courses courses = new Courses();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(courses, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.addCourse(courses);
        response.getWriter().write("success");
    }

    private void classList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.getCourseList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }

}
