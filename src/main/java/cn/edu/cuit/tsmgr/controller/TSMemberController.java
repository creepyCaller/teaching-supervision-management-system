package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Sgmembers;
import cn.edu.cuit.tsmgr.service.impl.TSMemberService;
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
@WebServlet("/TSMemberController")
public class TSMemberController extends HttpServlet implements BaseControllerInter{
    private static final long serialVersionUID = 1L;
    private TSMemberService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new TSMemberService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("TSMemberList".equalsIgnoreCase(method)){ //获取所有教师数据
            TSMemberList(request, response);
        } else if("AddTSMember".equalsIgnoreCase(method)){ //添加教师
            addTSMember(request, response);
        } else if("DeleteTSMember".equalsIgnoreCase(method)){ //删除教师
            deleteTSMember(request, response);
        } else if("EditTSMember".equalsIgnoreCase(method)){ //修改教师信息
            editTSMember(request, response);
        }
    }

    private void deleteTSMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] ids = request.getParameterValues("ids[]");
        try {
            service.deleteTSMember(ids);
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
    }

    private void addTSMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Sgmembers sgmembers = new Sgmembers();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(sgmembers, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.addTSMember(sgmembers);
        response.getWriter().write("success");
    }

    private void editTSMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Sgmembers sgmembers = new Sgmembers();
        try {
            sgmembers.setId(Integer.valueOf(request.getParameter("id")));
        } catch (Exception e)
        {
            response.getWriter().write("id_err");
        }
        sgmembers.setSgmname(request.getParameter("sgmname"));
        service.editTSMember(sgmembers, request.getParameter("eid"));
        response.getWriter().write("success");
    }


    private void TSMemberList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.getTSMemberList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }

}