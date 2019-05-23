package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.AddAdminDao;
import cn.edu.cuit.tsmgr.model.Users;

public class AddAdminService {

    private AddAdminDao dao;

    public void addAdmin(Users user) {
        //添加记录
        dao = new AddAdminDao();
        dao.update("INSERT INTO users(username,password,registedate,type) value(?,?,?,?)",
                new Object[]{
                        user.getUsername(), user.getPassword(),user.getRegistedate(), Users.USER_ADMIN
                });
    }
}
