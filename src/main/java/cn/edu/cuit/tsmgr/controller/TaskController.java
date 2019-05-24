package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Tasks;
import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.service.impl.TaskService;
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
@WebServlet("/TaskController")
public class TaskController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;

    private TaskService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new TaskService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("RTaskList".equalsIgnoreCase(method)){
            rTaskList(request, response);
        } else if("FTaskList".equalsIgnoreCase(method)){ //添加教师
            fTaskList(request, response);
        } else if("AddTask".equalsIgnoreCase(method)){ //添加教师
            addTask(request, response);
        } else if("DeleteTask".equalsIgnoreCase(method)){ //删除教师
            deleteTask(request, response);
        } else if("EditTask".equalsIgnoreCase(method)){ //修改教师信息
            editTask(request, response);
        } else if("toCommentPage".equalsIgnoreCase(method)){ //去评论页
            toCommentPage(request, response);
        }
    }

    private void fTaskList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取用户类型
        Users user = (Users) request.getSession().getAttribute("user");
        //获取数据
        String result = service.getFTaskList(new Page(page, rows), user);
        //返回数据
        response.getWriter().write(result);
    }

    private void rTaskList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取用户类型
        Users user = (Users) request.getSession().getAttribute("user");
        //获取数据
        String result = service.getRTaskList(new Page(page, rows), user);
        //返回数据
        response.getWriter().write(result);
    }

    private void toCommentPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Enumeration<String> pNames = request.getParameterNames();
        Tasks task = new Tasks();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(task, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if(request.getSession().getAttribute("task") != null) {
            request.getSession().removeAttribute("task");
        }
        request.getSession().setAttribute("task", task);
        if(task.getClasstype() == 0 && task.getFinished() == 0) {
            response.getWriter().write("0");
        } else if(task.getClasstype() == 1 && task.getFinished() == 0) {
            response.getWriter().write("1");
        } else if(task.getFinished() == 1) {
            response.getWriter().write("2");
        }
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Tasks task = new Tasks();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(task, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.editTask(task, Integer.valueOf(request.getParameter("id")));
        response.getWriter().write("success");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] ids = request.getParameterValues("ids[]");
        try {
            service.deleteTask(ids);
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Tasks task = new Tasks();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(task, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.addTask(task);
        response.getWriter().write("success");
    }

}
