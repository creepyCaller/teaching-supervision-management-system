package cn.edu.cuit.tsmgr.dao.jdbc;

import cn.edu.cuit.tsmgr.model.Tasks;
import cn.edu.cuit.tsmgr.model.Users;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import org.apache.commons.beanutils.BeanUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.LinkedList;
import java.util.List;

public class TaskDao extends BaseDao{

    public List<Tasks> getFTaskList(String sql, List<Object> param, Users user) {
        //数据集合
        List<Tasks> list = new LinkedList<>();
        try {
            //获取数据库连接
            Connection conn = MysqlTool.getConnection();
            //预编译
            PreparedStatement ps = conn.prepareStatement(sql);
            //设置参数
            if(param != null && param.size() > 0){
                for(int i = 0;i < param.size();i++){
                    ps.setObject(i+1, param.get(i));
                }
            }
            //执行sql语句
            ResultSet rs = ps.executeQuery();
            //获取元数据
            ResultSetMetaData meta = rs.getMetaData();
            //遍历结果集
            if(user.getType() == Users.USER_TEACHER) {
                while (rs.next()) {
                    //创建对象
                    Tasks tasks = new Tasks();
                    //遍历每个字段
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        String field = meta.getColumnName(i);
                        BeanUtils.setProperty(tasks, field, rs.getObject(field));
                    }
                    //如果属于自己的任务则添加到集合
                    if(user.getName().equals(tasks.getTaskexecuter())) {
                        if (tasks.getFinished() == 1) {
                            //如果任务已完成
                            list.add(tasks);
                        }
                    }
                }
            } else {
                while (rs.next()) {
                    //创建对象
                    Tasks tasks = new Tasks();
                    //遍历每个字段
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        String field = meta.getColumnName(i);
                        BeanUtils.setProperty(tasks, field, rs.getObject(field));
                    }
                    //添加到集合,除了教师之外的角色都能看到所有人的任务
                    if (tasks.getFinished() == 1) {
                        //如果任务已完成
                        list.add(tasks);
                    }
                }
            }
            //关闭连接
            MysqlTool.closeConnection();
            MysqlTool.close(ps);
            MysqlTool.close(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Tasks> getRTaskList(String sql, List<Object> param, Users user) {
        //数据集合
        List<Tasks> list = new LinkedList<>();
        try {
            //获取数据库连接
            Connection conn = MysqlTool.getConnection();
            //预编译
            PreparedStatement ps = conn.prepareStatement(sql);
            //设置参数
            if(param != null && param.size() > 0){
                for(int i = 0;i < param.size();i++){
                    ps.setObject(i+1, param.get(i));
                }
            }
            //执行sql语句
            ResultSet rs = ps.executeQuery();
            //获取元数据
            ResultSetMetaData meta = rs.getMetaData();
            //遍历结果集
            if(user.getType() == Users.USER_TEACHER) {
                while (rs.next()) {
                    //创建对象
                    Tasks tasks = new Tasks();
                    //遍历每个字段
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        String field = meta.getColumnName(i);
                        BeanUtils.setProperty(tasks, field, rs.getObject(field));
                    }
                    //如果属于自己的任务则添加到集合
                    if(user.getName().equals(tasks.getTaskexecuter())) {
                        if (tasks.getFinished() == 0) {
                            //如果任务未完成
                            list.add(tasks);
                        }
                    }
                }
            } else {
                while (rs.next()) {
                    //创建对象
                    Tasks tasks = new Tasks();
                    //遍历每个字段
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        String field = meta.getColumnName(i);
                        BeanUtils.setProperty(tasks, field, rs.getObject(field));
                    }
                    //添加到集合,除了教师之外的角色都能看到所有人的任务
                    if (tasks.getFinished() == 0) {
                        //如果任务未完成
                        list.add(tasks);
                    }
                }
            }
            //关闭连接
            MysqlTool.closeConnection();
            MysqlTool.close(ps);
            MysqlTool.close(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
