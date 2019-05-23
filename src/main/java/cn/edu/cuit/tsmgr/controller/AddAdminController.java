package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.service.impl.AddAdminService;
import cn.edu.cuit.tsmgr.util.EncryptionUtil;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;

@Controller
@WebServlet("/AddAdminController")
public class AddAdminController extends HttpServlet implements BaseControllerInter  {
    private static final long serialVersionUID = 1L;

    private AddAdminService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new AddAdminService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("AddAdmin".equalsIgnoreCase(method)) {
            addAdmin(request, response);
        }
    }

    private void addAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Users user = new Users();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(user, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //将密码进行MD5加密
        user.setPassword(EncryptionUtil.MD5(user.getPassword()));
        user.setRegistedate(new java.sql.Date(new Date().getTime()));
        service.addAdmin(user);
        response.getWriter().write("success");
    }
}
