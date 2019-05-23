package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Teachers;
import cn.edu.cuit.tsmgr.service.impl.TeacherService;
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
@WebServlet("/TeacherController")
public class TeacherController extends HttpServlet implements BaseControllerInter{
    private static final long serialVersionUID = 1L;
    private TeacherService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new TeacherService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("TeacherList".equalsIgnoreCase(method)){ //获取所有教师数据
            TeacherList(request, response);
        } else if("AddTeacher".equalsIgnoreCase(method)){ //添加教师
            addTeacher(request, response);
        } else if("DeleteTeacher".equalsIgnoreCase(method)){ //删除教师
            deleteTeacher(request, response);
        } else if("EditTeacher".equalsIgnoreCase(method)){ //修改教师信息
            editTeacher(request, response);
        }
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] ids = request.getParameterValues("ids[]");
        try {
            service.deleteTeacher(ids);
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
    }

    private void addTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Teachers teacher = new Teachers();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(teacher, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.addTeacher(teacher);
        response.getWriter().write("success");
    }

    private void editTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Teachers teacher = new Teachers();
        try {
            teacher.setId(Integer.valueOf(request.getParameter("id")));
        } catch (Exception e)
        {
            response.getWriter().write("id_err");
        }
        teacher.setTeachername(request.getParameter("teachername"));
        service.editTeacher(teacher, request.getParameter("eid"));
        response.getWriter().write("success");
    }

    private void TeacherList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.getTeacherList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }

}
