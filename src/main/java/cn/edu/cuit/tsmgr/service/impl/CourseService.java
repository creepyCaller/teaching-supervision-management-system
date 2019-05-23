package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.CourseDao;
import cn.edu.cuit.tsmgr.model.Courses;
import cn.edu.cuit.tsmgr.model.Page;
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
public class CourseService implements BaseServiceInter {

    private CourseDao dao;

    public CourseService(){
        dao = new CourseDao();
    }

    public void editClass(Courses courses, int id) {
        dao.update("UPDATE courses SET coursename=?,school=?,teachername=?,roomlocation=?,lessontype=?,time=?,lessonno=? WHERE id=?",
                new Object[]{
                        courses.getCoursename(),courses.getSchool(),courses.getTeachername(),courses.getRoomlocation(),courses.getLessontype(),courses.getTime(),courses.getLessonno(),id
                });
    }

    public void deleteCourse(String[] ids) throws SQLException {
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
            dao.deleteTransaction(conn, "DELETE FROM courses WHERE id IN("+mark+")", tid);
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

    public void addCourse(Courses courses) {
        //添加记录
        dao.update("INSERT INTO courses(coursename,school,teachername,roomlocation,lessontype,time,lessonno) value(?,?,?,?,?,?,?)",
                new Object[]{
                        courses.getCoursename(),courses.getSchool(),courses.getTeachername(),courses.getRoomlocation(),courses.getLessontype(),courses.getTime(),courses.getLessonno()
                });
    }

    public String getCourseList(Page page) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM courses ");
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
        List<Courses> list = dao.getCourseList(sql, param);
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
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM courses ");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        return (long) dao.count(sql, param).intValue();
    }
}
