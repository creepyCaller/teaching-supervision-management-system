package cn.edu.cuit.tsmgr.dao.jdbc;

import cn.edu.cuit.tsmgr.model.Courses;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import org.apache.commons.beanutils.BeanUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class CourseDao extends BaseDao {
    public List<Courses> getCourseList(String sql, List<Object> param) {
        //数据集合
        List<Courses> list = new LinkedList<>();
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
            while(rs.next())
            {
                //创建对象
                Courses courses = new Courses();
                //遍历每个字段
                for(int i=1;i <= meta.getColumnCount();i++){
                    String field = meta.getColumnName(i);
                    BeanUtils.setProperty(courses, field, rs.getObject(field));
                }
                //添加到集合
                list.add(courses);
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
