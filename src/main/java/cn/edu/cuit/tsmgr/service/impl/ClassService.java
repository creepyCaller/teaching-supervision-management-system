package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.ClassDao;
import cn.edu.cuit.tsmgr.model.Classes;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Teachers;
import cn.edu.cuit.tsmgr.service.BaseServiceInter;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import cn.edu.cuit.tsmgr.util.StringTool;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Service
public class ClassService implements BaseServiceInter {

    private ClassDao dao;

    public ClassService(){
        dao = new ClassDao();
    }


    public String getClassList(Page page) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM classes ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY classname DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Classes> list = dao.getClassList(sql, param);
        //获取总记录数
        long total = getCount();
        //定义Map
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        //total键 存放总记录数，必须的
        jsonMap.put("total", total);
        //rows键 存放每页记录 list
        jsonMap.put("rows", list);
        //格式化Map,以json格式返回数据
        String result = JSONObject.fromObject(jsonMap).toString();
        //返回
        return result;
    }

    private long getCount() {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM classes ");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        long count = dao.count(sql, param).intValue();
        return count;
    }

    public void addClass(Classes classes) {
        //添加记录
        dao.update("INSERT INTO classes(classname,major,school) value(?,?,?)",
                new Object[]{
                        classes.getClassname(),classes.getMajor(),classes.getSchool()
                });
    }

    public void deleteClass(String[] classes) throws SQLException {
        String mark = StringTool.getMark(classes.length);
        Connection conn = MysqlTool.getConnection();
        //开启事务
        MysqlTool.startTransaction();
        try {
            //删除教室
            dao.deleteTransaction(conn, "DELETE FROM classes WHERE classname IN("+mark+")", classes);
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

    public void editClass(Classes classes, String eclassname) {
        //修改表名
        dao.update("UPDATE classes SET classname=?,major=?,school=? WHERE classname=?",
                new Object[]{
                        classes.getClassname(),classes.getMajor(),classes.getSchool(),eclassname
                });
    }
}
