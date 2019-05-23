package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.SgmembersMapper;
import cn.edu.cuit.tsmgr.dao.TeachersMapper;
import cn.edu.cuit.tsmgr.dao.UsersMapper;
import cn.edu.cuit.tsmgr.model.Sgmembers;
import cn.edu.cuit.tsmgr.model.Teachers;
import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.service.SaveNameServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

@Service
public class SaveNameService implements SaveNameServiceInter{
    private ApplicationContext applicationContext;
    private static final long serialVersionUID = 1L;
    @Autowired
    UsersMapper usersMapper;

    /**
     * 保存教师名称到Users表和Teachers表
     *
     */
    @Override
    public int saveTeacherName(String username, String name) {
        // 加载spring配置文件
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        usersMapper = applicationContext.getBean(UsersMapper.class);
        TeachersMapper teachersMapper = applicationContext.getBean(TeachersMapper.class);
        Users user = new Users();
        Teachers teachers = new Teachers();
        user.setUsername(username);
        user.setTeachername(name);
        teachers.setTeachername(name);
        usersMapper.updateByPrimaryKeySelective(user);
        teachersMapper.insert(teachers);
        return 0;
    }

    /**
     * 保存督导员名称到Users表和Teachers表
     *
     */
    @Override
    public int saveTSMemberName(String username, String name) {
        // 加载spring配置文件
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        usersMapper = applicationContext.getBean(UsersMapper.class);
        SgmembersMapper sgmembersMapper = applicationContext.getBean(SgmembersMapper.class);
        Users user = new Users();
        Sgmembers sgmembers = new Sgmembers();
        user.setUsername(username);
        user.setSgmname(name);
        sgmembers.setSgmname(name);
        usersMapper.updateByPrimaryKeySelective(user);
        sgmembersMapper.insert(sgmembers);
        return 0;
    }
}
