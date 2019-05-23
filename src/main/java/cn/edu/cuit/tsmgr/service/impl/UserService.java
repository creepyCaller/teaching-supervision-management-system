package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.UserDao;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import cn.edu.cuit.tsmgr.util.StringTool;
import net.sf.json.JSONObject;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class UserService {

    private UserDao dao;

    public UserService(){
        dao = new UserDao();
    }

    public String getUserList(Page page) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM users ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY username DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Users> list = dao.getUsersList(sql, param);
        //获取总记录数
        long total = getCount();
        //定义Map
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        //total键 存放总记录数，必须的
        jsonMap.put("total", total);
        //rows键 存放每页记录 list
        jsonMap.put("rows", list);
        //格式化Map,以json格式返回数据
        //返回
        return JSONObject.fromObject(jsonMap).toString();
    }

    private long getCount() {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM users ");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        return (long) dao.count(sql, param).intValue();
    }

    public void deleteUsers(String[] unames) throws SQLException {
        String mark = StringTool.getMark(unames.length);
        Connection conn = MysqlTool.getConnection();
        //开启事务
        MysqlTool.startTransaction();
        try {
            //删除用户
            dao.deleteTransaction(conn, "DELETE FROM users WHERE username IN("+mark+")", unames);
            //提交事务
            MysqlTool.commit();
        } catch (Exception e) {
            //回滚事务
            MysqlTool.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            MysqlTool.closeConnection();
        }
    }

    public String teacherUserList(Page page) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM users ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY username DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Users> list = dao.teacherUserList(sql, param);
        //获取总记录数
        long total = getCount();
        //定义Map
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        //total键 存放总记录数，必须的
        jsonMap.put("total", total);
        //rows键 存放每页记录 list
        jsonMap.put("rows", list);
        //格式化Map,以json格式返回数据
        //返回
        return JSONObject.fromObject(jsonMap).toString();
    }
}
