package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.TaskDao;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Tasks;
import cn.edu.cuit.tsmgr.model.Users;
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
public class TaskService implements BaseServiceInter {

    private TaskDao dao;

    public TaskService(){
        dao = new TaskDao();
    }

    public void addTask(Tasks task) {
        //添加记录
        dao.update("INSERT INTO tasks(taskexecuter,teachername,coursename,roomlocation,time,lessontype,lessonno,classtype,comment,finished,ntid) value(?,?,?,?,?,?,?,?,?,?,?)",
                new Object[]{
                    task.getTaskexecuter(), task.getTeachername(), task.getCoursename(), task.getRoomlocation(), task.getTime(), task.getLessontype(), task.getLessonno(), task.getClasstype(), task.getComment(), task.getFinished(), task.getNtid()
                });
    }

    public void editTask(Tasks task, Integer id) {
        //修改记录
        dao.update("UPDATE tasks SET taskexecuter=?,teachername=?,coursename=?,roomlocation=?,time=?,lessontype=?,lessonno=?,classtype=?,comment=?,finished=?,ntid=? WHERE id=?",
                new Object[]{
                        task.getTaskexecuter(), task.getTeachername(), task.getCoursename(), task.getRoomlocation(), task.getTime(), task.getLessontype(), task.getLessonno(), task.getClasstype(), task.getComment(), task.getFinished(), task.getNtid(), id
                });
    }

    public void deleteTask(String[] ids) throws SQLException {
        String mark = StringTool.getMark(ids.length);
        Integer[] tid = new Integer[ids.length];
        for(int i =0 ;i < ids.length;i++){
            tid[i] = Integer.parseInt(ids[i]);
        }
        Connection conn = MysqlTool.getConnection();
        //开启事务
        MysqlTool.startTransaction();
        try {
            //删除课程
            dao.deleteTransaction(conn, "DELETE FROM tasks WHERE id IN("+mark+")", tid);
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

    public String getFTaskList(Page page, Users user) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM tasks ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY id DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Tasks> list = dao.getFTaskList(sql, param, user);
        //获取总记录数
        long total = getFTCount();
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

    private long getFTCount() {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM tasks WHERE finished=1");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        return (long) dao.count(sql, param).intValue();
    }

    public String getRTaskList(Page page, Users user) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM tasks ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY id DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Tasks> list = dao.getRTaskList(sql, param, user);
        //获取总记录数
        long total = getRTCount();
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

    private long getRTCount() {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM tasks WHERE finished=0");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        return (long) dao.count(sql, param).intValue();
    }
}
