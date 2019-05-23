package cn.edu.cuit.tsmgr.dao.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import cn.edu.cuit.tsmgr.model.Teachers;
import cn.edu.cuit.tsmgr.util.MysqlTool;

public class TeacherDao extends BaseDao {
    public List<Teachers> getTeacherList(String sql, List<Object> param) {
        //数据集合
        List<Teachers> list = new LinkedList<>();
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
            while(rs.next()){
                //创建对象
                Teachers teacher = new Teachers();
                //遍历每个字段
                for(int i=1;i <= meta.getColumnCount();i++){
                    String field = meta.getColumnName(i);
                    BeanUtils.setProperty(teacher, field, rs.getObject(field));
                }
                //添加到集合
                list.add(teacher);
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
