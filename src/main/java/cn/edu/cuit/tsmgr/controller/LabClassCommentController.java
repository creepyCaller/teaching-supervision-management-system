package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Addlab;
import cn.edu.cuit.tsmgr.service.impl.LabClassCommentService;
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
@WebServlet("/LabClassCommentController")
public class LabClassCommentController extends HttpServlet implements BaseControllerInter {

    LabClassCommentService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new LabClassCommentService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("CommitComment".equalsIgnoreCase(method)){
            commitComment(request, response);
        }
    }

    private void commitComment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Addlab al = new Addlab();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(al, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        al.setGenerallevel(al.getT1()+al.getT2()+al.getT3()+al.getT4()+al.getT5()+al.getT6()+al.getT7()+al.getT8());
        service.commitComment(al);
        response.getWriter().write("success");
    }

}
