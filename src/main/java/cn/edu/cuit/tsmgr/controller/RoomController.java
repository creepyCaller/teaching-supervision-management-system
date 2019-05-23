package cn.edu.cuit.tsmgr.controller;

import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Rooms;
import cn.edu.cuit.tsmgr.service.impl.RoomService;
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
@WebServlet("/RoomController")
public class RoomController extends HttpServlet implements BaseControllerInter {
    private static final long serialVersionUID = 1L;
    private RoomService service;

    @Override
    public void init() throws ServletException {
        super.init();
        service = new RoomService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的方法
        String method = request.getParameter("method");
        if("RoomList".equalsIgnoreCase(method)){ //获取所有教师数据
            roomList(request, response);
        } else if("AddRoom".equalsIgnoreCase(method)){ //添加教师
            addRoom(request, response);
        } else if("DeleteRoom".equalsIgnoreCase(method)){ //删除教师
            deleteRoom(request, response);
        } else if("EditRoom".equalsIgnoreCase(method)){ //修改教师信息
            editRoom(request, response);
        }
    }

    private void editRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Rooms room = new Rooms();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(room, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.editRoom(room, request.getParameter("eroomlocation"));
        response.getWriter().write("success");
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] roomlocations = request.getParameterValues("roomlocations[]");
        try {
            service.deleteRoom(roomlocations);
            response.getWriter().write("success");
        } catch (Exception e) {
            response.getWriter().write("fail");
            e.printStackTrace();
        }
    }

    private void addRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取参数名
        Enumeration<String> pNames = request.getParameterNames();
        Rooms room = new Rooms();
        while(pNames.hasMoreElements()){
            String pName = pNames.nextElement();
            String value = request.getParameter(pName);
            try {
                BeanUtils.setProperty(room, pName, value);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        service.addRoom(room);
        response.getWriter().write("success");
    }

    private void roomList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取分页参数
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        //获取数据
        String result = service.getRoomList(new Page(page, rows));
        //返回数据
        response.getWriter().write(result);
    }

}
