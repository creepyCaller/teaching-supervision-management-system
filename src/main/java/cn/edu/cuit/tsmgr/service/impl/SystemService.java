package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.BaseDao;
import cn.edu.cuit.tsmgr.model.Systemimformation;
import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.service.SystemServiceInter;
import org.springframework.stereotype.Service;

@Service
public class SystemService implements SystemServiceInter {
    //private ApplicationContext applicationContext;
    //private UsersMapper usersmapper;

    /**
     * 获取听课任务列表
     *
     * @return
     */
    @Override
    public String getTasksList() {
        return null;
    }

    /**
     * 登录验证
     * @param user
     * @return
     */
    @Override
    public Users checkUser(Users user) {
        /*
        // 加载spring配置文件
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        usersmapper = applicationContext.getBean(UsersMapper.class);
        return usersmapper.selectByPrimaryKey(user.getUsername());
         */
        return (Users) new BaseDao().getObject(Users.class, "SELECT * FROM users WHERE username=?", new Object[]{user.getUsername()});
    }

    /**
     * 修改密码
     * @param user 传入的储存了待修改密码和用户名的POJO
     *
     */
    @Override
    public int editPassword(Users user) {
        /*
        // 加载spring配置文件
        applicationContext = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
        usersmapper = applicationContext.getBean(UsersMapper.class);
        return usersmapper.updateByPrimaryKeySelective(user);
         */
        new BaseDao().update("UPDATE users SET password=? WHERE username=?", new Object[]{user.getPassword(),user.getUsername()});
        return 1;
    }

    /**
     * 修改系统信息
     * @param name 修改的名称
     * @param value 值
     * @return 返回修改后的系统信息POJO对象
     */
    @Override
    public Systemimformation editSystemImformation(String name, String value) {
        //修改数据库
        BaseDao dao = new BaseDao();
        if(name.equals("forbidTeacherRegiste")) {
            name = "forbidteacher";
        }
        if(name.equals("forbidTSMemberRegiste")) {
            name = "forbidtsmember";
        }
        dao.update("UPDATE systemimformation SET "+name+"=?", new Object[]{value});
        //重新加载数据
        //获取系统初始化对象
        return (Systemimformation) dao.getObject(Systemimformation.class, "SELECT * FROM systemimformation WHERE id=1", null);
    }

    /**
     * 新增用户
     *
     * @param user
     */
    @Override
    public int registe(Users user) {
        new BaseDao().insert("INSERT INTO users(username,password,registedate,type) value(?,?,?,?)", new Object[]{user.getUsername(),user.getPassword(),user.getRegistedate(),user.getType()});
        return 1;
    }
}
