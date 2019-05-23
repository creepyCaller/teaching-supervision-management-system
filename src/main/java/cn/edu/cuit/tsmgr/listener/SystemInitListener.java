package cn.edu.cuit.tsmgr.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import cn.edu.cuit.tsmgr.dao.jdbc.BaseDao;
import cn.edu.cuit.tsmgr.model.Systemimformation;
import cn.edu.cuit.tsmgr.dao.SystemimformationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

/**
 * 系统初始化
 * @author fpc
 *
 */
@Component
public class SystemInitListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce)  { 
    	ServletContext application = sce.getServletContext();
    	/*
        // 加载spring配置文件
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        mapper = applicationContext.getBean(SystemimformationMapper.class);
    	//获取系统初始化对象
        Systemimformation sys = mapper.selectByPrimaryKey(1);
        */
    	//放到域中
    	application.setAttribute("systemInfo", (Systemimformation) new BaseDao().getObject(Systemimformation.class, "SELECT * FROM systemimformation", null));
    }
}
