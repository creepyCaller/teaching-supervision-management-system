package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Addnor;
import cn.edu.cuit.tsmgr.service.impl.NormalClassCommentService;
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
@WebServlet("/NormalClassCommentController")
public class NormalClassCommentController extends HttpServlet implements BaseControllerInter {

    NormalClassCommentService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new NormalClassCommentService();
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
        Addnor an = new Addnor();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(an, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        an.setGenerallevel(an.getT1()+an.getT2()+an.getT3()+an.getT4()+an.getT5()+an.getT6()+an.getT7()+an.getT8()+an.getT9()+an.getT10());
        service.commitComment(an);
        response.getWriter().write("success");
    }

}
