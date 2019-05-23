package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.BaseDao;
import cn.edu.cuit.tsmgr.model.Labclassevaluatetables;
import cn.edu.cuit.tsmgr.model.Normalclassevaluatetables;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import org.apache.commons.beanutils.BeanUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class ViewService {
    public Normalclassevaluatetables getNor(int id) {
        return (Normalclassevaluatetables) new BaseDao().getObject(Normalclassevaluatetables.class, "SELECT * FROM normalclassevaluatetables WHERE id="+id, null);
    }

    public Labclassevaluatetables getLab(int id) {
        return (Labclassevaluatetables) new BaseDao().getObject(Labclassevaluatetables.class, "SELECT * FROM labclassevaluatetables WHERE id="+id, null);
    }

    public String getNorJSON(Integer ntid) {
        StringBuilder ret = new StringBuilder();
        ret.append("{");
        try {
            //获取数据库连接
            Connection conn = MysqlTool.getConnection();
            //预编译
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM normalclassevaluatetables WHERE id="+ntid);
            //执行sql语句
            ResultSet rs = ps.executeQuery();
            //获取元数据
            ResultSetMetaData meta = rs.getMetaData();
            //遍历结果集
            while(rs.next())
            {
                int i=1;
                //遍历每个字段
                for(;i < meta.getColumnCount();i++){
                    String field = meta.getColumnName(i);
                    Number switchNum;
                    Integer switchInt;
                    String switchStr = null;
                    switch (field) {
                        case "teachercondition":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 2:
                                    switchStr = "提前5分钟以上进教室准备";
                                    break;
                                case 1:
                                    switchStr = "早退";
                                    break;
                                case 0:
                                    switchStr = "迟到";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case "classatomspere":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 3:
                                    switchStr = "活跃";
                                    break;
                                case 2:
                                    switchStr = "沉闷";
                                    break;
                                case 1:
                                    switchStr = "轻松";
                                    break;
                                case 0:
                                    switchStr = "安静";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case "studentscondition":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 2:
                                    switchStr = "大多数认真听讲";
                                    break;
                                case 1:
                                    switchStr = "一半认真听讲";
                                    break;
                                case 0:
                                    switchStr = "只有少数人听";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case "playphone":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 2:
                                    switchStr = "少数玩手机";
                                    break;
                                case 1:
                                    switchStr = "部分玩手机";
                                    break;
                                case 0:
                                    switchStr = "较多玩手机";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case  "bookcondition":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 3:
                                    switchStr = "学生手上无资料教材";
                                    break;
                                case 2:
                                    switchStr = "学生手上有分发资料";
                                    break;
                                case 1:
                                    switchStr = "学生手上有自编讲义";
                                    break;
                                case 0:
                                    switchStr = "学生手上有正式教材";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case "lookupcondition":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 2:
                                    switchStr = "只有少学生抬头看老师";
                                    break;
                                case 1:
                                    switchStr = "半数左右学生抬头看老师";
                                    break;
                                case 0:
                                    switchStr = "大多数学生抬头看老师";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case "sitecondition":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 2:
                                    switchStr = "学生主要选择教室中后部分就座";
                                    break;
                                case 1:
                                    switchStr = "前三排座位空余较多";
                                    break;
                                case 0:
                                    switchStr = "前3排基本坐满";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        case "teachingshape":
                            switchNum = (Number) rs.getObject(field);
                            switchInt = switchNum.intValue();
                            switch (switchInt) {
                                case 2:
                                    switchStr = "完全单向教师讲、学生听";
                                    break;
                                case 1:
                                    switchStr = "有讨论、提问交流等互动";
                                    break;
                                case 0:
                                    switchStr = "有探究法或其他新教学模式应用";
                                    break;
                            }
                            ret.append("\"").append(field).append("\":").append("\"").append(switchStr).append("\"").append(",");
                            break;
                        default:
                            ret.append("\"").append(field).append("\":").append("\"").append(rs.getObject(field)).append("\"").append(",");
                            break;
                    }

                }
                String field = meta.getColumnName(i);
                ret.append("\"").append(field).append("\":").append("\"").append(rs.getObject(field)).append("\"");
            }
            //关闭连接
            MysqlTool.closeConnection();
            MysqlTool.close(ps);
            MysqlTool.close(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ret.append("}");
        return ret.toString();
    }

    public String getLabJSON(Integer ntid) {
        StringBuilder ret = new StringBuilder();
        ret.append("{");
        try {
            //获取数据库连接
            Connection conn = MysqlTool.getConnection();
            //预编译
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM labclassevaluatetables WHERE id="+ntid);
            //执行sql语句
            ResultSet rs = ps.executeQuery();
            //获取元数据
            ResultSetMetaData meta = rs.getMetaData();
            //遍历结果集
            while(rs.next())
            {
                int i=1;
                //遍历每个字段
                for(;i < meta.getColumnCount();i++){
                    String field = meta.getColumnName(i);
                    if(field.equals("labmgrlevel")) {
                        String labmgrlevel = null;
                        Number switchNum = (Number) rs.getObject(field);
                        switch (switchNum.intValue()) {
                            case 4:
                                labmgrlevel = "优";
                                break;
                            case 3:
                                labmgrlevel = "良";
                                break;
                            case 2:
                                labmgrlevel = "一般";
                                break;
                            case 1:
                                labmgrlevel = "中下";
                                break;
                            case 0:
                                labmgrlevel = "差";
                                break;
                        }
                        ret.append("\"").append(field).append("\":").append("\"").append(labmgrlevel).append("\"").append(",");
                    } else {
                        ret.append("\"").append(field).append("\":").append("\"").append(rs.getObject(field)).append("\"").append(",");
                    }
                }
                String field = meta.getColumnName(i);
                ret.append("\"").append(field).append("\":").append("\"").append(rs.getObject(field)).append("\"");
            }
            //关闭连接
            MysqlTool.closeConnection();
            MysqlTool.close(ps);
            MysqlTool.close(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ret.append("}");
        return ret.toString();
    }

}
