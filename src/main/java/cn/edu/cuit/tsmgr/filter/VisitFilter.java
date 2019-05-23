package cn.edu.cuit.tsmgr.filter;

import cn.edu.cuit.tsmgr.model.Users;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 拦截器
 * 如果用户没有登录就访问某些页面，遣返其回登录界面
 *
 */
@Component
public class VisitFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse rep, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) rep;
        Users user = (Users) request.getSession().getAttribute("user");
        String contextPath = request.getContextPath();
        if(user != null){
            chain.doFilter(request, response);
        } else {
            response.sendRedirect(contextPath+"/index.jsp");
        }
    }
}
